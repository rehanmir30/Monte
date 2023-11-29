import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Controllers/ShopController.dart';
import 'package:monteapp/Models/ShopProduct.dart';

import '../../../Constants/colors.dart';
import '../../../Database/databasehelper.dart';

class ToysPortrait extends StatefulWidget {
  const ToysPortrait({super.key});

  @override
  State<ToysPortrait> createState() => _ToysPortraitState();
}

class _ToysPortraitState extends State<ToysPortrait> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(builder: (controller) {
        return (controller.toyShopModel.products?.length??0)<1?
            Center(child: Text("No Toys found"),)
            : GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.5,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5),
          itemCount: controller.toyShopModel.products?.length,
          itemBuilder: (context, index) {
            return ShopItem(controller.toyShopModel.products![index]);
          },
        ).marginSymmetric(horizontal: 12);
      },);

  }
}

class ShopItem extends StatefulWidget {
  final ShopProduct _shopProduct;
  const ShopItem(this._shopProduct,{super.key});

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assets/images/blankContainer.png"))),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
              top: 35,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                        image: NetworkImage(widget._shopProduct.file)
                        // AssetImage("assets/images/toy.png")
                    )),
              )),
          Positioned(
            bottom: 20,
            child: Container(
              width: 120,
              height: 140,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    bottom: 20,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.brown, width: 3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget._shopProduct.name,style: const TextStyle(color: kPink,fontSize: 16,fontWeight: FontWeight.w700),),
                          SizedBox(height: 10,),
                          Text("\$${widget._shopProduct.price}",style: TextStyle(color: kPink),),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      child: InkWell(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.scaleDown,
                                        image:
                                        AssetImage("assets/images/loginLandscapeContainer.png"),
                                      )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Image.asset(
                                          "assets/images/balloons.png",
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                      Text(
                                        "Add ${widget._shopProduct.name} \nto cart?",
                                        style: const TextStyle(color: Colors.white, fontSize: 14),
                                        textAlign: TextAlign.left,
                                      ).marginOnly(
                                        top: 12,
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Material(
                                            elevation: 10,
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(60),
                                            child: InkWell(
                                              onTap: () async {
                                                await DatabaseHelper().playTapAudio();
                                                await DatabaseHelper().addProductToCart(widget._shopProduct);
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(60),
                                                  border: Border.all(color: Colors.yellow),
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xff104e99),
                                                      Color(0xff8dabc9)
                                                    ],
                                                    // Define your gradient colors
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Add to cart",
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 12),
                                                ),
                                              ),
                                            )).marginOnly(top: 20),
                                      ),
                                    ],
                                  ).marginSymmetric(vertical: 20, horizontal: 30),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Text('BUY NOW',style: TextStyle(color: Colors.white,fontSize: 12),),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
