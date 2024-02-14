import 'package:get/get.dart';
import 'package:monteapp/Models/PackageModel.dart';

class PackageController extends GetxController{
  PackageModel _packageModel=PackageModel();
  PackageModel get packageModel=>_packageModel;

  int _price=0;
  int _taxPrice=0;
  int get price=>_price;
  int get taxPrice=>_taxPrice;

  setPrice(bool value){
    if(value){
      double pkgPrice = double.parse(_packageModel.data!.package!.price);
      double bndlPrice = double.parse(_packageModel.data!.bundle!.price);
      _price=pkgPrice.toInt()+bndlPrice.toInt();
    }else{
      double pkgPrice = double.parse(_packageModel.data!.package!.price);
      _price=pkgPrice.toInt();
    }
    update();
  }
  addTax(double percent){
    var tax=(_price*percent);
    _taxPrice=_price+tax.toInt();

    update();
  }

  setPackageModel(PackageModel packageModel){
    _packageModel=packageModel;
    update();
  }

}