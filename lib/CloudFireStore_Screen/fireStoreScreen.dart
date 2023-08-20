
// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors, file_names

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insertdatafirebase/CloudFireStore_Screen/databycloud.dart';
import 'package:insertdatafirebase/util/ErrorHandle.dart';
import 'package:insertdatafirebase/util/custom_Button.dart';

class fireStoreScreen extends StatefulWidget {
  const fireStoreScreen({super.key});

  @override
  State<fireStoreScreen> createState() => _fireStoreScreenState();
}

class _fireStoreScreenState extends State<fireStoreScreen> {

  bool  loading = false;
  TextEditingController TextController = TextEditingController();
  final fireStoreRef = FirebaseFirestore.instance.collection('user');
  int _counter = 20;
  late Timer _timer;
  void StartTime(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(_counter>0){
        setState(() {
          _counter--;
        });
      }
      else {
        _timer.cancel();
      }
    });
  }

  void StoreinCloud(){
    setState(() {
      loading = true;
    });
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    fireStoreRef.doc(id).set({
      'title' : TextController.text.toString(),
      'id' : id,
    }).then((value) {
      setState(() {
        loading = false;
      });
      ErrorHandle().showError('Text is Added');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowdataFirestore()));
    }).onError((error, stackTrace) {
      ErrorHandle().showError(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade100,
        title:  const Text('FireStoreData'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  maxLines: 4,
                  controller: TextController,
                  decoration: InputDecoration(
                      hintText: 'Enter the text',
                      suffixIcon: Icon(Icons.edit_document),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/8,),
                CircleAvatar(
                  radius: 50,
                  child: Center(
                    child: Text('$_counter',),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          StartTime();
                        },
                        child: Text('Start'),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          _timer.cancel();
                        });
                      },
                      child: Text('Stop'),
                    ),
                    ElevatedButton(
                      onPressed: (){
                       setState(() {
                         _timer.cancel();
                         _counter = 20 + _counter;
                       });
                      },
                      child: Text('+20sec'),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/2,),
                Custom_Button(
                    title: 'Add',
                    ontap: (){
                    StoreinCloud();
                    },
                    loading: loading
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
