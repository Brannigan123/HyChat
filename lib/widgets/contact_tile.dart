import 'package:HyChat/models/user_model.dart';
import 'package:HyChat/screens/about_screen.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ContactTile extends StatefulWidget {
  final User user;
  ContactTile({Key key, @required this.user}) : super(key: key);

  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
      ),
      child: Material(
        color: Color(0xFFDDE8FC),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomRight: Radius.circular(20.0)),
        child: InkWell(
          splashColor: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.fade,
                child: AboutScreen(user: widget.user),
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
                          tag: 'user ${widget.user.id} image view 2',
                          child: Material(
                            type: MaterialType.transparency,
                            child: CircleAvatar(
                              radius: 64.0,
                              backgroundImage: AssetImage(widget.user.imageUrl),
                            ),
                          ),
                        ),
                      ),
                      widget.user.isOnline
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
                        tag: 'user ${widget.user.id} name view 2',
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            widget.user.name,
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
                      Text(
                        widget.user.mobile,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 12.0,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Hero(
                  tag: 'user ${widget.user.id} fav icon view',
                  child: Material(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.transparent,
                    child: AnimateIcons(
                      startIcon: widget.user.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      endIcon: widget.user.isFavorite
                          ? Icons.favorite_border
                          : Icons.favorite,
                      size: 28,
                      onStartIconPress: () {
                        widget.user.isFavorite = !widget.user.isFavorite;
                        return true;
                      },
                      onEndIconPress: () {
                        widget.user.isFavorite = !widget.user.isFavorite;
                        return true;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
