// // ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class MyNavigationBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onItemTapped;

//   const MyNavigationBar({required this.selectedIndex, required this.onItemTapped});

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       color: const Color(0xff1a1818),
//       height: 67,
//       padding: const EdgeInsets.all(2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           IconButton(
//             icon: SvgPicture.asset(
//               'assets/icons/house.svg',
//               colorFilter: ColorFilter.mode(
//                 selectedIndex == 0 ? Colors.white : const Color(0xff666161),
//                 BlendMode.srcIn,
//               ),
//             ),
//             onPressed: () => onItemTapped(0),
//           ),
//           IconButton(
//             icon: SvgPicture.asset(
//               'assets/icons/document.svg',
//               colorFilter: ColorFilter.mode(
//                 selectedIndex == 1 ? Colors.white : const Color(0xff666161),
//                 BlendMode.srcIn,
//               ),
//             ),
//             onPressed: () => onItemTapped(1),
//           ),
//           const SizedBox(width: 10, height: 0),
//           IconButton(
//             icon: SvgPicture.asset(
//               'assets/icons/briefcase.svg',
//               colorFilter: ColorFilter.mode(
//                 selectedIndex == 2 ? Colors.white : const Color(0xff666161),
//                 BlendMode.srcIn,
//               ),
//               height: 30,
//             ),
//             onPressed: () => onItemTapped(2),
//           ),
//           IconButton(
//             icon: SvgPicture.asset(
//               'assets/icons/user.svg',
//               colorFilter: ColorFilter.mode(
//                 selectedIndex == 3 ? Colors.white : const Color(0xff666161),
//                 BlendMode.srcIn,
//               ),
//             ),
//             onPressed: () => onItemTapped(3),
//           ),
//         ],
//       ),
//     );
//   }
// }


// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MyNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const MyNavigationBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xff1a1818),
      height: 67,
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            icon: Icon(
              LucideIcons.home,
              color: selectedIndex == 0 ? Colors.white : const Color(0xff666161),
            ),
            onPressed: () => onItemTapped(0),
          ),
          IconButton(
            icon: Icon(
              LucideIcons.fileText,
              color: selectedIndex == 1 ? Colors.white : const Color(0xff666161),
            ),
            onPressed: () => onItemTapped(1),
          ),
          const SizedBox(width: 10, height: 0),
          IconButton(
            icon: Icon(
              LucideIcons.briefcase,
              size: 30,
              color: selectedIndex == 2 ? Colors.white : const Color(0xff666161),
            ),
            onPressed: () => onItemTapped(2),
          ),
          IconButton(
            icon: Icon(
              LucideIcons.user,
              color: selectedIndex == 3 ? Colors.white : const Color(0xff666161),
            ),
            onPressed: () => onItemTapped(3),
          ),
        ],
      ),
    );
  }
}
