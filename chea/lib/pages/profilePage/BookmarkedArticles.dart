import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/bottom_navbar.dart';
import '../../utils/cheagpt.dart';
import '../blogs_pages/buildCard.dart';

int defaultBackground = 0xff09050d;

class BookmarkedArticles extends StatelessWidget {
  const BookmarkedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(defaultBackground),
        floatingActionButton: ChEAGPT(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MyNavigationBar(
          selectedIndex: 3,
          onItemTapped: (int index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/blog');
            } else if (index == 0)
              Navigator.pushNamed(context, '/home');
            else if (index == 3) Navigator.pushNamed(context, '/profile');
            else if (index == 2) Navigator.pushNamed(context, '/opportunities');
          },
        ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xff09050d),
          child: Column(
            children:[
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xff201f1f),
                      ),

                      child: const Icon(Icons.bookmark_border, color: Colors.white,size:30),

                    ),
                    const SizedBox(width: 20),
                    Flexible(child: Text('Bookmarked Articles',
                        style: GoogleFonts.montserrat(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                        )),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SearchBar(
                    padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 20)),
                    hintText: 'Search...',
                    elevation: const WidgetStatePropertyAll(0),
                    hintStyle: WidgetStatePropertyAll(GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic)),
                    backgroundColor:
                    const WidgetStatePropertyAll(Color(0xff3c3838)),
                    leading: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildCard(imageUrl: 'assets/images/JSecA23.jpg', description:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.'
                  ,Title: "Long Title That Makes No Sense",
                  title: "Title",
                  date: "12/12/1200"),
            ]
          ),
        ),
      )
    );
  }
}
