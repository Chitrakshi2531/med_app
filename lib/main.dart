import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:med_app/providers/equipment_provider.dart';
import 'package:med_app/screens/add_newequipment_screen.dart';
import 'package:med_app/screens/dashboard_screen.dart';
import 'package:med_app/services/drawer_services.dart';
import 'package:provider/provider.dart';

import 'widgets/menu_widget.dart';
import 'package:firebase_core/firebase_core.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();


  runApp(
          ChangeNotifierProvider(
              create: (context) => EquipmentProvider(),
              child: const HomeScreen()
          )
  );
}


class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';

  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _initialized = false;
  bool _error = false;
  void initializedFlutterFire() async{
    try{
      await Firebase.initializeApp();
      setState((){
        _initialized = true;
      });
  }catch(e){
      setState((){
        _error = true;
  });
  }
}
  final DrawerServices _services = DrawerServices();
  final GlobalKey<SliderMenuContainerState> _key =
  GlobalKey<SliderMenuContainerState>();
  late String title;
  @override
  void initState() {
    title = "Home";
    initializedFlutterFire();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(_error){
      return const MaterialApp(
          home: Scaffold(
              body: Center(child: Text("something went worng"))
              )
          );
    }
    if(!_initialized){
      return const MaterialApp(
        home: Scaffold(
            body: Center(child: Text("loading"))
        )
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        primaryColor: const Color(0xff7ac425),
        selectedRowColor: const Color(0xff85c425),
      ),
      home: Scaffold(
        body: SliderMenuContainer(
            appBarColor: const Color(0xff85c425),
            appBarHeight:80,
            key: _key,
            sliderMenuOpenSize: 250,
            title: const Text('',),
            sliderMenu: MenuWidget(
              onItemClick: (title) {
                _key.currentState!.closeDrawer();
                setState(() {
                  this.title = title;
                });
              },
            ),
            sliderMain: _services.drawerScreen(title)),
      ),

      routes: {
        MainScreen.id :(context)=> const MainScreen(),
        AddNewProduct.id :(context)=> const AddNewProduct(),
      }
    );
  }
}
