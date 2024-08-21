import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../providers/member.dart";
import "../../widgets/image_banner.dart";
import "../../widgets/member/member_form.dart";
import "../../widgets/member/primary_trade_list_tile.dart";
import "../../widgets/member/secondary_trade_list_tile.dart";

class MembersScreen extends StatefulWidget {
  const MembersScreen({Key? key}) : super(key: key);

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  late Future<void> _memberStatusFuture;
  late Future<void> _fetchTradesFuture;

  @override
  void initState() {
    _memberStatusFuture =
        Provider.of<Member>(context, listen: false).checkMemberStatus();
    _fetchTradesFuture =
        Provider.of<Member>(context, listen: false).fetchTrades();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isMember = Provider.of<Member>(context).isMember;
    final trades = Provider.of<Member>(context).trades;

    if (trades.isEmpty && isMember) {
      return const ImageBanner(
        imgSrc: "assets/images/gone.png",
        text: "No New Trades!",
      );
    }

    return FutureBuilder(
      future: Future.wait([_memberStatusFuture, _fetchTradesFuture]),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (snapshot.hasError) {
          return const ImageBanner(
            imgSrc: "assets/images/error.png",
            text: "Something Went Wrong!",
          );
        }
        if (!isMember) {
          return const MemberForm();
        }
        return ListView.separated(
          separatorBuilder: (_, i) => i >= 1
              ? const Divider(color: Color(0xFFa0b0ba))
              : const SizedBox(),
          itemBuilder: (ctx, i) {
            int index = trades.length - i - 1;
            if (i == 0) return PrimaryTradeListTile(trades[index]);
            if (i == 1) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Past Trades",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  ),
                  const SizedBox(height: 10),
                  SecondaryTradeListTile(trades[index])
                ],
              );
            }
            return SecondaryTradeListTile(trades[index]);
          },
          itemCount: trades.length,
        );
      },
    );
  }
}
