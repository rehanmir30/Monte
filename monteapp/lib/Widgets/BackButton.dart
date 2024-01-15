import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Back extends StatefulWidget {
  const Back({super.key});

  @override
  State<Back> createState() => _BackState();
}

class _BackState extends State<Back> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50,
        left: 20,
        child: InkWell(
            onTap: (){
              Get.back();
            },
            child: Image.asset("assets/images/back.png",width: 40,height: 40,)));
  }
}
