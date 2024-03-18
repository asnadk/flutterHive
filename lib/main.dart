import 'package:flutter/material.dart';
import 'package:flutter_hive/Homepage.dart';
import 'package:flutter_hive/HomeScreen.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>("todo"); 
  runApp(const MainApp());
}

@HiveType(typeId: 0)
class Todo extends HiveObject{
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late bool iscompleted;

@HiveField(3)
late DateTime dateTime;

Todo({
  required this.title,
  required this.description,
  required this.dateTime,
  this.iscompleted =false,
});
}
class TodoAdapter extends TypeAdapter<Todo>{
  @override
  final int typeId =0;

  @override
  Todo read(BinaryReader reader) {
    return Todo(title:reader.readString(),
     description:reader.readString(),
      dateTime: DateTime.parse(reader.readString() ),
      iscompleted: reader.readBool(),
      );
  }

  @override
  void write(BinaryWriter writer, Todo obj){
    writer.writeString(obj.title);
   writer.writeString(obj.description);
    writer.writeString(obj.dateTime.toIso8601String());
    writer.writeBool(obj.iscompleted);

  }

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white54
      ),
      home:const AlertPage()
    );
  }
}
