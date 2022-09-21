import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/ui/add_room/add_room_screen.dart';
import 'package:chat_app/ui/chat/chat_thread.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:chat_app/ui/registration/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      initialRoute: LoginScreen.routeName,
      routes: {
        RegistrationScreen.routeName:(_)=>RegistrationScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        HomeScreen.routeName:(_)=>HomeScreen(),
        AddRoomScreen.routeName:(_)=>AddRoomScreen(),
        ChatThread.routeName:(_)=>ChatThread(),
      },
    );
  }
}
