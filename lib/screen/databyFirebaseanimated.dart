
// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:insertdatafirebase/screen/Homepage.dart';
import 'package:insertdatafirebase/util/ErrorHandle.dart';

class ShowDataScreen extends StatefulWidget {
  const ShowDataScreen({super.key});

  @override
  State<ShowDataScreen> createState() => _ShowDataScreenState();
}

class _ShowDataScreenState extends State<ShowDataScreen> {
  final SearchController = TextEditingController();
  final EditController = TextEditingController();
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home_Screen()));
          },
          child: const Icon(Icons.arrow_back_outlined),
        )
      ),
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
          child: Column(
            children: [
              TextFormField(
                controller: SearchController,
                decoration: InputDecoration(
                    hintText: 'Text to search',
                    suffixIcon: const Icon(Icons.edit_document),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                ),
                onChanged: (String value){
                  setState(() {

                  });
                },
              ),
              const SizedBox(height: 10,),
             Expanded(
               child:  FirebaseAnimatedList(
                   query: FirebaseRef,
                   defaultChild: const Center(
                     child: CircularProgressIndicator(color: Colors.black,),
                   ),
                   itemBuilder: (context, snapshot, animation, index){
                     final searchText = snapshot.child('title').value.toString();
                     if(SearchController.text.isEmpty){
                       return ListTile(
                         title: Text(snapshot.child('title').value.toString()),
                         subtitle: Text(snapshot.child('id').value.toString()),
                         trailing: PopupMenuButton(
                             icon: const Icon(Icons.more_vert),
                             itemBuilder: (context)=>[
                               PopupMenuItem(
                                 value :1,
                                 child: ListTile(
                                   leading: const Icon(Icons.edit),
                                   title:  const Text('Edit'),
                                   onTap: (){
                                     Navigator.pop(context);
                                     _EditText(searchText, snapshot.child('id').value.toString());
                                   },
                                 ),
                               ),
                               PopupMenuItem(
                                 value :1,
                                 child: ListTile(
                                   leading: const Icon(Icons.delete,color: Colors.redAccent,),
                                   title: const Text("Delete"),
                                   onTap: (){
                                     Navigator.pop(context);
                                     FirebaseRef.child(snapshot.child('id').value.toString()).remove();
                                   },
                                 ),
                               ),
                             ]
                         ),
                       );
                     }
                     else if(searchText.toLowerCase().contains(SearchController.text.toLowerCase().toLowerCase())){
                       return ListTile(
                         title: Text(snapshot.child('title').value.toString()),
                         subtitle: Text(snapshot.child('id').value.toString()),
                         trailing: PopupMenuButton(
                             icon: const Icon(Icons.more_vert),
                             itemBuilder: (context)=>[
                               PopupMenuItem(
                                 value :1,
                                 child: ListTile(
                                   leading: const Icon(Icons.edit),
                                   title:  const Text('Edit'),
                                   onTap: (){
                                     Navigator.pop(context);
                                     _EditText(searchText, snapshot.child('id').value.toString());
                                   },
                                 ),
                               ),
                               PopupMenuItem(
                                 value :1,
                                 child: ListTile(
                                   leading: const Icon(Icons.delete,color: Colors.redAccent,),
                                   title: const Text("Delete"),
                                   onTap: (){
                                     Navigator.pop(context);
                                     FirebaseRef.child(snapshot.child('id').value.toString()).remove();
                                   },
                                 ),
                               ),
                             ]
                         ),
                       );
                     }
                     else{
                       return Container();
                     }
                   }
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _EditText (String title, String id) async {
    EditController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext  context){
          return AlertDialog(
            elevation: 0,
            title: const Text(
                "UPDATE TITLE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
            ),
            content:  SingleChildScrollView(
              child: ListBody(
                children: [
                  const Text("Are you sure you want to edit the text?"),
                  TextFormField(
                    controller:  EditController,
                    decoration:  const InputDecoration(
                      hintText: 'Edit Text',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.normal,
                  )
              )),
              TextButton(onPressed: (){
                Navigator.pop(context);
                FirebaseRef.child(id).update({
                  'title' : EditController.text.toString(),
                }).then((value) {
                  ErrorHandle().showError('Update Successful');
                }).onError((error, stackTrace) {
                  ErrorHandle().showError(error.toString());
                });
              }, child: const Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )
              )
              )],
          ) ;
        });
  }

}
