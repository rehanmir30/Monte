

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Models/UserModel.dart';

class UserController extends GetxController{

  UserModel _userModel=UserModel();
  UserModel get userModel=>_userModel;

  setUser(UserModel _user){
    _userModel=_user;
    update();
  }

}