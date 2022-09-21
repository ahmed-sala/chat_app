import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';

import '../../model/room.dart';
abstract class HomeNavigator extends BaseNavigator{
}
class HomeViewModel extends BaseViewModel<HomeNavigator>{
  List<Room> rooms=[];

  void loadRoom()async{
    rooms=await MyDataBase.loadRoam();
    notifyListeners();
  }
}