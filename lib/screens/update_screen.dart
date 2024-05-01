import 'package:firebaseproject/models/employee.dart';
import 'package:firebaseproject/screens/list_screen.dart';
import 'package:firebaseproject/services/firebase_crud.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.employee});
  final Employee employee;
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _employee_id = TextEditingController();
  final _employee_name = TextEditingController();
  final _employee_position = TextEditingController();
  final _employee_contactno = TextEditingController();

  final GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _employee_id.value = TextEditingValue(text: widget.employee.uid.toString());
    _employee_name.value = TextEditingValue(text: widget.employee.employeename.toString());
    _employee_position.value = TextEditingValue(text: widget.employee.position.toString());
    _employee_contactno.value = TextEditingValue(text: widget.employee.contactno.toString());
  }

  @override
  Widget build(BuildContext context) {

    final idField = TextField(
        controller: _employee_id,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))
        ),
    );

    final nameField = TextFormField(
      controller: _employee_name,
      autofocus: false,
      validator: (value){
        if(value == null || value.trim().toString().isEmpty){
          return "This field is required";
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))
      ),
    );

    final positionField = TextFormField(
      controller: _employee_position,
      autofocus: false,
      validator: (value){
        if(value == null || value.trim().toString().isEmpty){
          return "This field is required";
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Position",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))
      ),
    );

    final contactnoField = TextFormField(
      controller: _employee_contactno,
      autofocus: false,
      validator: (value){
        if(value == null || value.trim().toString().isEmpty){ //trim() to delete spaces
          return "This field is required";
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contact number",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))
      ),
    );

    final viewListButton = TextButton(
        onPressed: (){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context)=>ListScreen()),
              (route) => false //always returns false, will remove all routes on stack without condition
          );
        },
        child: const Text("All Employees")
    );

    final updateButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: ()async{
          if(_updateFormKey.currentState!.validate()){
            var response = await FirebaseCrud.updateEmployee(
                employeename: _employee_name.text,
                position: _employee_position.text,
                contactno: _employee_contactno.text,
                docId: _employee_id.text
            );

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(response.message.toString()))
            );
          }
        },
        child: const Text("Update"),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Employee"),
      ),
      body: Form(
        key: _updateFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            idField,
            const SizedBox(height: 10,),
            nameField,
            const SizedBox(height: 10,),
            positionField,
            const SizedBox(height: 10,),
            contactnoField,
            const SizedBox(height: 10,),
            viewListButton,
            const SizedBox(height: 10,),
            updateButton,
          ],
        ),
      )
    );
  }
}