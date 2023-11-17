import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Constants/colors.dart';

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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/blankContainer.png")
        )
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Image.asset("assets/images/backarrow.png")),
          Expanded(
              flex: 4,
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  primary: false,
                  itemBuilder: (context, index) {
                    return ListItem();
                  },
                ),
              )),
          Expanded(
              flex: 1,
              child: Image.asset("assets/images/nextarrow.png")),

        ],
      ).marginSymmetric(horizontal: 5),
    ).marginAll(30);
  }
}

class ListItem extends StatefulWidget {
  const ListItem({super.key});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/images/pdf.png"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Story Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),),
            Text("Short description goes here",style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 12),)
          ],
        ).marginOnly(left: 8)
      ],
    ).marginSymmetric(vertical: 10);
  }
}

