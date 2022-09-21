import 'package:chat_app/model/message.dart';
import 'package:chat_app/shared_data.dart';
import 'package:chat_app/utils.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  Message mesaage;
  MessageWidget(this.mesaage);
  @override
  Widget build(BuildContext context) {
    return mesaage.senderId == SharedData.user?.id
        ? SentMessage(mesaage.content!, mesaage.dateTime!)
        : RecievedMessage(mesaage.dateTime!, mesaage.content!,
            mesaage.senderName!);
  }
}

class SentMessage extends StatelessWidget {
  int dateTime;
  String content;
  SentMessage(this.content, this.dateTime);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: Text(
              content,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10,),
          Text('${formatMessageDate(dateTime)}'),
        ],
      ),
    );
  }
}

class RecievedMessage extends StatelessWidget {
  String senderName;
  int dateTime;
  String content;
  RecievedMessage(this.dateTime, this.content, this.senderName);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(senderName),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),

            child: Text(
              content,
              style: TextStyle(color: Color(0xFF787993)),
            ),
          ),
          SizedBox(height: 10,),
          Text('${formatMessageDate(dateTime)}'),
        ],
      ),
    );
  }
}
