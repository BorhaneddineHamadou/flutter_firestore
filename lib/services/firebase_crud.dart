import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/response.dart';

final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference _collectionReference = _firebaseFirestore.collection("Emplyee");

class FirebaseCrud{
  static Future<Response> addEmployee({
    required employeename, required position, required contactno
  }) async{
    Response response = Response();
    DocumentReference documentReference = _collectionReference.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "employeename": employeename,
      "position": position,
      "contactno": contactno
    };
    await documentReference.set(data).whenComplete((){
      response.code = "200";
      response.message = "Successfully added";
    }).catchError((err){
      response.code = "500";
      response.message = err;
    });

    return response;
  }

  static Stream<QuerySnapshot> readEmployee(){
      final CollectionReference _noteItemsCollection = _collectionReference;
      return _noteItemsCollection.snapshots();
  }

  static Future<Response> updateEmployee({
    required employeename, required position, required contactno, required docId
  }) async{
    Response response = Response();
    DocumentReference documentReference = _collectionReference.doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "employeename": employeename,
      "position": position,
      "contactno": contactno
    };
    await documentReference.update(data).whenComplete((){
      response.code = "200";
      response.message = "Successfully updated";
    }).catchError((err){
      response.code = "500";
      response.message = err;
    });

    return response;
  }

  static Future<Response> deleteEmployee({required docId}) async{
    Response response = Response();
    DocumentReference documentReference = _collectionReference.doc(docId);

    await documentReference.delete().whenComplete((){
      response.code = "200";
      response.message = "Successfully deleted";
    }).catchError((err){
      response.code = "500";
      response.message = err;
    });

    return response;
  }
}