import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddressController extends GetxController{
  TextEditingController _homeAddress=TextEditingController();
  TextEditingController get homeAddress=>_homeAddress;
  TextEditingController _city=TextEditingController();
  TextEditingController get city=>_city;
  TextEditingController _state=TextEditingController();
  TextEditingController get state=>_state;
  TextEditingController _country=TextEditingController();
  TextEditingController get country=>_country;
  TextEditingController _postalCode=TextEditingController();
  TextEditingController get postalCode=>_postalCode;
}