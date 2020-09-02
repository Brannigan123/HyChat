import 'package:HyChat/models/user_model.dart';
import 'package:HyChat/screens/about_screen.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class FavoriteContacts extends StatefulWidget {
  FavoriteContacts({Key key}) : super(key: key);

  @override
  _FavoriteContactsState createState() => _FavoriteContactsState();
}

class _FavoriteContactsState extends State<FavoriteContacts> {
  @override
  Widget build(BuildContext context) {
    final favorites = users.where((user) => user.isFavorite).toList();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Favorite Contacts',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 120.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 12.0),
              itemCount: favorites.length,
              itemBuilder: (ctx, index) {
                return DelayedDisplay(
                  fadingDuration: Duration(milliseconds: 800),
                  slidingBeginOffset: Offset(1.0, 0.0),
                  child: _buildContactPreview(favorites[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactPreview(User user) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              duration: Duration(milliseconds: 700),
              type: PageTransitionType.upToDown,
              child: AboutScreen(user: user),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Hero(
                tag: 'user ${user.id} image view',
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Material(
                        type: MaterialType.transparency,
                        child: CircleAvatar(
                          radius: 64.0,
                          backgroundImage: AssetImage(user.imageUrl),
                        ),
                      ),
                    ),
                    user.isOnline
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Hero(
              tag: 'user ${user.id} name view',
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  user.name,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
