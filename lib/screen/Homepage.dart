// ignore_for_file: non_constant_identifier_names, file_names, camel_case_types, prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:insertdatafirebase/util/ErrorHandle.dart';
import 'package:insertdatafirebase/util/custom_Button.dart';
import 'databyFirebaseanimated.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  final FirebaseRef = FirebaseDatabase.instance.ref('Insert Data');
  bool  loading = false;
  TextEditingController TextController = TextEditingController();

  void InsertData(){
    setState(() {
      loading = true;
    });
    final id = DateTime.now().millisecondsSinceEpoch.toString(); // for same time&ID

    FirebaseRef.child(id).set({
      'title' : TextController.text.toString(),
      'id' : id,
    }).then((value) {
      setState(() {
        loading = false;
      });
     ErrorHandle().showError('Add Text');
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ShowDataScreen()));
    }).onError((error, stackTrace) {
    ErrorHandle().showError(error.toString());
    setState(() {
      loading = false;
    });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade100,
        title:  const Text('InsertData'),
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
                SizedBox(height: MediaQuery.of(context).size.height/2,),
                Custom_Button(
                    title: 'Add',
                    ontap: (){
                      InsertData();
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
