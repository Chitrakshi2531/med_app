
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_app/services/firebase_services.dart';

class EquipmentList extends StatelessWidget {
  const EquipmentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
      stream: _services.equipments.snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return const Text("Something went wrong...");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        return SingleChildScrollView(
          child: DataTable(
              showBottomBorder: true,
              dataRowHeight: 80,
              headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
              columnSpacing: 10,
              columns: const <DataColumn>[
                DataColumn(label: Center(child: Text('Image'))),
                DataColumn(label: Expanded(child: Text('Equipment'))),
                DataColumn(label: Text('Available')),
                DataColumn(label: Text('')),

              ],
              rows: snapshot.data!.docs.map<DataRow>((document){
               var available = 'No' ;
               if(document['availability']==true) {
                 available = 'Yes';
               } else {
                 available = 'No';
               }
                      return DataRow(
                        cells: [
                            DataCell(
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
                                    child: SizedBox(
                                      width: 60,
                                      height: 80,
                                      child: Center(
                                        child: Image.network(document['productImage']),
                                      ),
                                    ),
                                  ),
                                ),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 100,
                                  child: Text(document['equimentName']))
                            ),
                            DataCell(
                              Center(child: Text(available)),
                            ),
                            DataCell(
                                popUpButton(document.data(),context)
                              ),


                          ]
                        );
                   }).toList() ,
            ),
        );
      }
    );
  }

  Widget popUpButton(data,BuildContext context){
    return PopupMenuButton<String>(
    onSelected: (String value){
      print(value);
    },
    itemBuilder: (BuildContext context)=> <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'unavailable',
        child: ListTile(
          leading: Icon(Icons.check),
          title: Text('Unavailable')
        )
      ),

      const PopupMenuItem<String>(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit_outlined),
            title: Text('Edit ')
          )
      ),
      const PopupMenuItem<String>(
        value: 'delete',
        child: ListTile(
          leading: Icon(Icons.delete_outline),
          title: Text('Delete')
        )
      ),
  ]);
  }
}
