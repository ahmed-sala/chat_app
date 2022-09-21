import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDataBase {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (doc, _) => MyUser.fromFireStore(doc.data()!),
            toFirestore: (users, options) => users.toFireStore());
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (doc, _) => Room.fromFirStore(doc.data()!),
            toFirestore: (room, options) => room.toFireStore());
  }

  static Future<MyUser?> insertUser(MyUser user) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    var res = await docRef.set(user);
    return user;
  }

  static Future<MyUser?> getUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }

  static Future<void> createRoom(Room room) {
    var docRef = getRoomsCollection().doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> loadRoam() async {

    var querySnapshot = await getRoomsCollection().get();
    return querySnapshot.docs
        .map((queryDocSnapshot) => queryDocSnapshot.data())
        .toList();
  }
  static CollectionReference<Message> getMessagesCollection(String roomId){
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
    .withConverter<Message>(
        fromFirestore:
        ((snapshot,option)=>Message.fromFireStore(snapshot.data()!)),
        toFirestore: (message,options)=>message.toFireStore());
  }
  static Future<void> sendMessage(Message message,String roomId){
    var messageDoc =getMessagesCollection(roomId).doc();
    message.id=messageDoc.id;
    return messageDoc.set(message);
  }
}
