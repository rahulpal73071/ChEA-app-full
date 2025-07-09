import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

FloatingActionButton ChEAGPT(BuildContext context) {
  return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, '/ai', (route) => false);
      },
      backgroundColor: const Color(0xffff7811),
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          0.5),
      child: Center(
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SvgPicture.asset(
              'assets/icons/ai.svg',
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ));
}
