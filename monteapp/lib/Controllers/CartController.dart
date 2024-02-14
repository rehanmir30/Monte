import 'package:get/get.dart';
import 'package:monteapp/Models/CartModel.dart';

class CartController extends GetxController{

  CartModel? _cartModel=CartModel();
  CartModel? get cartModel=>_cartModel;

  setCartModel(CartModel? cartModel){
    _cartModel=cartModel;
    if(cartModel?.totalPrice!=null){
      setCartTotalPrice();
    }
    update();
  }
  setCartTotalPrice(){
    double numberDouble = double.parse(_cartModel?.totalPrice);
    int price=numberDouble.toInt();
    var tax=(price*0.05);
    _cartModel?.totalPrice=price+tax;
    _cartModel?.totalPrice=_cartModel?.totalPrice.toString();
  }


}