import 'package:firebaseproject/screens/list_screen.dart';
import 'package:firebaseproject/services/firebase_crud.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final _employee_name = TextEditingController();
  final _employee_position = TextEditingController();
  final _employee_contactno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Employee"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _employee_name,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: "Name",
                      labelText: "Name",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: _employee_position,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: "Position",
                        labelText: "Position",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: _employee_contactno,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: "Contact Number",
                        labelText: "Contact Number",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => ListScreen()),
                            (route) => false
                        );
                      },
                      child: Text("List of Emplyees")
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                      onPressed: ()async{
                        if(_employee_name.text == null || _employee_name.text.trim().isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please entre name value"))
                          );
                        }else if(_employee_position.text == null || _employee_position.text.trim().isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please entre Position value"))
                          );
                        }else if(_employee_contactno.text == null || _employee_contactno.text.trim().isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please entre the contact number"))
                          );
                        }else{
                          var response = await FirebaseCrud.addEmployee(
                              employeename: _employee_name.text,
                              position: _employee_position.text,
                              contactno: _employee_contactno.text);

                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response.message.toString()))
                          );
                        }
                      },
                      child: const Text("Add")
                  )
                ],
              ),
          )
        ],
      ),
    );
  }
}