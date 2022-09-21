import 'package:chat_app/base/base.dart';
import 'package:chat_app/loadingAndMassege.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/login/login_viewModel.dart';
import 'package:chat_app/ui/registration/register_screen.dart';
import 'package:chat_app/validation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen,LoginViewModel> implements LoginNavigator{
  bool securedPassword = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    viewModel.checkedLoggedInUser();
    return ChangeNotifierProvider(
      create: (_)=>viewModel,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover),
            color: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Log In'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(12),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: size.height * 0.25,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter email';
                        }
                        if (!ValidationUtils.isValidEmail(text)) {
                          return 'please enter valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter password';
                        }
                        if (text.length < 7) {
                          return 'please enter password more than 6 character';
                        }
                        return null;
                      },
                      obscureText: securedPassword,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                securedPassword = !securedPassword;
                              });
                            },
                            child: securedPassword
                                ? Icon(Icons.visibility_outlined)
                                : Icon(Icons.visibility_off_outlined)),
                        labelText: 'Passowrd',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signIn();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                      ),
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushReplacementNamed(context, RegistrationScreen.routeName);
                    }, child: Text('Or create account ?')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void signIn() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
viewModel.login(emailController.text, passwordController.text);
  }
  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context,HomeScreen.routeName);
  }
}
