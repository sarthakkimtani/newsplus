import "package:flutter/material.dart";
import "package:newsplus/widgets/member/trade_list_tile.dart";
import "package:provider/provider.dart";

import "../../providers/member.dart";
import "../../widgets/image_banner.dart";
import "../../widgets/member/member_form.dart";

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
        return ListView.builder(
          itemBuilder: (ctx, i) {
            return TradeListTile(
              title: trades[i].title,
              body: trades[i].body,
            );
          },
          itemCount: trades.length,
        );
      },
    );
  }
}
