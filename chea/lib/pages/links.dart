// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:chea/utils/cheagpt.dart';
import 'package:chea/utils/DisplayCard.dart';
import 'package:chea/utils/bottom_navbar.dart';
import 'package:chea/utils/side_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

int defaultBackground = 0xff09050d;

class Link extends StatefulWidget {
  const Link({super.key});

  @override
  State<Link> createState() => _LinkState();
}

class _LinkState extends State<Link> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Image.asset(widget.icon),
          automaticallyImplyLeading: false,
          backgroundColor: Color(defaultBackground),
          toolbarHeight: 80,
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              'Links',
              style: GoogleFonts.nunitoSans(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w700),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 20),
              child: Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/Hamburger_LG.svg',
                      height: 40,
                    ));
              }),
            ),
          ],
        ),
        bottomNavigationBar: MyNavigationBar(
            selectedIndex: -1,
            onItemTapped: (int index) {
              if (index == 0) {
                Navigator.pushNamed(context, '/home');
              } else if (index == 1)
                Navigator.pushNamed(context, '/blog');
              else if (index == 3)
                Navigator.pushNamed(context, '/opportunities');
              else if (index == 4) Navigator.pushNamed(context, '/profile');
            }),
        floatingActionButton: ChEAGPT(context),
        endDrawer: buildDrawer(
          width: MediaQuery.of(context).size.width,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          color: Color(defaultBackground),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: DisplayCard(
                        backgroundImage: 'assets/images/ChE.jpg',
                        title: 'ChE Official Website',
                        googleDriveLink:
                            Uri.parse('https://www.che.iitb.ac.in/')),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: DisplayCard(
                        backgroundImage: 'assets/images/intenr25-resume.jpg',
                        title: 'Internship Resume Repository-2k25',
                        googleDriveLink: Uri.parse(
                            'https://drive.google.com/drive/u/0/folders/1eyM1gio4GCNLVimxFt1q1FXRHysx7EJk?pli=1')),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: DisplayCard(
                        backgroundImage: 'assets/images/placement25-resume.jpg',
                        title: 'Placement Resume Repository-2k25',
                        googleDriveLink: Uri.parse(
                            'https://drive.google.com/drive/folders/1mtc1B8dBsqnJssOOjyhVVovmOyLF0Wk2')),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: DisplayCard(
                        backgroundImage: 'assets/images/PlacementRepo.jpg',
                        title: 'Placement Resume Repository-2k24',
                        googleDriveLink: Uri.parse(
                            'https://drive.google.com/drive/folders/1zPQxnLF6u2ydDIqGXfYe3fE3Rf59k6TT')),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: DisplayCard(
                        backgroundImage: 'assets/images/InternRepo.jpg',
                        title: 'Internship Resume Repository-2k24',
                        googleDriveLink: Uri.parse(
                            'https://drive.google.com/drive/u/4/folders/1-NQweMAHZlf_-cCWbZxytJFeoZ1cjA6K')),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 400,
                    child: DisplayCard(
                        backgroundImage: 'assets/images/SMP.jpg',
                        title: 'Damp Chemical',
                        googleDriveLink:
                            Uri.parse('https://dampiitbche.wordpress.com/')),
                  ),
                ),
                const SizedBox(height: 20),
                
                
              ],
            ),
          ),
        ));
  }
}
