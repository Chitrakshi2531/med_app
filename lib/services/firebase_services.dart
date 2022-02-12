import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices{
  CollectionReference equipments = FirebaseFirestore.instance.collection('equipments');
}