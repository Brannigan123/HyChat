import 'package:flutter/cupertino.dart';

class User {
  final int id;
  final String name;
  final String imageUrl;
  final String mobile;
  final String circle;
  final String location;
  bool isFavorite;
  bool isOnline;

  User(
      {@required this.id,
      @required this.name,
      @required this.imageUrl,
      this.mobile = '000 0000 000',
      this.circle = 'Acquintance',
      this.location = "Pearl City, Hawai'i",
      this.isFavorite = false,
      this.isOnline = true});
}

final User sam = User(
  id: 0,
  name: "Bishop",
  imageUrl: "assets/images/bishop.png",
  isFavorite: true,
);

final User gavin = User(
  id: 1,
  name: "Gavin",
  imageUrl: "assets/images/gavin.png",
  isFavorite: true,
);

final User emily = User(
    id: 2,
    name: "Emily",
    imageUrl: "assets/images/emily.png",
    circle: 'Family',
    isFavorite: true,
    isOnline: false);

final User benji = User(
  id: 3,
  name: "Benji",
  imageUrl: "assets/images/benji.png",
  circle: 'Family',
  isOnline: false,
);

final User phil = User(
  id: 4,
  name: "Phil",
  imageUrl: "assets/images/phil.png",
);

final User syd = User(
  id: 5,
  name: "Syd",
  imageUrl: "assets/images/syd.jpeg",
);

final User sophie = User(
  id: 6,
  name: "Sophie",
  imageUrl: "assets/images/sofie.jpeg",
  circle: 'Friend',
  isOnline: false,
);

final User kovu = User(
  id: 7,
  name: "Kovu",
  imageUrl: "assets/images/kovu.jpeg",
  isFavorite: true,
);

final User charlie = User(
  id: 8,
  name: "Charlie",
  imageUrl: "assets/images/charlie.png",
);

final User alex = User(
  id: 9,
  name: "Alex",
  imageUrl: "assets/images/alex.jpeg",
  circle: 'Friend',
  isFavorite: true,
);

final users = [sam, gavin, emily, benji, phil, syd, sophie, kovu, charlie, alex]
  ..sort((user1, user2) => user1.name.compareTo(user2.name));
