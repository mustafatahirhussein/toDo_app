import 'package:flutter/material.dart';
import 'package:flutter_todo/addNew.dart';
import 'package:flutter_todo/task.dart';

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<Task> toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('toDo App'),
      ),
      body: toDoList.length == 0
          ? Center(
              child: Text(
                "You don't have any toDo's",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          : loadTasks(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () async {
          final data = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNew(list: toDoList)));

          if (data != null) {
            setState(() {
              print(toDoList.length);
            });
          } else {
            print('no data');
            print(toDoList.length);
          }
        },
        label: Text('Add New'),
        icon: Icon(Icons.calendar_today_sharp),
      ),
    );
  }

  loadTasks() {
    return ListView.builder(
      itemCount: toDoList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection direction) {
            setState(() {
              toDoList.removeAt(index);
            });
          },
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red.shade900,
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete_forever,
              size: 30,
              color: Colors.white,
            ),
          ),
          child: Card(
            elevation: 4,
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios, size: 12),
              title: Text(
                toDoList[index].title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(toDoList[index].desc),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNew(
                            title: toDoList[index].title,
                            desc: toDoList[index].desc)));
              },
            ),
          ),
        );
      },
    );
  }
}
