import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:monteapp/Models/LevelModel.dart';

import 'LevelsController.dart';

class SignupController extends GetxController{

  TextEditingController _phone=TextEditingController();
  TextEditingController _name=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _age=TextEditingController();
  LevelModel? _selectedLevel;
  LevelModel? get selectedLevel=>_selectedLevel;

  TextEditingController get phone=>_phone;
  TextEditingController get name=>_name;
  TextEditingController get email=>_email;
  TextEditingController get age=>_age;

  setSelectedLevel(LevelModel model){
    _selectedLevel=model;
    update();
  }



}