import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:chat_app/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class LoginNavigator extends BaseNavigator{
  void goToHome();
}
class LoginViewModel extends BaseViewModel<LoginNavigator>{
  var auth =FirebaseAuth.instance;
void login (String email,String password)async{
  navigator?.showLoadingDialog();
 try{
   var credential= await auth.signInWithEmailAndPassword(email: email,
       password: password);
   var retrievedUser= await MyDataBase.getUserById(credential.user?.uid??"");
   navigator?.hideLoadingDialoge();
   if(retrievedUser==null){
     navigator?.showMessageDialog('something went wrong,'
         'Wrong Email or Password');

   }else{
     SharedData.user=retrievedUser;
     navigator?.goToHome();
   }
 }on FirebaseAuthException catch (e) {
   navigator?.hideLoadingDialoge();
   navigator?.showMessageDialog('Wrong Email or Password');
 }
}
void checkedLoggedInUser()async{
  if(auth.currentUser!=null){
    var retrievedUser= await MyDataBase.getUserById(auth.currentUser?.uid??"");
    SharedData.user=retrievedUser;
    navigator?.goToHome();
  }
}
}