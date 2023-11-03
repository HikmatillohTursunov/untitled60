import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:untitled60/add_screen.dart';

import 'model/inson.dart';

late Box box;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(InsonAdapter());
  box = await Hive.openBox("Ism");
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ismlar"),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context,box,child){
          return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (BuildContext context,int index){
             return Container(
               margin: EdgeInsets.all(10),
               decoration: BoxDecoration(
                 color: Colors.blue[100],
                 border: Border.all(width: 2,color: Colors.black),
                 borderRadius: BorderRadius.circular(10)
               ),
               alignment: Alignment.center,
               width: MediaQuery.of(context).size.width,
               height: 50,
               child: Column(
                 children: [
                   Text(box.getAt(index).ism.toString()),
                   Text(box.getAt(index).telefon.toString()),
                 ],
               )
             );


          });
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddScreen(ismBox: box)));
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
