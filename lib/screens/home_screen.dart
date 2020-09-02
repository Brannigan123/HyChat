import 'package:HyChat/screens/search_screen.dart';
import 'package:HyChat/widgets/category_selector.dart';
import 'package:HyChat/widgets/contacts.dart';
import 'package:HyChat/widgets/favorite_contacts.dart';
import 'package:HyChat/widgets/online_contcts.dart';
import 'package:HyChat/widgets/recent_chats.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text(
            'Hy Chat',
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                iconSize: 30.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 700),
                      type: PageTransitionType.fade,
                      child: SearchScreen(),
                    ),
                  );
                }),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: CategorySelector(
          persistentTop: FavoriteContacts(),
          messages: RecentChats(),
          online: OnlineContacts(),
          contacts: Contacts(),
        ),
      ),
    );
  }
}
