import 'package:HyChat/models/message_model.dart';
import 'package:HyChat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ChatTile extends StatefulWidget {
  final Message chat;

  const ChatTile({Key key, @required this.chat}) : super(key: key);

  @override
  _ChatTileState createState() => _ChatTileState(chat: chat);
}

class _ChatTileState extends State<ChatTile> {
  final Message chat;

  _ChatTileState({@required this.chat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
      ),
      child: Material(
        color: chat.incoming ? Color(0xFFFFEFF7) : Color(0xFFDDE8FC),
        borderRadius: chat.incoming
            ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(20.0))
            : BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(20.0)),
        child: InkWell(
          splashColor: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 600),
                type: PageTransitionType.downToUp,
                child: ChatScreen(user: chat.contact),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Hero(
                          tag: 'user ${chat.contact.id} image',
                          child: Material(
                            type: MaterialType.transparency,
                            child: CircleAvatar(
                              radius: 64.0,
                              backgroundImage:
                                  AssetImage(chat.contact.imageUrl),
                            ),
                          ),
                        ),
                      ),
                      chat.contact.isOnline
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'user ${chat.contact.id} name',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            chat.contact.name,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Hero(
                        tag: 'user ${chat.contact.id} recent message',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            chat.text,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chat.time,
                      style: TextStyle(
                          fontSize: 12,
                          color: chat.read
                              ? Theme.of(context).primaryColor
                              : Colors.blueGrey),
                    ),
                    SizedBox(width: 5),
                    chat.incoming
                        ? Container()
                        : Icon(
                            chat.read ? Icons.done_all : Icons.done,
                            size: 15,
                            color: chat.read
                                ? Theme.of(context).primaryColor
                                : Colors.blueGrey,
                          ),
                    SizedBox(
                      height: 5.0,
                    ),
                    !chat.read && chat.incoming
                        ? Container(
                            alignment: Alignment.center,
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '3',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).accentColor),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
