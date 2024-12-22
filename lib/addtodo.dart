import 'package:flutter/material.dart';

class Addtodo extends StatefulWidget {
  void Function({required String todoText}) addtodo;
 Addtodo({super.key,required this.addtodo});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  TextEditingController todoText=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Add todo"),
        TextField(
          onSubmitted: (value){
    if(todoText.text.isNotEmpty){
    widget.addtodo(todoText: todoText.text);
    }
    todoText.text="";

          },
          autofocus: true,
          controller: todoText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            hintText: "Write todo here!",
            labelText: "Todo item",
            //icon: Icon(Icons.list),
        ),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ElevatedButton(onPressed: (){
       if(todoText.text.isNotEmpty){
      widget.addtodo(todoText: todoText.text);
       }
    todoText.text="";
    },
      child: Text("ADD ME")),


      ],
    );
  }
}
