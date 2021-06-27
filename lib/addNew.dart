import 'package:flutter/material.dart';
import 'package:flutter_todo/task.dart';

class AddNew extends StatefulWidget {
  final List<Task> list;

  final String title, desc;

  AddNew({this.list, this.title, this.desc});

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  var title = TextEditingController();
  var desc = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.title != null && widget.desc != null) {
      title.text = widget.title;
      desc.text = widget.desc;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title != null && widget.desc != null
            ? 'View toDo'
            : 'Add new toDo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(9),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: title,
                validator: (val) => val.isEmpty ? 'Required.' : null,
                decoration: InputDecoration(
                    hintText: 'Add a title', border: OutlineInputBorder()),
              ),
              Divider(
                color: Colors.transparent,
              ),
              TextFormField(
                controller: desc,
                validator: (val) => val.isEmpty ? 'Required.' : null,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: 'Add a description',
                    border: OutlineInputBorder()),
              ),
              Divider(
                color: Colors.transparent,
              ),
              widget.title != null && widget.desc != null
                  ? Container()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            widget.list
                                .add(Task(title: title.text, desc: desc.text));
                          });
                          Navigator.pop(context, widget.list);
                        }
                      },
                      child: Text('Add'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
