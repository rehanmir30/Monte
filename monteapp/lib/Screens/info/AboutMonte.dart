import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monteapp/Constants/colors.dart';

class AboutMonte extends StatefulWidget {
  const AboutMonte({super.key});

  @override
  State<AboutMonte> createState() => _AboutMonteState();
}

class _AboutMonteState extends State<AboutMonte> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const AboutPortrait();
        } else {
          return const AboutLandscape();
        }
      },
    );
  }
}

class AboutPortrait extends StatefulWidget {
  const AboutPortrait({super.key});

  @override
  State<AboutPortrait> createState() => _AboutPortraitState();
}

class _AboutPortraitState extends State<AboutPortrait> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/gameBgPortrait.png"))),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "About Monte Kids",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "The goal of early childhood education should be to cultivate the child's own natural desire to learn",
                        style: TextStyle(fontSize: 18),
                      ).marginAll(12),
                      Text(
                        "Dr. Maria Montessori",
                        style: TextStyle(fontSize: 16),
                      ).marginAll(12),
                    ],
                  ),
                ).marginOnly(top: 12),
                Text(
                  "International Modern Montessori. LLP",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "A firm formed to nurture competent and trained MMI teachers to cater to the needs of the little ones.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Educational Philosophy",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "Dr Maria Montessori was born in Italy in 1870 and became the first woman doctor in the history of her country. She was one of the most influential early childhood education pioneers. She devised a theory with a realistic approach focused on the core concept of children's independence in a carefully designed and structured environment. The Montessori Education System, founded by Dr Maria Montessori, is a child-centred educational methodology centred on empirical studies of children from birth to adulthood. Dr Montessori's Approach has been studied over time, with over 100 years of success in different communities around the world.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("Dr Maria Montessori"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/maria.jpg"))),
                ).marginOnly(top: 12, left: 12, right: 12),
                Text(
                  "What is Montekids - The Montessori School?",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "At Montekids, the Montessori school children construct knowledge in a free and fearless environment through exploration and investigation. Montessori is an instructional approach focused on self-driven practice, hands-on learning, and interactive play. In Montessori classrooms, children make creative choices in learning, while in the prepared environment and the highly trained teachers offer age-appropriate activities to guide the process of development.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                SizedBox(
                  height: 50,
                )
              ],
            ).marginSymmetric(horizontal: 12),
          )
        ],
      ),
    );
  }
}

class AboutLandscape extends StatefulWidget {
  const AboutLandscape({super.key});

  @override
  State<AboutLandscape> createState() => _AboutLandscapeState();
}

class _AboutLandscapeState extends State<AboutLandscape> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/gameBgPortrait.png"))),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "About Monte Kids",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "The goal of early childhood education should be to cultivate the child's own natural desire to learn",
                        style: TextStyle(fontSize: 18),
                      ).marginAll(12),
                      Text(
                        "Dr. Maria Montessori",
                        style: TextStyle(fontSize: 16),
                      ).marginAll(12),
                    ],
                  ),
                ).marginOnly(top: 12),
                Text(
                  "International Modern Montessori. LLP",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "A firm formed to nurture competent and trained MMI teachers to cater to the needs of the little ones.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Educational Philosophy",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "Dr Maria Montessori was born in Italy in 1870 and became the first woman doctor in the history of her country. She was one of the most influential early childhood education pioneers. She devised a theory with a realistic approach focused on the core concept of children's independence in a carefully designed and structured environment. The Montessori Education System, founded by Dr Maria Montessori, is a child-centred educational methodology centred on empirical studies of children from birth to adulthood. Dr Montessori's Approach has been studied over time, with over 100 years of success in different communities around the world.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("Dr Maria Montessori"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/maria.jpg"))),
                ).marginOnly(top: 12, left: 12, right: 12),
                Text(
                  "What is Montekids - The Montessori School?",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "At Montekids, the Montessori school children construct knowledge in a free and fearless environment through exploration and investigation. Montessori is an instructional approach focused on self-driven practice, hands-on learning, and interactive play. In Montessori classrooms, children make creative choices in learning, while in the prepared environment and the highly trained teachers offer age-appropriate activities to guide the process of development.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                SizedBox(
                  height: 50,
                )
              ],
            ).marginSymmetric(horizontal: 12),
          )
        ],
      ),
    );
  }
}
