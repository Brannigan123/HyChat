import 'dart:math';

import 'package:HyChat/models/user_model.dart';
import 'package:HyChat/widgets/contact_tile.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

class OnlineContacts extends StatelessWidget {
  const OnlineContacts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onlineUsers = users.where((user) => user.isOnline).toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: onlineUsers.length,
        itemBuilder: (ctx, index) {
          return DelayedDisplay(
            fadingDuration: Duration(milliseconds: min(3000, 200 * index)),
            slidingBeginOffset: Offset(0.0, 1.0),
            child: ContactTile(user: onlineUsers[index]),
          );
        },
      ),
    );
  }
}
