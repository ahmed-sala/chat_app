import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/ui/chat/chat_viewModel.dart';
import 'package:chat_app/ui/chat/message_widget.dart';
import 'package:chat_app/ui/home/home_viewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatThread extends StatefulWidget {
  static const String routeName = 'chat';

  @override
  State<ChatThread> createState() => _ChatThreadState();
}

class _ChatThreadState extends BaseState<ChatThread, ChatViewModel>
    implements ChatNavigator {
  late Room room;
  var contentController = TextEditingController();
  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room = room;
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover),
            color: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text('${room.title}'),
            centerTitle: true,
          ),
          body: Card(
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            color: Colors.white,
            elevation: 18,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: MyDataBase.getMessagesCollection(room.id ?? "")
                        .orderBy('dateTime', descending: true)
                        .snapshots(),
                    builder: (buildContext, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('something went wrong'),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var data =
                          snapshot.data?.docs.map((doc) => doc.data()).toList();
                      return ListView.builder(
                        reverse: true,
                        itemBuilder: (_, index) {
                          return MessageWidget(data![index]);
                        },
                        itemCount: data?.length ?? 0,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26, width: 1),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15)),
                          ),
                          child: TextField(
                            controller: contentController,
                            style: TextStyle(height: 1),
                            decoration: InputDecoration(
                                hintText: 'your message here',
                                contentPadding: EdgeInsets.all(10)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      InkWell(
                        onTap: () {
                          viewModel.send(contentController.text);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 9, horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).primaryColor),
                          child: Row(
                            children: [
                              Text(
                                'Send',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 17,
                              ),
                              Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void clearMessagText() {
    contentController.clear();
  }
}
