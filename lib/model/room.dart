class Room{
  static const String collectionName='room';
  String? id;
  String? title;
  String? description;
  String? catId;
  Room({this.id, this.title, this.description, this.catId});
  Room.fromFirStore(Map<String,dynamic> data)
  :this(
    id:data['id'],
    title:data['title'],
    description:data['description'],
    catId:data['catId'],
  );
  Map<String,dynamic> toFireStore(){
    return{
      'id':id,
      'title':title,
      'description':description,
      'catId':catId,
    };
  }
}