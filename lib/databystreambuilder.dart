// ignore_for_file: non_constant_identifier_names, unused_import, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:insertdatafirebase/screen/Homepage.dart';
import 'package:insertdatafirebase/screen/databyFirebaseanimated.dart';

class ShowDataStream extends StatefulWidget {
  const ShowDataStream({super.key});

  @override
  State<ShowDataStream> createState() => _ShowDataStreamState();
}

class _ShowDataStreamState extends State<ShowDataStream> {
  final SearchController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final FirebaseRef = FirebaseDatabase.instance.ref('Insert Data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purpleAccent.shade100,
          title:  const Text('ShowData'),
          centerTitle: true,
          leading: InkWell(
            onTap: (){
             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ShowDataScreen()));
            },
            child: const Icon(Icons.arrow_back_outlined),
          )
      ),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          children: [
            TextFormField(
              controller: SearchController,
              decoration: InputDecoration(
                  hintText: 'Text to search',
                  suffixIcon: Icon(Icons.edit_document),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
            SizedBox(height: 10,),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseRef.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent>snapshot){
                  if(!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }else{
                   Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
                   List<dynamic> customList = [];
                   customList.clear();
                   customList = map.values.toList();
                   return ListView.builder(
                       itemCount: snapshot.data!.snapshot.children.length,
                       itemBuilder: (context,index){
                         return ListTile(
                           title: Text(customList[index]['title']),
                           subtitle: Text(customList[index]['id']),
                         );
                       }
                   );
                  }
                },
              ),
            )
          ],
        ),

        ),
      ),
    );
  }
}
