class MyUser{
  static const String collectionName='users';
  String? id;
  String? userName;
  String? fullName;
  String? email;
  MyUser({this.id,this.fullName,this.email,this.userName});
  MyUser.fromFireStore(Map<String,dynamic> data)
    :this(
    id:data['id'],
    email:data['email'],
    fullName:data['fullName'],
    userName:data['userName'],
    );
  Map<String,dynamic>toFireStore(){
    return {
      'id':id,
      'email':email,
      'fullName':fullName,
      'userName':userName,
    };
  }
}