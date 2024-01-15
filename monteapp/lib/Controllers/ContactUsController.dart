import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController{
  TextEditingController _nameController=TextEditingController();
  TextEditingController get nameController=>_nameController;
  TextEditingController _emailController=TextEditingController();
  TextEditingController get emailController=>_emailController;
  TextEditingController _phoneController=TextEditingController();
  TextEditingController get phoneController=>_phoneController;
  TextEditingController _messageController=TextEditingController();
  TextEditingController get messageController=>_messageController;

}