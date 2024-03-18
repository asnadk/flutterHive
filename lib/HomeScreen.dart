import 'package:flutter/material.dart';
import 'package:flutter_hive/Homepage.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
      title: const Text("home page"),
        ),
        body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("GO TO TODO PAGE",style: TextStyle(fontWeight: FontWeight.bold),),
            ElevatedButton(onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
            } ,
             child:const Icon(Icons.arrow_forward_ios),
             )
          ],
        ),
        ),
      ),
    );
  }
}