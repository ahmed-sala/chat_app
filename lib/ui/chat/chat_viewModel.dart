import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/shared_data.dart';

abstract class ChatNavigator extends BaseNavigator {
  void clearMessagText();
}

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  void send(String messageContent) {
    if(messageContent.trim().isEmpty)return;
    var message = Message(
        content: messageContent,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        senderId: SharedData.user?.id,
        senderName: SharedData.user?.userName,
        roomId: room.id);
    MyDataBase.sendMessage(message, room.id ?? "")
        .then((value) {
          navigator?.clearMessagText();
    })
        .onError((error, stackTrace) {
      navigator?.showMessageDialog(
        'something went wrong,try again later',
        posActionName: 'try again',
        posAction: () {
          send(messageContent);
        },
        negActionName: 'cancel',
      );
    });
  }
}
