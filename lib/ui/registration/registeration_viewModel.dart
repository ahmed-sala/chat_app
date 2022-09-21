import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void goToHome();
}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  var auth = FirebaseAuth.instance;
  void register(String email, String password,String fullName,String userName)async {
    navigator?.showLoadingDialog();
    try {
      var credential =await
      auth.createUserWithEmailAndPassword(email: email, password: password);
      MyUser newUser=MyUser(
        id: credential.user?.uid,
        email: email,
        fullName:fullName ,
        userName:userName
      );
      var insertedUser=await MyDataBase.insertUser(newUser);
      navigator?.hideLoadingDialoge();
      if(insertedUser==null){
        navigator?.showMessageDialog('something went wrong,'
            'Wrong Email or Password');

      }else{
        SharedData.user=insertedUser;
        navigator?.goToHome();
      }
    }on FirebaseAuthException catch (e){
      navigator?.hideLoadingDialoge();
      if(e.code=='weak-password'){
        navigator?.showMessageDialog('the password is too weak');
      }else if (e.code =='email-already-in-use'){
        navigator?.showMessageDialog('email is already in use');
      }
    }catch(e){
      navigator?.hideLoadingDialoge();
      navigator?.showMessageDialog('something went wrong,please try again later');
    }
  }
}
