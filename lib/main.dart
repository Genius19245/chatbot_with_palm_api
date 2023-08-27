import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBa6dBOwt9DCWwi9hf2NHCdx6xGg7y8nX4",
        authDomain: "shourya-s-french-app.firebaseapp.com",
        projectId: "shourya-s-french-app",
        storageBucket: "shourya-s-french-app.appspot.com",
        messagingSenderId: "58933452989",
        appId: "1:58933452989:web:43263d3f99c31b918517d4",
        measurementId: "G-QM25WMXEJ3"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Generator(),
    );
  }
}

class Generator extends StatefulWidget {
  const Generator({Key? key}) : super(key: key);

  @override
  _GeneratorState createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  final ref =
      FirebaseFirestore.instance.collection('chat').doc('52ieR9GWYUQSnn9kNAr3');
  final TextEditingController _textController = TextEditingController();
  String? response = 'Your response will be displayed here';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          "Shourya's Chat Bot",
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontSize: 50,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: ref.snapshots(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/128/6819/6819661.png',
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    response!,
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.white60,
                              fontWeight: FontWeight.w200,
                            ),
                            hintText: 'Type your prompt ',
                            contentPadding:
                                const EdgeInsets.only(top: 13, left: 15),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                FirebaseFirestore.instance
                                    .collection('chat')
                                    .doc('52ieR9GWYUQSnn9kNAr3')
                                    .update({'response': FieldValue.delete()});
                                FirebaseFirestore.instance
                                    .collection('chat')
                                    .doc('52ieR9GWYUQSnn9kNAr3')
                                    .update({'status': FieldValue.delete()});
                                await ref
                                    .update({"prompt": _textController.text});
                                Future.delayed(const Duration(seconds: 5),
                                    () async {
                                  setState(() {
                                    response = snapshot.data!['response'];
                                  });
                                });
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
