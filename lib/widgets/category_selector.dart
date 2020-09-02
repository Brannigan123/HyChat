import 'package:flutter/material.dart';

import 'backgrounds.dart';

class CategorySelector extends StatefulWidget {
  final Widget persistentTop;
  final Widget messages;
  final Widget online;
  final Widget contacts;
  CategorySelector(
      {Key key, this.persistentTop, this.messages, this.online, this.contacts})
      : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector>
    with SingleTickerProviderStateMixin {
  final _categories = ['Messages', 'Online', 'Contacts'];

  TabController _tabController;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          height: 64.0,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: List.generate(_categories.length, (index) {
                return Tab(
                  child: Text(
                    _categories[index],
                    style: TextStyle(fontSize: 15, letterSpacing: 1.2),
                  ),
                );
              }),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF5F7FB),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: Flex(
              direction: Axis.vertical,
              children: [
                widget.persistentTop,
                Expanded(
                  child: Container(
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
                          Positioned.fill(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                widget.messages,
                                widget.online,
                                widget.contacts
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
