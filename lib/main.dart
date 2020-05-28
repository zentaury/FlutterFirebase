import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FlutterFirebaseApp());
}

class FlutterFirebaseApp extends StatefulWidget {
  @override
  _FlutterFirebaseAppState createState() => _FlutterFirebaseAppState();
}

class _FlutterFirebaseAppState extends State<FlutterFirebaseApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterFirebase',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tareas Firebase'),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('tareas').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
              List<DocumentSnapshot> docs = snapshot.data.documents;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = docs[index].data;
                  return ListTile(
                    leading: Checkbox(value: data['done']),
                    title: Text(data['tarea']),
                  );
                },
              );
          },
        ),
      ),
    );
  }
}
