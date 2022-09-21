import 'package:chat_app/loadingAndMassege.dart';
import 'package:flutter/material.dart';

abstract class BaseNavigator {
  void showLoadingDialog({String message = 'loading...'});
  void hideLoadingDialoge();
  void showMessageDialog(String message,
      {String? posActionName,
      VoidCallback? posAction,
      String? negActionName,
      VoidCallback? negAction,
      bool isCancelable = true});
}

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier {
  Nav? navigator;
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();
  @override
  void showLoadingDialog({String message = 'loading...'}) {
    showLoading(context, message);
  }

  @override
  void showMessageDialog(String message,
      {String? posActionName,
      VoidCallback? posAction,
      String? negActionName,
      VoidCallback? negAction,
      bool isCancelable = true}) {
    showMessage(context, message,
        posActionName: posActionName,
        posAction: posAction,
        negActionName: negActionName,
        negAction: negAction,
        isCancelable: isCancelable);
  }

  @override
  void hideLoadingDialoge() {
    hideLoading(context);
  }
}
