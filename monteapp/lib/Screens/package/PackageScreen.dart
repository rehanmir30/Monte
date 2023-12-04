import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Constants/colors.dart';
import 'package:monteapp/Controllers/PackageController.dart';
import 'package:monteapp/Models/PackageModel.dart';

import 'BuyPackage.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const PackagePortrait();
        } else {
          return const PackageLandscape();
        }
      },
    );
  }
}

class PackagePortrait extends StatefulWidget {
  const PackagePortrait({super.key});

  @override
  State<PackagePortrait> createState() => _PackagePortraitState();
}

class _PackagePortraitState extends State<PackagePortrait> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/loginBgPortrait.jpg"))),
          ),
          Positioned(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/blankContainer.png"),
              )),
              child: GetBuilder<PackageController>(
                builder: (controller) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 185,
                        height: 140,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/otpballoons.png"))),
                      ),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: kRed,
                              border: Border.all(color: kYellow),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            controller.packageModel.data!.package!.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ).paddingSymmetric(horizontal: 12, vertical: 12),
                        ),
                      ),
                      Text(
                        controller.packageModel.data!.package!.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ).marginOnly(top: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "In Only",
                          ),
                          Text(
                            "${controller.price}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ).marginOnly(left: 8),
                        ],
                      ).marginOnly(right: 30, top: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: kRed,
                            checkColor: Colors.white,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isChecked = newValue ?? false;
                              });
                              Get.find<PackageController>().setPrice(isChecked);
                            },
                          ),
                          Text(
                            'Order bundle for your Kid',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ).marginSymmetric(horizontal: 20),
                      Visibility(
                        visible: isChecked,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.6,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5),
                            itemCount: controller
                                .packageModel.data!.bundle!.products!.length,
                            itemBuilder: (context, index) {
                              return PackageProductTile(controller
                                  .packageModel.data!.bundle!.products![index]);
                            },
                          ).marginSymmetric(horizontal: 20),
                        ),
                      ),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                BuyPackage(
                                    controller.packageModel.data!.package!
                                            .price ??
                                        0,
                                    "BuyPackage"),
                                transition: Transition.upToDown);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kRed,
                                border: Border.all(color: kYellow),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Buy now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ).paddingSymmetric(horizontal: 12, vertical: 12),
                          ),
                        ),
                      ).marginOnly(top: 8),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
              top: 40,
              right: 0,
              child: Text(
                "Trial version",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ).marginOnly(right: 10))
        ],
      ),
    );
  }
}

class PackageLandscape extends StatefulWidget {
  const PackageLandscape({super.key});

  @override
  State<PackageLandscape> createState() => _PackageLandscapeState();
}

class _PackageLandscapeState extends State<PackageLandscape> {

  bool isChecked = true;

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
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/blankContainerLandscape.png"),
            )),
            child: GetBuilder<PackageController>(builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: kRed,
                              border: Border.all(color: kYellow),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            controller.packageModel.data!.package!.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ).paddingSymmetric(horizontal: 12, vertical: 12),
                        ),
                      ),
                      Text(
                        controller.packageModel.data!.package!.description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ).marginOnly(top: 20),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "In Only",
                          ),
                          Text(
                            "${controller.price}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ).marginOnly(left: 8),
                        ],
                      ).marginOnly(right: 30, top: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: kRed,
                            checkColor: Colors.white,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isChecked = newValue ?? false;
                              });
                              Get.find<PackageController>().setPrice(isChecked);
                            },
                          ),
                          Text(
                            'Order bundle for your Kid',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ).marginSymmetric(horizontal: 20),
                      Visibility(
                        visible: isChecked,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                          width: 200,
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 1),
                            itemCount: controller
                                .packageModel.data!.bundle!.products!.length,
                            itemBuilder: (context, index) {
                              return
                                PackageProductTile(controller
                                  .packageModel.data!.bundle!.products![index]);
                            },
                          ).marginSymmetric(horizontal: 20),
                        ),
                      ),
                    ],
                  ).marginSymmetric(vertical: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 185,
                        height: 140,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/otpballoons.png"))),
                      ),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                BuyPackage(
                                    controller.packageModel.data!.package!
                                            .price ??
                                        0,
                                    "BuyPackage"),
                                transition: Transition.upToDown);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: kRed,
                                border: Border.all(color: kYellow),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Buy now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ).paddingSymmetric(horizontal: 12, vertical: 12),
                          ),
                        ),
                      ).marginOnly(top: 8),
                    ],
                  )
                ],
              ).marginSymmetric(horizontal: 35);
            }),
          )
        ],
      ),
    );
  }
}

class PackageProductTile extends StatefulWidget {
  final Product _product;

  const PackageProductTile(this._product, {super.key});

  @override
  State<PackageProductTile> createState() => _PackageProductTileState();
}

class _PackageProductTileState extends State<PackageProductTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          height: 70,
          // height: MediaQuery.of(context).size.height*0.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image:
                  DecorationImage(image: NetworkImage(widget._product.file))),
        ),
        Text(
          widget._product.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ).marginOnly(top: 4),
        Text(
          widget._product.price,
          style: TextStyle(fontWeight: FontWeight.w600),
        ).marginOnly(top: 4),
      ],
    );
  }
}
