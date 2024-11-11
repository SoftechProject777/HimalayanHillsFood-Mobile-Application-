// import 'package:flutter/material.dart';

// class InfoScreen extends StatelessWidget {
//   const InfoScreen({super.key});

//   static const List<String> _kOptions = <String>[
//     'aardvark',
//     'bobcat',
//     'chameleon',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Autocomplete<String>(
//         optionsBuilder: (TextEditingValue textEditingValue) {
//           if (textEditingValue.text == '') {
//             return const Iterable<String>.empty();
//           }
//           return _kOptions.where((String option) {
//             return option.contains(textEditingValue.text.toLowerCase());
//           });
//         },
//         onSelected: (String selection) {
//           debugPrint('You just selected $selection');
//         },
//       ),
//     );
//   }
// }

import 'package:eccomerce/constant/color_constant.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor:ColorConstant.primaryColor ,
        title: const Text(
          "Privacy Policy",
          style: TextStyle( color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body:  SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.03,
              vertical: MediaQuery.sizeOf(context).width * 0.03),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Himalayan Hills Food built the Himalayan Hills Food app as a Free app. This service is provided by Himalayan Hills Food at no cost and is intended for use as is. This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information for anyone who decides to use our service."),
                  SizedBox(height: MediaQuery.sizeOf(context).height*0.02,),
                  const Text('If you choose to use our service, then you agree to the collection and use of information in relation to this policy. The personal information that we collect is used for providing and improving the service. We will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at the Himalayan Hills Food app unless otherwise defined in this Privacy Policy.'),
                   SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              const Text("Information Collection and Use", style: TextStyle(fontSize:16, fontWeight: FontWeight.bold ),),
               SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Text("For a better experience, while using our service, we may require you to provide us with certain personally identifiable information, including but not limited to your name, email address, phone number, and address. The information that we request will be retained by us and used as described in this privacy policy.\nThis app does not use third-party services that may collect information used to identify you."),
               SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              const Text(
                "Log Data",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Text(
                  "We want to inform you that whenever you use our service, in a case of an error in the app, we collect data and information on your phone called Log Data. This Log Data may include information such as your device's Internet Protocol (IP) address, device name, operating system version, the configuration of the app when utilizing our service, the time and date of your use of the service, and other statistics."),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              const Text(
                "Security",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Text(
                  "We value your trust in providing us your personal information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security."),
SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              const Text(
                "Links to Other Sites",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Text(
                  "This service may contain links to other sites. If you click on a third-party link, you will be redirected to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services."),
SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              const Text(
                "Changes to This Privacy Policy",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Text(
                  "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page."),
SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              const Text(
                "Contact Us",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
             
              const SizedBox(height: 10),
              const BulletList(
                items: [
                  'Phone Number: 01-5912704, 9768438717',
                  'Email: himalayanhillsfoods@gmail.com',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;

  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => _buildBulletItem(item)).toList(),
    );
  }

  Widget _buildBulletItem(String item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 20)),
        Expanded(
          child: Text(
            item,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
