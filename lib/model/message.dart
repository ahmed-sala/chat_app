class Message {
  static const collectionName = 'message';
  String? id;
  String? content;
  String? senderName;
  String? senderId;
  int? dateTime;
  String? roomId;
  Message(
      {this.id,
      this.dateTime,
      this.content,
      this.roomId,
      this.senderId,
      this.senderName});
  Message.fromFireStore(Map<String,dynamic> data)
  :this(
    id: data['id'],
    dateTime: data['dateTime'],
    content: data['content'],
    roomId: data['roomId'],
    senderId: data['senderId'],
    senderName: data['senderName'],
  );
  Map<String,dynamic> toFireStore(){
    return {
      'id':id,
      'dateTime':dateTime,
      'content':content,
      'roomId':roomId,
      'senderId':senderId,
      'senderName':senderName,
    };
  }
}
