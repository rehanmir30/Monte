import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:monteapp/Constants/colors.dart';
import 'package:monteapp/Controllers/CartController.dart';
import 'package:monteapp/Models/CartModel.dart';
import 'package:monteapp/Screens/package/AddressScreen.dart';
import 'package:monteapp/Screens/package/BuyPackage.dart';
import 'package:monteapp/Widgets/BackButton.dart';
import 'package:monteapp/Widgets/CustomSnackbar.dart';

import '../../Database/databasehelper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }
  @override
  Widget build(BuildContext context) {
    return CartScreenPortrait();
  }
}

class CartScreenPortrait extends StatefulWidget {
  const CartScreenPortrait({super.key});

  @override
  State<CartScreenPortrait> createState() => _CartScreenPortraitState();
}

class _CartScreenPortraitState extends State<CartScreenPortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/loginBgLandscape.jpg"))),
          ),
          const Positioned(
              top: 50,
              child: Text(
                "Cart",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Positioned(
            top: 100,
            child: GetBuilder<CartController>(
              builder: (controller) {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          color: kPink,
                          border: Border.all(color: kYellow, width: 5),
                          borderRadius: BorderRadius.circular(25)),
                      child: controller.cartModel?.cartItems!=null?ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.cartModel?.cartItems?.length,
                        primary: false,
                        itemBuilder: (context, index) {
                          var split=controller.cartModel?.cartItems![index].product!.file.split(".");
                          String type =split.last;
                          return displayItems(controller.cartModel?.cartItems![index],type);
                        },
                      ):Center(child: Text("No items found"),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 170,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 120,
                            decoration: BoxDecoration(
                                color: kPink,
                                border: Border.all(color: kYellow, width: 5),
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex:1,
                                        child: Text("Total Products",style: TextStyle(fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                                    Expanded(
                                        flex:1,
                                        child: Text("${controller.cartModel?.totalProducts??0}",style: TextStyle(fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(
                                        flex:1,
                                        child: Text("Tax",style: TextStyle(fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                                    Expanded(
                                        flex:1,
                                        child: Text("5%",style: TextStyle(fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(
                                        flex:1,
                                        child: Text("Total Price",style: TextStyle(fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                                    Expanded(
                                        flex:1,
                                        child: Text("${controller.cartModel?.totalPrice??0}",style: TextStyle(fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              child: InkWell(
                                onTap:()async{
                                  // Get.to(BuyPackage(controller.cartModel?.totalPrice, "CartScreen"));
                                  if(controller.cartModel!=null){
                                    Get.to(AddressScreen(controller.cartModel!.totalPrice, "CartScreen"));
                                  }else{
                                    CustomSnackbar.show("No items added", kRed);
                                    return;
                                  }

                                },
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.brown
                                  ),
                                  child: Text('Confirm Order',style: TextStyle(color: Colors.white),),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Back(),
        ],
      ),
    );
  }
}

class displayItems extends StatefulWidget {
  CartItem? cartItem;
String type;
  displayItems(this.cartItem, this.type,{super.key});

  @override
  State<displayItems> createState() => _displayItemsState();
}

class _displayItemsState extends State<displayItems> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: widget.type=="pdf"?
        Image.asset("assets/images/pdf.png"):Container(width: 80,height: 50,decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(widget.cartItem?.product!.file))),)),
        Expanded(
            flex: 2,
            child: Text(
              widget.cartItem?.product?.name ?? "",
              textAlign: TextAlign.start,
            ).marginOnly(left: 4)),
        Expanded(
            flex: 1,
            child: Text(widget.cartItem?.product?.price ?? "",style: TextStyle(fontWeight: FontWeight.w700),)
                ),
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: ()async{
                await DatabaseHelper().removeProductFromCart(widget.cartItem);
              },
              child: Container(
                width: 30,
                height:30,
                decoration: const BoxDecoration(
                  color: kRed,
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.remove,color: Colors.white,),
              ),
            ))
      ],
    ).marginAll(10);
  }
}
