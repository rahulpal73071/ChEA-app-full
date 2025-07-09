// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class buildDrawer extends StatelessWidget {
  const buildDrawer({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: width * 0.75,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xff201f1f), Color(0xff000000), Color(0xff4c4949)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 40, bottom: 35),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/Hamburger_LG.svg',
                    height: 40,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  title: Text('Menu',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/calender.svg',
                    height: 24,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  title: Text('Events',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  onTap: () => Navigator.of(context).pushNamed('/events'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/Book.svg',
                    height: 24,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  title: Text('Publications',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  onTap: () => Navigator.of(context).pushNamed(
                    '/publication',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/Vector.svg',
                    height: 24,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  title: Text('Links',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  onTap: () => Navigator.of(context).pushNamed('/link'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/Users_Group.svg',
                    height: 24,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  title: Text('FacAds',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  onTap: () => Navigator.of(context).pushNamed('/facads'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/Phone.svg',
                    height: 24,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  title: Text('Contact Us',
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                  onTap: () => Navigator.of(context).pushNamed('/contactus'),
                ),
              ),
            ],
          ),
        ));
  }
}
