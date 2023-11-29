import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:monteapp/Database/databasehelper.dart';
import 'package:monteapp/Screens/shop/Tabs/ReadablesLandscape.dart';
import 'package:monteapp/Screens/shop/Tabs/ReadablesPortrait.dart';
import 'package:monteapp/Screens/shop/Tabs/ToysLandscape.dart';
import 'package:monteapp/Screens/shop/Tabs/ToysPortrait.dart';

import '../../Constants/colors.dart';
import '../../Controllers/CartController.dart';
import 'CartScreen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {


  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const ShopPortrait();
        } else {
          return const ShopLandscape();
        }
      },
    );
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    getProducts();
  }
  getProducts()async{
    await DatabaseHelper().getShopProducts("material");
    await DatabaseHelper().getShopProducts("toys");
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }
}

class ShopPortrait extends StatefulWidget {
  const ShopPortrait({super.key});

  @override
  State<ShopPortrait> createState() => _ShopPortraitState();
}

class _ShopPortraitState extends State<ShopPortrait>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Add the listener
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // Rebuild the widget when the tab changes
        setState(() {});
      }
    });
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          Positioned(
              right: 0,
              top: 10,
              child: InkWell(
                  onTap: (){
                    Get.to(const CartScreen(),transition: Transition.zoom);
                  },
                  child:Container(
                      width: 80,
                      height: 80,
                      child: Stack(
                        children: [
                          Image.asset("assets/images/cartIcon.png"),
                          Positioned(
                            right: 20,
                            top: 10,
                            child: GetBuilder<CartController>(builder: (controller2) {
                              return  Visibility(
                                visible: controller2.cartModel==null?false:true,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: kRed,
                                      shape: BoxShape.circle
                                  ),
                                ),
                              );
                            },)
                            ,
                          )
                        ],
                      ))
              )),
          const Positioned(
              top: 60,
              child: Text(
                "Shop",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Positioned(
            top: 90,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 49,
                    child: TabBar(
                      controller: _tabController,
                      labelStyle: const TextStyle(fontSize: 18.0),
                      indicator: BoxDecoration(
                        color: kPink,
                        border: Border.all(color: kRed, width: 3),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: _tabController.index == 0
                                  ? Colors.transparent
                                  : kYellow,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            child: Text(
                              "Readables",
                              style: TextStyle(
                                  color: _tabController.index == 0
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: _tabController.index == 1
                                  ? Colors.transparent
                                  : kYellow,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            child: Text(
                              "Toys",
                              style: TextStyle(
                                  color: _tabController.index == 1
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).marginSymmetric(horizontal: 12),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ReadablesPortrait(),
                        ToysPortrait(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShopLandscape extends StatefulWidget {
  const ShopLandscape({super.key});

  @override
  State<ShopLandscape> createState() => _ShopLandscapeState();
}

class _ShopLandscapeState extends State<ShopLandscape>  with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Add the listener
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // Rebuild the widget when the tab changes
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          Positioned(
            top: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width*0.9,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: Container(
                      width: 49, // Changed from height to width
                      child: TabBar(
                        controller: _tabController,
                        labelStyle: const TextStyle(fontSize: 18.0),
                        indicator: BoxDecoration(
                          color: kPink,
                          border: Border.all(color: kRed, width: 3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height, // Changed width to height
                              decoration: BoxDecoration(
                                color: _tabController.index == 0 ? Colors.transparent : kYellow,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "Readables",
                                style: TextStyle(color: _tabController.index == 0 ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height, // Changed width to height
                              decoration: BoxDecoration(
                                color: _tabController.index == 1 ? Colors.transparent : kYellow,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                "Toys",
                                style: TextStyle(color: _tabController.index == 1 ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).marginSymmetric(horizontal: 12),
                  ),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ReadablesLandscape(),
                          ToysLandscape(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),


            ),
          )
        ],
      ),
    );
  }
}
