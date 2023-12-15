import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/colors.dart';

class TermsOfUse extends StatefulWidget {
  const TermsOfUse({super.key});

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const TermsPortrait();
        } else {
          return const TermsLandscape();
        }
      },
    );
  }
}
class TermsPortrait extends StatefulWidget {
  const TermsPortrait({super.key});

  @override
  State<TermsPortrait> createState() => _TermsPortraitState();
}

class _TermsPortraitState extends State<TermsPortrait> {
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
                  "TERMS OF SERVICE",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Overview",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "This website is operated by INTERNATIONAL MODERN MONTESSORI LLP. Throughout the site, the terms “we”, “us” and “our” refer to INTERNATIONAL MODERN MONTESSORI LLP. INTERNATIONAL MODERN MONTESSORI LLP offers this website, including all information, tools and services available from this site to you, the user, conditioned upon your acceptance of all terms, conditions, policies and notices stated here.\nBy visiting our site and/ or purchasing something from us, you engage in our “Service” and agree to be bound by the following terms and conditions (“Terms of Service”, “Terms”), including those additional terms and conditions and policies referenced herein and/or available by hyperlink. These Terms of Service apply to all users of the site, including without limitation users who are browsers, vendors, customers, merchants, and/ or contributors of content.\nPlease read these Terms of Service carefully before accessing or using our website. By accessing or using any part of the site, you agree to be bound by these Terms of Service. If you do not agree to all the terms and conditions of this agreement, then you may not access the website or use any services. If these Terms of Service are considered an offer, acceptance is expressly limited to these Terms of Service.\nAny new features or tools which are added to the current store shall also be subject to the Terms of Service. You can review the most current version of the Terms of Service at any time on this page. We reserve the right to update, change or replace any part of these Terms of Service by posting updates and/or changes to our website. It is your responsibility to check this page periodically for changes. Your continued use of or access to the website following the posting of any changes constitutes acceptance of those changes.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 1 – Online Store Terms",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "By agreeing to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.\nYou may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws).\nYou must not transmit any worms or viruses or any code of a destructive nature.\nYou must not transmit any worms or viruses or any code of a destructive nature.\nA breach or violation of any of the Terms will result in an immediate termination of your Services.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 2 – General Conditions",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "We reserve the right to refuse service to anyone for any reason at any time.\nYou understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmissions over various networks; and (b) changes to conform and adapt to technical requirements of connecting networks or devices. Credit card information is always encrypted during transfer over networks.\nYou agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service or any contact on the website through which the service is provided, without express written permission by us.\nThe headings used in this agreement are included for convenience only and will not limit or otherwise affect these Terms.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 3 - Accuracy, Completeness and Timeliness of Information",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "We are not responsible if information made available on this site is not accurate, complete or current. The material on this site is provided for general information only and should not be relied upon or used as the sole basis for making decisions without consulting primary, more accurate, more complete or more timely sources of information. Any reliance on the material on this site is at your own risk.\nThis site may contain certain historical information. Historical information, necessarily, is not current and is provided for your reference only. We reserve the right to modify the contents of this site at any time, but we have no obligation to update any information on our site. You agree that it is your responsibility to monitor changes to our site.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 4 - Modifications to the Service and Prices",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "Prices for our products are subject to change without notice.\nWe reserve the right at any time to modify or discontinue the Service (or any part or content thereof) without notice at any time.\nWe shall not be liable to you or to any third-party for any modification, price change, suspension or discontinuance of the Service.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 5 - Products or Services",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "Certain products or services may be available exclusively online through the website. These products or services may have limited quantities and are subject to return or exchange only according to our Return Policy.\nWe have made every effort to display as accurately as possible the colors and images of our products that appear at the store. We cannot guarantee that your computer monitor's display of any color will be accurate.\nWe reserve the right, but are not obligated, to limit the sales of our products or Services to any person, geographic region or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at anytime without notice, at the sole discretion of us. We reserve the right to discontinue any\nWe do not warrant that the quality of any products, services, information, or other material purchased or obtained by you will meet your expectations, or that any errors in the Service will be corrected.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 6 - Accuracy of Billing and Account Information",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household or per order. These restrictions may include orders placed by or under the same customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors.\nYou agree to provide current, complete and accurate purchase and account information for all purchases made at our store. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.\nFor more detail, please review our Returns Policy.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 7 - Optional Tools",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "We may provide you with access to third-party tools over which we neither monitor nor have any control nor input.\nYou acknowledge and agree that we provide access to such tools ”as is” and “as available” without any warranties, representations or conditions of any kind and without any endorsement. We shall have no liability whatsoever arising from or relating to your use of optional third-party tools.\nAny use by you of optional tools offered through the site is entirely at your own risk and discretion and you should ensure that you are familiar with and approve of the terms on which tools are provided by the relevant third-party provider(s).\nWe may also, in the future, offer new services and/or features through the website (including, the release of new tools and resources). Such new features and/or services shall also be subject to these Terms of Service.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 8 - Third Party Links",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "Certain content, products and services available via our Service may include materials from third-parties.\nThird-party links on this site may direct you to third-party websites that are not affiliated with us. We are not responsible for examining or evaluating the content or accuracy and we do not warrant and will not have any liability or responsibility for any third-party materials or websites, or for any other materials, products, or services of third-parties.\nWe are not liable for any harm or damages related to the purchase or use of goods, services, resources, content, or any other transactions made in connection with any third-party websites. Please review carefully the third-party's policies and practices and make sure you understand them before you engage in any transaction. Complaints, claims, concerns, or questions regarding third-party products should be directed to the third-party.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 9 - User Comments, Feedback and Other Submissions",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "If, at our request, you send certain specific submissions (for example contest entries) or without a request from us you send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, by postal mail, or otherwise (collectively, 'comments'), you agree that we may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise use in any medium any comments that you forward to us. We are and shall be under no obligation (1) to maintain any comments in confidence; (2) to pay compensation for any comments; or (3) to respond to any comments.\nWe may, but have no obligation to, monitor, edit or remove content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or violates any party’s intellectual property or these Terms of Service.\nYou agree that your comments will not violate any right of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary right. You further agree that your comments will not contain libelous or otherwise unlawful, abusive or obscene material, or contain any computer virus or other malware that could in any way affect the operation of the Service or any related website. You may not use a false e-mail address, pretend to be someone other than yourself, or otherwise mislead us or third-parties as to the origin of any comments. You are solely responsible for any comments you make and their accuracy. We take no responsibility and assume no liability for any comments posted by you or any third-party.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 10 - Personal Information",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "Your submission of personal information through the store is governed by our Privacy Policy.",
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

