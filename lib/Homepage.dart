import 'package:flutter/material.dart';
import 'package:flutter_hive/main.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   late Box<Todo> todoBox;

   @override
    void initState(){
     super.initState();
   todoBox = Hive.box<Todo>('todo');

   }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: const Color.fromARGB(163, 119, 114, 114),
         appBar: AppBar(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 11, 11, 11),
         title: const Row(
            children: [
              Text(
                "TODO ",
                style: TextStyle(color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
              ), 
              Text(
                "LIST",
                style: TextStyle(color: Colors.orange,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
              ),
            ],
          ),
         ),
        
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
         builder: (context, Box<Todo> box,_){
          return ListView.builder(
            itemCount: box.length,
            itemBuilder:(context, index) {
              Todo todo = box.getAt(index)!;
              return Container(
                margin: const EdgeInsets.all(10),
                decoration:BoxDecoration(
                color: todo.iscompleted ? const Color.fromARGB(95, 240, 205, 205) :Colors.white,
                borderRadius: BorderRadius.circular(10)),
                
                child: Dismissible(
                  key: Key(todo.dateTime.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      todo.delete();
                    });
                  },
                  child: ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    trailing: Text(
                      DateFormat.yMMMd().format(todo.dateTime),
                    ),
                    leading: Checkbox(
                      value: todo.iscompleted,
                      onChanged: (value){
                        setState(() {
                          todo.iscompleted= value!;
                          todo.save();
                        });
                      },
                    ),
                  ),
                ),
              );
            }, );
         }
         ),
           floatingActionButton:FloatingActionButton(
        onPressed: (){
          _addTodoDialog(context);
        },
        autofocus: true,
        child:const Icon(Icons.add) ,
      ) ,
    );
  }


void _addTodoDialog(BuildContext context){
  TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();

    showDialog(context: context,
     builder:(context) => AlertDialog(
      title: const Text("add Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: "title"),
         ),
         TextField(
          controller: descController,
          decoration: const InputDecoration(labelText: "description"),
         ),
        ],
      ),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        },
         child: const Text("cancel")),
         TextButton(onPressed: () {
        _addTodo(titleController.text,descController.text);
        Navigator.pop(context);
        },
         child: const Text("add"))
      ],
     ),
     );

}
void _addTodo(String title,String description){
  if(title.isNotEmpty){
    todoBox.add(
      Todo(title: title,
       description: description,
        dateTime: DateTime.now())
    );
  }
}
}