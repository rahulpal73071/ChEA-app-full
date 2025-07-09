// import 'package:chea/pages/event_pages/template.dart';
// import 'package:chea/utils/DisplayCard2.dart';
// import 'package:flutter/material.dart';

// class ContactUs extends StatefulWidget {
//   const ContactUs({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ContactUsState createState() => _ContactUsState();
// }

// class _ContactUsState extends State<ContactUs>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final List<Map<String, dynamic>> tabsInfo = [
//     {
//       "title": "2023 - 2024",
//       "items": [
//         {
//           "backgroundImage": "assets/images/GSec23.jpg",
//           "name": "Parth Manish Dani",
//           "position": "DGSec",
//           "email": "dgsec@che.iitb.ac.in",
//           "mobilenumber": "+91 9323294005"
//         },
//         {
//           "backgroundImage": "assets/images/JSecA23.jpg",
//           "name": "Amrit Raj",
//           "position": "JSec Academics Affairs",
//           "email": "210020016@iitb.ac.in",
//           "mobilenumber": "+91 7545855055",
//         },
//         {
//           "backgroundImage": "assets/images/JSecE23.jpg",
//           "name": "Tanay Mestry",
//           "position": "JSec Events",
//           "email": "tanaypm6129@gmail.com",
//           "mobilenumber": "+91 9004837295",
//         }
//       ]
//     },
//     {
//       "title": "2022 - 2023",
//       "items": [
//         {
//           "backgroundImage": "assets/images/GSec22.jpg",
//           "name": "Khyati Jain",
//           "position": "DGSec",
//           "email": "dgsec@che.iitb.ac.in",
//           "mobilenumber": "+91 9465500286"
//         },{
//           "backgroundImage": "assets/images/JSecA22.webp",
//           "name": "Parth Manish Dani",
//           "position": "JSec Academics Affairs",
//           "email": "200020090@iitb.ac.in",
//           "mobilenumber": "+91 9323294005",
//         },{
//           "backgroundImage": "assets/images/JSecE22.webp",
//           "name": "Vinit Nikam",
//           "position": "JSec Events",
//           "email": "vinitnikam10@gmail.com",
//           "mobilenumber": "+91 7744052977",
//         }
//       ]
//     },{
//       "title": "2021 - 2022",
//       "items": [
//         {
//           "backgroundImage": "assets/images/GSec21.webp",
//           "name": "Aryan Dangayach",
//           "position": "DGSec",
//           "email": "dgsec@iitb.ac.in",
//           "mobilenumber": "+91 9694126924"  
//         },{
//           "backgroundImage": "assets/images/JSecA21.webp",
//           "name": "Khyati Jain",
//           "position": "JSec Academics Affairs",
//           "email": "khyati.jain1105@gmail.com",
//           "mobilenumber": "+91 9465500286",
//         },{
//           "backgroundImage": "assets/images/JSecE21.webp",
//           "name": "Mitanshi Mehra",
//           "position": "JSec Events",
//           "email": "mehramitanshi26@gmail.com",
//           "mobilenumber": "+91 8824799892",
//         }
//       ]
//     },{
//       "title": "2020 - 2021",
//       "items": [
//         {
//           "backgroundImage": "assets/images/GSec20.webp",
//           "name": "Rishabh Agrawal",
//           "position": "DGSec",
//           "email": "dgsec@iitb.ac.in",
//           "mobilenumber": "+91 9983295518"},
//           {
//           "backgroundImage": "assets/images/JSecA20.webp",
//           "name": "Aryan Dangayach",
//           "position": "JSec Academics Affairs",
//           "email": "aryankhandelwal418@gmail.com",
//           "mobilenumber": "+91 9694126924",
//           },{
//           "backgroundImage": "assets/images/JSecE20.webp",
//           "name": "Sarthak Tripathi",
//           "position": "JSec Events",
//           "email": "sarthaktripathi5june@gmail.com",
//           "mobilenumber": "+91 8824799892",
//           }]
//     }
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: tabsInfo.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomTabView(
//           pageTitle: 'Contact Us',
//           tabs: tabsInfo
//               .map((tab) => TabData(
//                   title: tab['title'],
//                   content: Container(
//                     color: Color(defaultBackground),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           for (var item in tab['items'])
//                             Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 15, horizontal: 10),
//                                 child: SizedBox(
//                                   height: 500,
//                                   width: 400,
//                                   child: DisplayCard2(
//                                     backgroundImage: item['backgroundImage'],
//                                     position: item['position'],
//                                     name: item['name'],
//                                     email: item['email'],
//                                     mobilenumber: item['mobilenumber'],
//                                   ),
//                                 )),
//                           const SizedBox(height: 20)
//                         ],
//                       ),
//                     ),
//                   )))
//               .toList()),
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/member_model.dart';
import '../widgets/member_card.dart';
//import '../utils/DisplayCard2.dart'; // Still available if needed
import 'package:chea/pages/event_pages/template.dart'; // For CustomTabView

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> with TickerProviderStateMixin {
  Map<String, List<Member>> yearWiseMembers = {};
  List<String> years = [];

  @override
  void initState() {
    super.initState();
    loadMembers();
  }

  Future<void> loadMembers() async {
    final String response =
        await rootBundle.loadString('assets/data/members.json');
    final Map<String, dynamic> data = json.decode(response);

    final Map<String, List<Member>> loaded = {};
    data.forEach((year, membersJson) {
      loaded[year] = List<Member>.from(
          membersJson.map((json) => Member.fromJson(json)).toList());
    });

    setState(() {
      yearWiseMembers = loaded;
      years = loaded.keys.toList()..sort((a, b) => b.compareTo(a)); // Descending
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: yearWiseMembers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : CustomTabView(
              pageTitle: 'Contact Us',
              tabs: years.map((year) {
                return TabData(
                  title: year,
                  content: Container(
                    color: const Color(0xFF121212),
                    child: SingleChildScrollView(
                      child: Column(
                        children: yearWiseMembers[year]!
                            .map((member) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  child: SizedBox(
                                    height: 500,
                                    width: 400,
                                    child: MemberCard(member: member),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
