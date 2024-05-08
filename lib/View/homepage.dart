import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/Controller/textediting_controller.dart';
import 'package:todo_list/Model/shared-prefernce.dart';
import 'package:todo_list/services/adding_data_to_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool check = false;
  int selectedIndex = 0;
   String? dataStored;

  @override
  void initState() {

dataasync();
    super.initState();
  }

  void dataasync()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    var data = pref.getString("toDoList");


    setState(() {
      toDoList.add(data ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: TextField(
                    controller: textEditingController,
                    maxLines: 10,
                    decoration: InputDecoration(hintText: "Type..."),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            addData();
                          });
                          addDataToSharedPref(textEditingController.text);
                          Navigator.pop(context);
                          textEditingController.clear();
                        },
                        child: Text("OK")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.blue.shade500,
          size: 30,
        ),
      ),
      backgroundColor: toDoList.isEmpty ? Colors.white : Colors.blue.shade800,
      appBar: AppBar(
        elevation: 2,
        title: Text(
          "My To_do",
          style: TextStyle(
              color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade800,
      ),
      body: toDoList.isEmpty
          ? Center(
              child: Text(
                "No Entries ",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            )
          : Container(
              height: MediaQuery.sizeOf(context).height,
              child: ListView.builder(
                  itemCount: toDoList.length,
                  itemBuilder: (context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 10),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            leading: Checkbox(
                              value: check,
                              onChanged: (v) {
                                setState(() {
                                  check = v ?? false;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.all(12),
                            subtitle: check == true
                                ? Text(
                                    "Done",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 20),
                                  )
                                : Text(" "),
                            title: Text(
                              toDoList[index]!,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  deleteData(textEditingController.text);
                                });
                                deleteDataFromSharedPref();
                              },
                              icon: Icon(Icons.delete),
                            ),
                            tileColor: Colors.redAccent,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  }),
            ),
    );
  }
}
