import 'package:HyChat/models/user_model.dart';

class Message {
  final User contact;
  final String time;
  final String text;
  bool incoming;
  bool read;

  Message(
      {this.contact, this.time, this.text, this.incoming = true, this.read});
}

final chats = [
  Message(
    contact: emily,
    time: "8:20 pm",
    text: "I'm near Glade City exit, how about a glass of wine?",
    read: false,
  ),
  Message(
    contact: sophie,
    time: "6:30 pm",
    text: "On my way home,no luck. We'll call when reception better",
    read: true,
  ),
  Message(
    contact: charlie,
    time: "5:22 pm",
    text: "Stuck in traffic",
    incoming: false,
    read: false,
  ),
  Message(
    contact: benji,
    time: "11:20 am",
    text: "Hmm. For today",
    read: false,
  ),
  Message(contact: gavin, time: "9:16 am", text: "Hi", read: true),
  Message(
    contact: syd,
    time: "yesterday",
    text: "Im getting a tattoo tonight",
    read: true,
  ),
  Message(
    contact: alex,
    time: "yesterday",
    text: "im literaly just sat here eating a pepper",
    incoming: false,
    read: true,
  ),
  Message(
    contact: phil,
    time: "yesterday",
    text: "Before we begin I'll need some more information",
    read: true,
  ),
];
