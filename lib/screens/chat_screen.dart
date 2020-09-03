import 'package:HyChat/models/message_model.dart';
import 'package:HyChat/models/user_model.dart';
import 'package:HyChat/widgets/backgrounds.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_keyboard_size/screen_height.dart';
import 'about_screen.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  final messages = <Message>[...chats];

  ChatScreen({Key key, this.user}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = widget.user;
    final List<Message> messages = widget.messages;

    return KeyboardSizeProvider(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: _buildTitle(user),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Stack(
                children: [
                  Positioned.fill(child: Particles()),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (ctx, index) {
                                Widget tile =
                                    _buildMessageContainer(messages[index]);
                                return index == 0
                                    ? Hero(
                                        tag: 'user ${user.id} recent message',
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: tile,
                                        ),
                                      )
                                    : tile;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 72,
                            child: _buildInputBar(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(User user) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              duration: Duration(milliseconds: 700),
              type: PageTransitionType.scale,
              child: AboutScreen(user: widget.user),
            ),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: 'user ${user.id} image',
              child: Material(
                type: MaterialType.transparency,
                child: CircleAvatar(
                  radius: 18.0,
                  backgroundImage: AssetImage(user.imageUrl),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'user ${user.id} name',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      user.name,
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      softWrap: false,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Text(
                  user.isOnline ? 'online' : 'offline',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContainer(Message message) {
    bool isMe = !message.incoming;

    Widget info = isMe
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                message.read ? Icons.done_all : Icons.done,
                size: 15,
                color: message.read
                    ? Theme.of(context).primaryColor
                    : Colors.blueGrey,
              ),
              Text(
                'me',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 11,
                ),
              ),
            ],
          )
        : CircleAvatar(
            radius: 14.0,
            backgroundImage: AssetImage(widget.user.imageUrl),
          );

    Widget content = Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .65),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
      decoration: isMe
          ? BoxDecoration(
              color: Color(0xFFDDE8FC),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0)),
            )
          : BoxDecoration(
              color: Color(0xFFFFEFF7),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.text,
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            message.time,
            style: TextStyle(
              color: Colors.blueGrey.shade300,
              fontSize: 10,
            ),
          )
        ],
      ),
    );

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: isMe
          ? [content, SizedBox(width: 8.0), info]
          : [info, SizedBox(width: 8.0), content],
    );
  }

  Widget _buildInputBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              padding: EdgeInsets.all(2.0),
              icon: Icon(
                Icons.image,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _inputController,
                maxLines: 5,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "Type Something...",
                  contentPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                ),
                onSubmitted: (txt) => _sendText(),
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              padding: EdgeInsets.all(2.0),
              icon: Icon(
                Icons.send,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: _sendText,
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              padding: EdgeInsets.all(2.0),
              icon: Icon(
                Icons.attach_file,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  void _sendText() {
    String text = _inputController.text;
    if (text.isNotEmpty)
      setState(() {
        widget.messages.insert(
          0,
          Message(
            contact: widget.user,
            time: TimeOfDay.now().format(context),
            text: text,
            incoming: false,
            read: false,
          ),
        );
        _inputController.clear();
      });
  }
}
