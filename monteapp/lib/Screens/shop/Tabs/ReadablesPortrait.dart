import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Constants/colors.dart';
import 'package:monteapp/Controllers/ShopController.dart';
import 'package:monteapp/Database/databasehelper.dart';
import 'package:monteapp/Models/ShopProduct.dart';

class ReadablesPortrait extends StatefulWidget {
  const ReadablesPortrait({super.key});

  @override
  State<ReadablesPortrait> createState() => _ReadablesPortraitState();
}

class _ReadablesPortraitState extends State<ReadablesPortrait> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/blankContainer.png"))),
      child: Row(
        children: [
          Expanded(flex: 1, child: Image.asset("assets/images/backarrow.png")),
          Expanded(
              flex: 4,
              child: GetBuilder<ShopController>(
                builder: (controller) {
                  return (controller.materialShopModel.products?.length??0)<1?  Center(child: Text("No Readables found"),):
                    ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        (controller.materialShopModel.products?.length ?? 0) <
                                7
                            ? controller.materialShopModel.products?.length ??
                                0
                            : 6,
                    primary: false,
                    itemBuilder: (context, index) {
                      return ListItem(
                          controller.materialShopModel.products![index]);
                    },
                  );
                },
              )),
          Expanded(flex: 1, child: Image.asset("assets/images/nextarrow.png")),
        ],
      ).marginSymmetric(horizontal: 5),
    ).marginAll(30);
  }
}

class ListItem extends StatefulWidget {
  final ShopProduct shopProduct;

  const ListItem(this.shopProduct, {super.key});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          // barrierDismissible: false,
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
                      "Add ${widget.shopProduct.name} \nto cart?",
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
                              await DatabaseHelper().addProductToCart(widget.shopProduct);
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
      child: Row(
        children: [
          Image.asset("assets/images/pdf.png"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.shopProduct.name}",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              ),
              Text(
                "${widget.shopProduct.description}",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              )
            ],
          ).marginOnly(left: 8)
        ],
      ).marginSymmetric(vertical: 10),
    );
  }
}
