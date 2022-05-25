
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Firebaseの初期化
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BookList());
}

class BookList extends StatelessWidget {

  //nullを許可
  String? data;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          //旧：Firestore → 新:FirebaseFirestore
          stream: FirebaseFirestore.instance.collection('books').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch(snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text('Loading...');
            }
            return ListView(
              //旧:documents → 新:docs
              //レシーバーが「null」になる可能性があるため、docsに無条件でアクセスするできない。
              // →そのためdata!とする必要がある。
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return ListTile(
                  title: Text(document.get('title')),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}