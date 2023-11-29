import 'package:get/get.dart';
import 'package:monteapp/Models/CartModel.dart';

class CartController extends GetxController{

  CartModel? _cartModel=CartModel();
  CartModel? get cartModel=>_cartModel;

  setCartModel(CartModel? cartModel){
    _cartModel=cartModel;
    update();
  }


}