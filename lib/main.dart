import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:traking_map/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Column(
            children: [
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        // FirebaseFirestore.instance
                        //     .collection('data').doc("amit").set({'text': 'data added through app'});

                        final cities = db.collection("cities");
                        final data1 = <String, dynamic>{
                          "name": "San Francisco",
                          "state": "CA",
                          "country": "USA",
                          "capital": false,
                          "population": 860000,
                          "regions": ["west_coast", "norcal"]
                        };
                        cities.doc("SF").set(data1);
                      },
                      child: Text("SetData"))),
              const SizedBox(height: 30,),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        final docRef = db.collection("cities").doc("SF");
                        docRef.get().then((DocumentSnapshot doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            print(data["country"]);
                          },
                          onError: (e) => print("Error getting document: $e"),
                        );




                      },
                      child: Text("getData")))
            ],
          )),
    );
  }
}
