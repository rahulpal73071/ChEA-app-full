import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:chea/utils/auth_service.dart';
import 'package:chea/utils/bottom_navbar.dart';
import 'package:chea/utils/cheagpt.dart';
import 'package:chea/utils/side_navbar.dart';
import 'package:chea/utils/home_service.dart';
import 'package:chea/models/home_model.dart';
import 'package:flutter_svg/flutter_svg.dart';


int defaultBackground = 0xff08050c;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(defaultBackground),
      floatingActionButton: ChEAGPT(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: 0,
        onItemTapped: (int index) {
          if (index == 1)
            Navigator.pushNamedAndRemoveUntil(context, '/blog', (route) => false);
          else if (index == 2)
            Navigator.pushNamedAndRemoveUntil(context, '/opportunities', (route) => false);
          else if (index == 3)
            Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
        },
      ),
      appBar: appbar(),
      body: ListView(
        children: [
          const OpportunitiesRow(),
          const RecentBlogsRow(),
        ],
      ),
      endDrawer: buildDrawer(width: MediaQuery.of(context).size.width),
    );
  }
}

class RecentBlogsRow extends StatelessWidget {
  const RecentBlogsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Blog>>(
      future: BlogService().fetchRecentBlogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          );
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'));
        final blogs = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text("Recent Blogs",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  final blog = blogs[index];
                  return Container(
                    width: 220,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xff201F1F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: Image.network(
                            blog.imageUrl,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person, color: Colors.white70, size: 16),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(blog.name,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                blog.blogType,
                                style: GoogleFonts.montserrat(
                                  color: Colors.purpleAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                blog.title,
                                style: GoogleFonts.montserrat(
                                  color: Colors.orange[300],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class OpportunitiesRow extends StatelessWidget {
  const OpportunitiesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Opportunity>>(
      future: OpportunityService().fetchRecentOpportunities(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          );
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'));
        final data = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text('Recent Opportunities',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  )),
            ),
            SizedBox(
              height: 185,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final opp = data[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 225,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xff201F1F),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(opp.title,
                                style: GoogleFonts.montserrat(
                                    color: Colors.orange[300],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(opp.role,
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 14)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.white, size: 16),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(opp.location,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white70, fontSize: 12)),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(Icons.calendar_month,
                                    size: 16, color: Colors.white),
                                const SizedBox(width: 5),
                                Text('Apply by: ${opp.lastDateOfApply}',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white60, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

AppBar appbar() {
  return AppBar(
    toolbarHeight: 100,
    backgroundColor: Color(defaultBackground),
    elevation: 0,
    centerTitle: false,
    automaticallyImplyLeading: false,
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
    title: Image.asset(
      'assets/icons/logo.png',
      height: 90,
      alignment: Alignment.centerLeft,
    ),
  );
}
