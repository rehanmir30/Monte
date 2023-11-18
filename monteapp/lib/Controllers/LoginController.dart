

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

TextEditingController _phone=TextEditingController();
TextEditingController get phone=>_phone;

int _timerSeconds = 120;

int get timerSeconds=>_timerSeconds;

bool _isButtonDisabled=false;
bool get isButtonDisabled=>_isButtonDisabled;



TextEditingController _otp=TextEditingController();
TextEditingController get otp=>_otp;


setNameController(String txt){
  _phone.text=txt;
  update();
}

String formattedTimer() {
  int minutes = timerSeconds ~/ 60;
  int seconds = timerSeconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
void startTimer() {
  _isButtonDisabled=true;
  Timer.periodic(Duration(seconds: 1), (timer) {
    if (timerSeconds > 0) {
        _timerSeconds--;
        update();
    } else {
      timer.cancel();
        _isButtonDisabled = false;
        _timerSeconds = 120;
        update();
    }
  });
}

}