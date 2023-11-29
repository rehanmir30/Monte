import 'package:get/get.dart';
import 'package:monteapp/Models/ShopModel.dart';

class ShopController extends GetxController{
  ShopModel _materialShopModel=ShopModel();
  ShopModel _toyShopModel=ShopModel();
  ShopModel get materialShopModel=>_materialShopModel;
  ShopModel get toyShopModel=>_toyShopModel;

  setMaterialShopModel(ShopModel shopModel){
    _materialShopModel=shopModel;
    update();
  }

  setToyShopModel(ShopModel shopModel){
    _toyShopModel=shopModel;
    update();
  }

}