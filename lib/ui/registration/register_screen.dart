import 'package:chat_app/base/base.dart';
import 'package:chat_app/loadingAndMassege.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:chat_app/ui/registration/registeration_viewModel.dart';
import 'package:chat_app/validation_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = 'reg';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState
    extends BaseState<RegistrationScreen, RegisterViewModel>
    implements RegisterNavigator {
  bool securedPassword = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var userNameController = TextEditingController();
  @override
  RegisterViewModel initViewModel() {
    return RegisterViewModel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Create Account'),
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
                      controller: fullNameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                      ),
                    ),
                    TextFormField(
                      controller: userNameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter user name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'User Name',
                      ),
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
                        createAccountOnClick();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                      ),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: Text('Already have acount ?')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createAccountOnClick() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.register(emailController.text, passwordController.text,
        fullNameController.text, userNameController.text);
  }
  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context,HomeScreen.routeName);
  }
}
