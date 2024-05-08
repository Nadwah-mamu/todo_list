import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();

 void addDataToSharedPref(var addData) async {
  sharedPreferences.then((value) => value.setString("toDoList", addData));
  print("Data successfully added");
}


  void deleteDataFromSharedPref(){
    sharedPreferences.then((value) => value.clear());
     print("Data successfully deleted");
}