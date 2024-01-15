import 'package:get/get.dart';

class LoadingController extends GetxController{
  bool _showLoading=false;
  bool get showLoading=>_showLoading;

  setLoading(bool value){
    _showLoading=value;
    update();
  }

}