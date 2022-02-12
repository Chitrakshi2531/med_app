import 'package:flutter/material.dart';
import 'package:med_app/widgets/equipment_list.dart';

import 'add_newequipment_screen.dart';

class EquipmentScreen extends StatefulWidget {
  const EquipmentScreen({Key? key}) : super(key: key);

  @override
  _EquipmentScreenState createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: const [
                        Text("Equipment"),
                        SizedBox(width: 10,),
                        CircleAvatar(
                          backgroundColor: Colors.black54,
                          maxRadius: 8,
                          child:  FittedBox(
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text('20', style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold), ),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Expanded(child: EquipmentList()),
          ),

        ],
      ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10),
            child: FloatingActionButton(
                elevation: 0.0,
                child: const Icon(Icons.add,color: Colors.white),
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: (){
                  Navigator.pushNamed(context, AddNewProduct.id);
                }
            ),
        ),
    );
  }
}
