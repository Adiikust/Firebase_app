import 'package:firebase/Controller/auth_controller.dart';
import 'package:firebase/Realtime_DataBase/add_data_screen.dart';
import 'package:firebase/Realtime_DataBase/update_screen.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home Page"),
        actions: [
          IconButton(
              onPressed: () {
                authController.logOut(context);
              },
              icon: const Icon(Icons.login_outlined))
        ],
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: authController.ref,
          itemBuilder: ((context, snapshot, animation, index) {
            return Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(snapshot.child('age').value.toString()),
                ),
                title: Text(snapshot.child('name').value.toString()),
                subtitle: Text(snapshot.child('email').value.toString()),
                trailing: PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateScreen(
                                id: snapshot.child('id').value.toString(),
                                name: snapshot.child('name').value.toString(),
                                // address: snapshot
                                //     .child('address/line1')
                                //     .value
                                //     .toString(),
                                age: snapshot.child('age').value.toString(),
                                // city: snapshot
                                //     .child('address/city')
                                //     .value
                                //     .toString(),
                                email: snapshot.child('email').value.toString(),
                                phone: snapshot.child('phone').value.toString(),
                              ),
                            ),
                          );
                        },
                        title: const Text("Edit"),
                        leading: const Icon(Icons.edit),
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          authController.realtimeDatabaseDelete(
                              snapshot.child('id').value.toString(), context);
                          setState(() {});
                        },
                        title: const Text("Delete"),
                        leading: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddDataScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
