import 'package:todo_list/Controller/textediting_controller.dart';

List<String> toDoList=[];

void addData(){
  if(textEditingController.text.isNotEmpty){
    toDoList.add(textEditingController.text);
  }

}

 void deleteData(var value){
  toDoList.remove(value);
}