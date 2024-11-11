import 'package:eccomerce/constant/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});


  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'himalayanhillsfoods@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Contact Us',
      }),
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: '9768438717',
    );
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      throw 'Could not launch $phoneLaunchUri';
    }
  }
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryColor,
        title: const Text(
          "Contact Us",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.03),child: const Text("To Contact Us you can either call us or send us an email!",style: TextStyle(fontSize: 16),textAlign: TextAlign.center,)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).height * 0.012,
            ),
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * 0.01),
            height: MediaQuery.sizeOf(context).height * 0.075,
            child: MaterialButton(
              // splashColor: ColorConstant.secondaryColor,
              elevation: 5,
              onPressed: _launchEmail,
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  // side: const BorderSide(color: Colors.black)
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.065,
                    child: const Icon(Icons.email, color: Colors.white,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.sizeOf(context).width * 0.04),
                    child: const Text(
                      "Send Us An Email",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
           Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).height * 0.012,
            ),
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * 0.01),
            height: MediaQuery.sizeOf(context).height * 0.075,
            child: MaterialButton(
              splashColor: ColorConstant.primaryColor,
              elevation: 5,
              onPressed: _launchPhone,
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                // side: const BorderSide(color: Colors.black)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.065,
                    child: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.sizeOf(context).width * 0.04),
                    child: const Text(
                      "Call Us",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.03,),
           const Text("Social", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          //  Row(
          //    children: [
          //      IconButton(onPressed: (){}, icon: const Icon(
          //           Icons.facebook,
          //           size: 70,
          //           color: Colors.blue,
          //         )),
          //         IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.facebook,
          //           size: 70,
          //           color: Colors.blue,
          //         )),
          //         IconButton(
          //         onPressed: () {},
          //         icon: const Icon(
          //           Icons.facebook,
          //           size: 70,
          //           color: Colors.blue,
          //         )),
          //    ],
          //  )
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon:
                     FaIcon(FontAwesomeIcons.facebook, color: Colors.blue,
                  size: MediaQuery.sizeOf(context).height*0.07,
                ),
                    
                onPressed: () => _launchURL(
                    "https://www.facebook.com/himalayanhillsfoods/?ref=embed_page"),
              ),
              IconButton(
                icon:  FaIcon(FontAwesomeIcons.instagram,
                size: MediaQuery.sizeOf(context).height*0.07,
                    color: Colors.pink),
                onPressed: () => _launchURL(
                    "https://www.instagram.com/your_instagram_profile"),
              ),
              IconButton(
                icon:  FaIcon(FontAwesomeIcons.xTwitter,
                size: MediaQuery.sizeOf(context).height*0.07,
                   ),
                onPressed: () =>
                    _launchURL("https://twitter.com/your_twitter_profile"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}