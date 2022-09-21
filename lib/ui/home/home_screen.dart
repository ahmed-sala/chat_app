import 'package:chat_app/base/base.dart';
import 'package:chat_app/data_base/my_database.dart';
import 'package:chat_app/shared_data.dart';
import 'package:chat_app/ui/add_room/add_room_screen.dart';
import 'package:chat_app/ui/home/home_viewModel.dart';
import 'package:chat_app/ui/home/room_widget.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
  @override
  void initState() {
    super.initState();
    viewModel.loadRoom();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshData,
      child: ChangeNotifierProvider(
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
              title: Text('chat app'),
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: (){
                    FirebaseAuth.instance.signOut();
                    SharedData.user=null;
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  },
                  child: Icon(Icons.logout_outlined),
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Consumer<HomeViewModel>(
                    builder: (buildContext,homeViewModel,_){
                      return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12
                          ),
                          itemBuilder:(_,index){
                            return RoomWidget(homeViewModel.rooms[index]);
                          },itemCount: homeViewModel.rooms.length,) ;
                    },
                  ),
                ),

              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.pushNamed(context, AddRoomScreen.routeName);
              },
              child: Icon(Icons.add),
            ),
            // floatingActionButton: FloatingActionButton.extended(
            //   onPressed: () {
            //     // Show refresh indicator programmatically on button tap.
            //     _refreshIndicatorKey.currentState?.show();
            //   },
            //   icon: const Icon(Icons.refresh),
            //   label: const Text('Show Indicator'),
            // ),
          ),
        ),
      ),
    );
  }
  Future<void> refreshData()async{
    setState(() {
      MyDataBase.loadRoam();
    });
  }
}
