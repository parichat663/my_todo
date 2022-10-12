import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/models/todo.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<ToDo> todoList = [
  ToDo(
      i: '01',
      todoText: 'ทำการบ้านครั้งที่ 4 วิชา Mobile App Dev',
      isDone: true,
  ),
  ToDo(
    i: '02',
    todoText: 'ทำการบ้านครั้งที่ 5 วิชา Mobile App Dev',
  ),
  ToDo(
    i: '03',
    todoText: 'ทำโปรเจ็ควิชา Mobile App Dev',
  ),
];

class _HomePageState extends State<HomePage> {

  var _todoController = TextEditingController();

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String i) {
    setState(() {
      todoList.removeWhere((item) => item.i == i);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todoList.add(ToDo(
        i: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.check_box,
              size: 24.0,
              color: Colors.white,
            ),
            SizedBox(width: 8.0,),
            Text('My ToDo',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
            itemBuilder: (BuildContext context, int i){
              var ToDo = todoList[i];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          _handleToDoChange(ToDo);
                        },
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          child: ToDo.isDone
                              ? Icon(Icons.check_box,
                            color: Colors.blue,
                            size: 24.0,
                          )
                              :  Icon(Icons.check_box_outline_blank,
                            color: Colors.grey,
                            size: 24.0,
                          )
                        ),
                        customBorder: CircleBorder(),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${ToDo.todoText}',
                              style: GoogleFonts.roboto(
                                fontSize: 16.0,
                                decoration: ToDo.isDone ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _deleteToDoItem(ToDo.i.toString());
                                });
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                child: Icon(Icons.delete,
                                  color: Colors.grey,
                                  size: 24.0,
                                ),
                              ),
                              customBorder: CircleBorder(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
              itemCount: todoList.length,
          ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: _todoController,
                      style: GoogleFonts.roboto(
                        fontSize: 15.0,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter new ToDo',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        _addToDoItem(_todoController.text);
                      });
                    },
                    child: Container(
                      width: 50.0,
                      height: 30.0,
                        alignment: Alignment.center,
                        child: Text('ADD',
                          style: GoogleFonts.roboto(
                          color: Colors.blue,
                        ),
                      )
                    ),
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

