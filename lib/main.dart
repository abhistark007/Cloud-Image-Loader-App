// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late FirebaseStorage storage;
  List<String> urls=[];
  Future<void> getImages() async{
    storage=FirebaseStorage.instance;
    var a=await storage.ref().child("omega1.jpg").getDownloadURL();
    var b=await storage.ref().child("omega2.jpg").getDownloadURL();
    var c=await storage.ref().child("omega3.jpg").getDownloadURL();
    var d=await storage.ref().child("omega4.jpg").getDownloadURL();
    var e=await storage.ref().child("omega5.jpg").getDownloadURL();

    urls.add(a);
    urls.add(b);
    urls.add(c);
    urls.add(d);
    urls.add(e);
  }


  @override
  void initState() {
    getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Gallery"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getImages(),
        builder: (context,snapshot){
          if(snapshot.connectionState!=ConnectionState.done){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return ListView.builder(
              itemCount: urls.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Image.network(urls[index]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
