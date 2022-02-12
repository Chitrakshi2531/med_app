

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EquipmentProvider with ChangeNotifier{
 File? _imageFile;
 String organizationName = 'xyz';
 late String equipmentUrl;
  Future<File?> pickImage() async{
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 20);
    if(pickedFile != null){
      _imageFile = File(pickedFile.path);
      notifyListeners();
    }
    else {
      print('no image selected');
      notifyListeners();
    }
    return _imageFile;

  }

 Future<void> saveEquipmentDataToDb(
     equipmentName,
     rent,
     category,
     context
     ) async {
   var timeStamp = DateTime.now().millisecondsSinceEpoch;
   CollectionReference _products = FirebaseFirestore.instance.collection('equipments');
   try{
     await _products.doc(timeStamp.toString()).set({
       'provider' : {'organizationName': organizationName, 'providerId': 244, 'number': 1215234525, 'adderss': '13, asfag cafasf (m.p.)' },
       'equimentName' : equipmentName,
       'rent' : rent ,
       'category' : category,
       'equipmentID': timeStamp.toString(),
       'productImage': equipmentUrl,
       'availability': true

     });
     alertDialog(
         context: context,
         title: 'SAVE DATA',
         content: 'equipment details saved successfully'
     );
   }catch(e){
     alertDialog(
         context: context,
         title: 'SAVE DATA',
         content: 'e.toString()'
     );
   }
   return;
 }



 Future<String> uploadEquipmentImage(filePath,equipmentName,context) async{
   File file = File(filePath);
   var timeStamp  = Timestamp.now().millisecondsSinceEpoch;
   FirebaseStorage _storage = FirebaseStorage.instance;
   try{
     await _storage.ref('equipmentImage/$organizationName/$equipmentName$timeStamp').putFile(file);

   }on FirebaseException catch(e){
     alertDialog( context: context,
     title: 'STORAGE ERROR',
     content: e.toString());}
   String downloadURL = await _storage.ref('equipmentImage/$organizationName/$equipmentName$timeStamp').getDownloadURL();
   equipmentUrl = downloadURL;
   notifyListeners();
   return downloadURL;
 }


 alertDialog({context,title,content}) {
     showCupertinoDialog(context: context, builder: (BuildContext context){
       return CupertinoAlertDialog(
         title: Text(title),
         content: Text(content),
         actions: <Widget>[
           CupertinoDialogAction(child: const Text('OK'),
           onPressed: () => Navigator.pop(context))
         ],
       );
     });
   }




}