class TermsLandscape extends StatefulWidget {
  const TermsLandscape({super.key});

  @override
  State<TermsLandscape> createState() => _TermsLandscapeState();
}

class _TermsLandscapeState extends State<TermsLandscape> {
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
                  "TERMS OF SERVICE",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Overview",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "This website is operated by INTERNATIONAL MODERN MONTESSORI LLP. Throughout the site, the terms “we”, “us” and “our” refer to INTERNATIONAL MODERN MONTESSORI LLP. INTERNATIONAL MODERN MONTESSORI LLP offers this website, including all information, tools and services available from this site to you, the user, conditioned upon your acceptance of all terms, conditions, policies and notices stated here.\nBy visiting our site and/ or purchasing something from us, you engage in our “Service” and agree to be bound by the following terms and conditions (“Terms of Service”, “Terms”), including those additional terms and conditions and policies referenced herein and/or available by hyperlink. These Terms of Service apply to all users of the site, including without limitation users who are browsers, vendors, customers, merchants, and/ or contributors of content.\nPlease read these Terms of Service carefully before accessing or using our website. By accessing or using any part of the site, you agree to be bound by these Terms of Service. If you do not agree to all the terms and conditions of this agreement, then you may not access the website or use any services. If these Terms of Service are considered an offer, acceptance is expressly limited to these Terms of Service.\nAny new features or tools which are added to the current store shall also be subject to the Terms of Service. You can review the most current version of the Terms of Service at any time on this page. We reserve the right to update, change or replace any part of these Terms of Service by posting updates and/or changes to our website. It is your responsibility to check this page periodically for changes. Your continued use of or access to the website following the posting of any changes constitutes acceptance of those changes.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 1 – Online Store Terms",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "By agreeing to these Terms of Service, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.\nYou may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws).\nYou must not transmit any worms or viruses or any code of a destructive nature.\nYou must not transmit any worms or viruses or any code of a destructive nature.\nA breach or violation of any of the Terms will result in an immediate termination of your Services.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 2 – General Conditions",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "We reserve the right to refuse service to anyone for any reason at any time.\nYou understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmissions over various networks; and (b) changes to conform and adapt to technical requirements of connecting networks or devices. Credit card information is always encrypted during transfer over networks.\nYou agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service or any contact on the website through which the service is provided, without express written permission by us.\nThe headings used in this agreement are included for convenience only and will not limit or otherwise affect these Terms.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 3 - Accuracy, Completeness and Timeliness of Information",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "We are not responsible if information made available on this site is not accurate, complete or current. The material on this site is provided for general information only and should not be relied upon or used as the sole basis for making decisions without consulting primary, more accurate, more complete or more timely sources of information. Any reliance on the material on this site is at your own risk.\nThis site may contain certain historical information. Historical information, necessarily, is not current and is provided for your reference only. We reserve the right to modify the contents of this site at any time, but we have no obligation to update any information on our site. You agree that it is your responsibility to monitor changes to our site.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 4 - Modifications to the Service and Prices",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "Prices for our products are subject to change without notice.\nWe reserve the right at any time to modify or discontinue the Service (or any part or content thereof) without notice at any time.\nWe shall not be liable to you or to any third-party for any modification, price change, suspension or discontinuance of the Service.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 5 - Products or Services",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "Certain products or services may be available exclusively online through the website. These products or services may have limited quantities and are subject to return or exchange only according to our Return Policy.\nWe have made every effort to display as accurately as possible the colors and images of our products that appear at the store. We cannot guarantee that your computer monitor's display of any color will be accurate.\nWe reserve the right, but are not obligated, to limit the sales of our products or Services to any person, geographic region or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at anytime without notice, at the sole discretion of us. We reserve the right to discontinue any\nWe do not warrant that the quality of any products, services, information, or other material purchased or obtained by you will meet your expectations, or that any errors in the Service will be corrected.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 6 - Accuracy of Billing and Account Information",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household or per order. These restrictions may include orders placed by or under the same customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors.\nYou agree to provide current, complete and accurate purchase and account information for all purchases made at our store. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.\nFor more detail, please review our Returns Policy.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 7 - Optional Tools",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "We may provide you with access to third-party tools over which we neither monitor nor have any control nor input.\nYou acknowledge and agree that we provide access to such tools ”as is” and “as available” without any warranties, representations or conditions of any kind and without any endorsement. We shall have no liability whatsoever arising from or relating to your use of optional third-party tools.\nAny use by you of optional tools offered through the site is entirely at your own risk and discretion and you should ensure that you are familiar with and approve of the terms on which tools are provided by the relevant third-party provider(s).\nWe may also, in the future, offer new services and/or features through the website (including, the release of new tools and resources). Such new features and/or services shall also be subject to these Terms of Service.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 8 - Third Party Links",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "Certain content, products and services available via our Service may include materials from third-parties.\nThird-party links on this site may direct you to third-party websites that are not affiliated with us. We are not responsible for examining or evaluating the content or accuracy and we do not warrant and will not have any liability or responsibility for any third-party materials or websites, or for any other materials, products, or services of third-parties.\nWe are not liable for any harm or damages related to the purchase or use of goods, services, resources, content, or any other transactions made in connection with any third-party websites. Please review carefully the third-party's policies and practices and make sure you understand them before you engage in any transaction. Complaints, claims, concerns, or questions regarding third-party products should be directed to the third-party.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 9 - User Comments, Feedback and Other Submissions",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "If, at our request, you send certain specific submissions (for example contest entries) or without a request from us you send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, by postal mail, or otherwise (collectively, 'comments'), you agree that we may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise use in any medium any comments that you forward to us. We are and shall be under no obligation (1) to maintain any comments in confidence; (2) to pay compensation for any comments; or (3) to respond to any comments.\nWe may, but have no obligation to, monitor, edit or remove content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or violates any party’s intellectual property or these Terms of Service.\nYou agree that your comments will not violate any right of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary right. You further agree that your comments will not contain libelous or otherwise unlawful, abusive or obscene material, or contain any computer virus or other malware that could in any way affect the operation of the Service or any related website. You may not use a false e-mail address, pretend to be someone other than yourself, or otherwise mislead us or third-parties as to the origin of any comments. You are solely responsible for any comments you make and their accuracy. We take no responsibility and assume no liability for any comments posted by you or any third-party.",
                  style: TextStyle(fontSize: 18),
                ).marginOnly(top: 12),
                Text(
                  "Section 10 - Personal Information",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: kRed),
                ).marginOnly(top: 12),
                Text(
                  "Your submission of personal information through the store is governed by our Privacy Policy.",
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


