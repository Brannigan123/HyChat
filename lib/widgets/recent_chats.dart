import 'dart:math';

import 'package:HyChat/models/message_model.dart';
import 'package:HyChat/widgets/chat_tile.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class RecentChats extends StatelessWidget {
  const RecentChats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: chats.length,
        itemBuilder: (ctx, index) {
          return DelayedDisplay(
              fadingDuration: Duration(milliseconds: min(3000, 200 * index)),
              slidingBeginOffset: Offset(0.0, 1.0),
              child: ChatTile(
                chat: chats[index],
              ));
        },
      ),
    );
  }
}
