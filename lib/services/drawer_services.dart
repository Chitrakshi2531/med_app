import 'package:flutter/material.dart';
import 'package:med_app/screens/about_screen.dart';
import 'package:med_app/screens/feedback_screen.dart';
import 'package:med_app/screens/equipment_screen.dart';
import 'package:med_app/screens/request_screen.dart';
import 'package:med_app/screens/settings_screen.dart';

import '../screens/dashboard_screen.dart';

class DrawerServices{
  Widget drawerScreen(title){
    if(title == 'Dashboard'){
      return const MainScreen();
    }
    if(title == 'Equipments'){
      return const EquipmentScreen();
    }
    if(title == 'Request'){
      return const RequestScreen();
    }
    if(title == 'About'){
      return const AboutScreen();
    }
    if(title == 'Feedback'){
      return const FeedbackScreen();
    }
    if(title == 'Setting'){
        return const SettingsScreen();
    }
    return const MainScreen();
  }
}