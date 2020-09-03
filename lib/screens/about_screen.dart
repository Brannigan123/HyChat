import 'package:HyChat/models/user_model.dart';
import 'package:HyChat/widgets/backgrounds.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  final User user;

  AboutScreen({Key key, @required this.user}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Particles(),
            ),
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _avatarView(),
                            _nameView(),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          _actions(),
                          SizedBox(height: 16),
                          _infoView()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatarView() {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Hero(
        tag: 'user ${widget.user.id} image view',
        child: Stack(
          children: [
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: CircleAvatar(
                  radius: 96.0,
                  backgroundImage: AssetImage(widget.user.imageUrl),
                ),
              ),
            ),
            widget.user.isOnline
                ? Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(0.8),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _nameView() {
    return Column(
      children: [
        Hero(
          tag: 'user ${widget.user.id} name view',
          child: Material(
            type: MaterialType.transparency,
            child: Text(
              widget.user.name,
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.user.circle,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
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
      ],
    );
  }

  Widget _actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Material(
          borderRadius: BorderRadius.circular(72),
          child: InkWell(
            borderRadius: BorderRadius.circular(72),
            splashColor: Theme.of(context).primaryColor,
            onTap: () {},
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.call,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Material(
          borderRadius: BorderRadius.circular(72),
          child: InkWell(
            borderRadius: BorderRadius.circular(72),
            splashColor: Theme.of(context).primaryColor,
            onTap: () {},
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.message,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: [
          _infoName('Phone'),
          _infoValue(widget.user.mobile),
          _infoName('Location'),
          _infoValue(widget.user.location),
        ],
      ),
    );
  }

  Widget _infoName(String name) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
      child: Text(
        name,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor),
      ),
    );
  }

  Widget _infoValue(String value) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        value,
        style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).accentColor),
      ),
    );
  }
}
