
// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'fireStoreScreen.dart';

class ShowdataFirestore extends StatefulWidget {
  const ShowdataFirestore({super.key});

  @override
  State<ShowdataFirestore> createState() => _ShowdataFirestoreState();
}

class _ShowdataFirestoreState extends State<ShowdataFirestore> {

  bool  loading = false;
  TextEditingController TextController = TextEditingController();
  final fireStoreRef = FirebaseFirestore.instance.collection('user').snapshots();
  final fireRef = FirebaseFirestore.instance.collection('user'); // for update and delete
  final id = DateTime.now().millisecondsSinceEpoch.toString();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purpleAccent.shade100,
          title:  const Text('ShowData'),
          centerTitle: true,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const fireStoreScreen()));
            },
            child: const Icon(Icons.arrow_back_outlined),
          )
      ),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          children: [
           Expanded(
             child: StreamBuilder<QuerySnapshot>(
             stream: fireStoreRef,
               builder: (context, AsyncSnapshot <QuerySnapshot> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                   child: CircularProgressIndicator(color: Colors.black,),
                 );
                }
                if(snapshot.hasError) {
                  return const Text('Error');
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        onTap: (){
                         fireRef.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                        },
                        title: Text(snapshot.data!.docs[index]['title'].toString()),
                        subtitle: Text(snapshot.data!.docs[index].id),  // Access the document ID
                      );
                    }
                );
             }
             )
           )
          ],
        ),
        ),
      ),
    );
  }
}
