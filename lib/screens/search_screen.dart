import 'package:HyChat/models/message_model.dart';
import 'package:HyChat/widgets/backgrounds.dart';
import 'package:HyChat/widgets/chat_tile.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchBarController = SearchBarController<Message>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          title: Text(
            'Search',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Stack(children: [
            Positioned.fill(child: Particles()),
            Positioned.fill(
              child: SearchBar(
                searchBarController: _searchBarController,
                minimumChars: 2,
                onSearch: (text) {
                  return Future(() => chats.where((chat) {
                        String term = text.toLowerCase();
                        return chat.contact.name.toLowerCase().contains(term) ||
                            chat.text.toLowerCase().contains(term);
                      }).toList());
                },
                onItemFound: (item, index) => ChatTile(
                  chat: item,
                ),
                placeHolder: Center(
                  child: Icon(
                    Icons.list,
                    color: Colors.black12,
                    size: MediaQuery.of(context).size.shortestSide * 0.3,
                  ),
                ),
                emptyWidget: Center(
                  child: Text(
                    'No Matches',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
                searchBarStyle: SearchBarStyle(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  borderRadius: BorderRadius.circular(30),
                  backgroundColor: Color(0xFFF5F7FB),
                ),
                iconActiveColor: Theme.of(context).primaryColor,
                cancellationWidget:
                    Icon(Icons.clear, color: Theme.of(context).primaryColor),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
