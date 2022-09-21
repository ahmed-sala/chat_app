import 'package:chat_app/base/base.dart';
import 'package:chat_app/model/room_category.dart';
import 'package:chat_app/ui/add_room/add_room_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'add';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  List<RoomCategory> allCats = RoomCategory.getRoomCategories();
  late RoomCategory selectedRoomCategory;
  var formKey = GlobalKey<FormState>();
  var titleController=TextEditingController();
  var descController=TextEditingController();
  @override
  void initState() {
    super.initState();
    selectedRoomCategory = allCats[0];
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text('Add Room'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.all(25),
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Create New Room',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Image.asset('assets/images/add_main.png'),
                      TextFormField(
                        controller: titleController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter room name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Room Name'),
                      ),
                      DropdownButton<RoomCategory>(
                          value: selectedRoomCategory,
                          items: allCats.map((cat) {
                            return DropdownMenuItem<RoomCategory>(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/${cat.imageName}',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                  Text(cat.name),
                                ],
                              ),
                              value: cat,
                            );
                          }).toList(),
                          onChanged: (item) {
                            if (item == null) return;
                            setState(() {
                              selectedRoomCategory = item;
                            });
                          }),
                      TextFormField(
                        controller: descController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter room description';
                          }
                          return null;
                        },
                        maxLines: 3,
                        minLines: 3,
                        decoration:
                            InputDecoration(labelText: 'Room Description'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                          ))
                        ),
                        onPressed: () {
                          submit();
                        },
                        child: Text('Create'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    if(formKey.currentState?.validate()==false)return;
    viewModel.addRoom(titleController.text, descController.text, selectedRoomCategory.id);
  }
  @override
  void goBack() {
    Navigator.pop(context);
  }
}
