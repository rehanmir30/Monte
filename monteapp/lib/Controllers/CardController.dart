import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CardController extends GetxController{

  TextEditingController _nameController=TextEditingController();
  TextEditingController get nameController=>_nameController;
  TextEditingController _cardNumberController=TextEditingController();
  TextEditingController get cardNumberController=>_cardNumberController;
  TextEditingController _monthController=TextEditingController();
  TextEditingController get monthController=>_monthController;
  TextEditingController _yearController=TextEditingController();
  TextEditingController get yearController=>_yearController;
  TextEditingController _cvvController=TextEditingController();
  TextEditingController get cvvController=>_cvvController;
  TextEditingController _expDateController=TextEditingController();
  TextEditingController get expDateController=>_expDateController;

}