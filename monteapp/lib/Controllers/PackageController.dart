import 'package:get/get.dart';
import 'package:monteapp/Models/PackageModel.dart';

class PackageController extends GetxController{
  PackageModel _packageModel=PackageModel();
  PackageModel get packageModel=>_packageModel;

  setPackageModel(PackageModel packageModel){
    _packageModel=packageModel;
    update();
  }

}