
// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Fetch_Picture extends StatefulWidget {
  const Fetch_Picture({super.key});

  @override
  State<Fetch_Picture> createState() => _Fetch_PictureState();
}

class _Fetch_PictureState extends State<Fetch_Picture> {
 final firebaseref = FirebaseFirestore.instance.collection('picture').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: firebaseref,
          builder: (context, AsyncSnapshot <QuerySnapshot> snapshot){
           return ListView.builder(
              itemCount: snapshot.data!.docs.length,
               itemBuilder: (context,index){
                DocumentSnapshot course = snapshot.data!.docs[index];
                  return ListTile(
                    leading: Container(
                      height: 60,
                      width: 100,
                      color: Colors.teal,
                      child:  Lottie.network(course['image']),
                    ),
                    title: Text(course['title'].toString()),
                    subtitle: Text(course['subtitle'].toString()),
                  );
               }
           );
          }
      ),
    );
  }
}
