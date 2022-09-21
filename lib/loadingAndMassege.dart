// import 'package:flutter/material.dart';
//
// void showMessage(BuildContext context, String message,
//     {String? posActionName,
//       VoidCallback? posActionCallBack,
//       String? negActionName,
//       VoidCallback? negActionCallback,bool isCancelable=true}) {
//   List<Widget> actions = [];
//   if(posActionName!=null){
//     actions.add(TextButton(onPressed: (){
//       // called when user select button
//       Navigator.pop(context);
//       if(posActionCallBack!=null)
//         posActionCallBack();
//     }, child: Text(posActionName)));
//   }
//   if(negActionName!=null){
//     actions.add(TextButton(onPressed: (){
//       // called when user select button
//       Navigator.pop(context);
//       if(negActionCallback!=null)
//         negActionCallback();
//     }, child: Text(negActionName)));
//   }
//   showDialog(
//       context: context,
//       builder: (buildContext) {
//         return AlertDialog(
//           content: Text(message,style: Theme.of(context).textTheme.bodyLarge,),
//           actions: actions,
//         );
//       },barrierDismissible: isCancelable);
// }
// void showLoading(BuildContext context,String message,
//     {bool isCancelable = true}){
//   showDialog(context: context, builder: (builder){
//     return AlertDialog(
//       content: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(width: 12,),
//             Text(message)
//           ],
//         ),
//       ),
//     );
//   },barrierDismissible: isCancelable);
//
// }
//
// void hideLoading(BuildContext context){
//   Navigator.pop(context);
// }

import 'package:flutter/material.dart';

// are you sure to delete this item ?
// yes ,no
void showMessage(BuildContext context, String message,
    {String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
    bool isCancelable = true}) {
  List<Widget> actions = [];
  if (posActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          // called when user select button
          Navigator.pop(context);
          if (posAction != null) posAction();
        },
        child: Text(posActionName)));
  }
  if (negActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          // called when user select button
          Navigator.pop(context);
          if (negAction != null) negAction();
        },
        child: Text(negActionName)));
  }
  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: actions,
        );
      },
      barrierDismissible: isCancelable);
}

void showLoading(BuildContext context, String loadingMessage,
    {bool isCancelable = true}) {
  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 12,
              ),
              Text(loadingMessage, style: Theme.of(context).textTheme.bodyLarge)
            ],
          ),
        );
      },
      barrierDismissible: isCancelable);
}

void hideLoading(BuildContext context) {
  Navigator.pop(context);
}
