const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { z } = require("zod");

admin.initializeApp();
const messaging = admin.messaging();

const messageSchema = z.object({
  data: z.object({
    ticker: z.string(),
    position: z.enum(["LONG", "SHORT"]),
    currencyCode: z.string().length(3),
    entryPrice: z.string(),
    stopLoss: z.string(),
    takeProfit: z.string(),
  }),
});

exports.sendTradeNotification = functions.https.onRequest(async (req, res) => {
  if (req.method !== "POST") {
    return res.status(405).json({ success: false, message: "Method Not Allowed" });
  }

  try {
    const { data } = messageSchema.parse(req.body);

    const message = {
      data: {
        ticker: data.ticker,
        position: data.position,
        currencyCode: data.currencyCode,
        entryPrice: data.entryPrice,
        stopLoss: data.stopLoss,
        takeProfit: data.takeProfit,
      },
      android: {
        priority: "high",
        notification: {
          sound: "default",
        },
      },
      apns: {
        payload: {
          aps: {
            sound: "default",
            contentAvailable: true,
          },
        },
        headers: {
          "apns-priority": "10",
        },
      },
      topic: "members",
    };

    const response = await messaging.send(message);
    res.status(200).json({ success: true, response });
  } catch (error) {
    if (error instanceof z.ZodError) {
      res.status(400).json({ success: false, error: error.errors });
    } else {
      res.status(500).json({ success: false, error: error.message });
    }
  }
});
