import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/colors.dart';

class ToysPortrait extends StatefulWidget {
  const ToysPortrait({super.key});

  @override
  State<ToysPortrait> createState() => _ToysPortraitState();
}

class _ToysPortraitState extends State<ToysPortrait> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.5,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ShopItem();
      },
    ).marginSymmetric(horizontal: 12);
  }
}

class ShopItem extends StatefulWidget {
  const ShopItem({super.key});

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
                    image: const DecorationImage(
                      fit: BoxFit.contain,
                        image: AssetImage("assets/images/toy.png"))),
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
                        children: const [
                          Text("Elephant toy",style: TextStyle(color: kPink,fontSize: 16,fontWeight: FontWeight.w700),),
                          SizedBox(height: 10,),
                          Text("\$100.00",style: TextStyle(color: kPink),),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      child: Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Text('BUY NOW',style: TextStyle(color: Colors.white,fontSize: 12),),
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
