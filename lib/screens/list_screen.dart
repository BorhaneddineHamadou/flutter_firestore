import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseproject/models/employee.dart';
import 'package:firebaseproject/screens/add_screen.dart';
import 'package:firebaseproject/screens/update_screen.dart';
import 'package:firebaseproject/services/firebase_crud.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readEmployee();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Employees"),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context)=>AddScreen()),
                    (route) => false
                );
              },
              icon: const Icon(Icons.add)
          )
        ],
      ),
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: snapshot.data!.docs.map((e) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(e["employeename"]),
                            subtitle: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text("Position: ${e["position"]}", style: TextStyle(fontSize: 14),),
                                   Text("Contact N°: ${e["contactno"]}", style: TextStyle(fontSize: 14),)
                                ],
                              ),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(5),
                                    textStyle: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: (){
                                    Navigator.pushAndRemoveUntil(
                                        context, 
                                        MaterialPageRoute(builder: (context) => UpdateScreen(
                                            employee: Employee(
                                              uid: e.id,
                                              employeename: e["employeename"],
                                              position: e["position"],
                                              contactno: e["contactno"]
                                            )
                                        )
                                        ),
                                        (route) => false
                                    );
                                  },
                                  child: const Text("Edit")
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(5),
                                    textStyle: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () async{
                                    var response = await FirebaseCrud.deleteEmployee(docId: e.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(response.message.toString()))
                                    );
                                  },
                                  child: const Text("Delete", style: TextStyle(color: Colors.red),)
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}