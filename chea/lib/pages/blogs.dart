import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chea/pages/blogs_pages/blogs/blog_model.dart';
import 'package:chea/pages/blogs_pages/blogs/blog_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chea/utils/cheagpt.dart';
import 'package:chea/utils/bottom_navbar.dart';
import 'package:chea/utils/side_navbar.dart';

int defaultBackground = 0xff09050d;

class Blogs extends StatelessWidget {
  const Blogs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Text(
            'News',
            style: GoogleFonts.nunitoSans(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
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
        backgroundColor: Color(defaultBackground),
      ),
      body: const BlogPage(),
      bottomNavigationBar: MyNavigationBar(
          selectedIndex: 1,
          onItemTapped: (int index) {
            if (index == 0) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            } else if (index == 2)
              Navigator.pushNamedAndRemoveUntil(
                  context, '/opportunities', (route) => false);
            else if (index == 3)
              Navigator.pushNamedAndRemoveUntil(
                  context, '/profile', (route) => false);
          }),
      floatingActionButton: ChEAGPT(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      endDrawer: buildDrawer(width: MediaQuery.of(context).size.width),
    );
  }
}

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<Blog> recentBlogs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecentBlogs();
  }

  Future<void> fetchRecentBlogs() async {
    try {
      final blogService = BlogService();
      final allBlogs = await blogService.fetchAllBlogs();
      setState(() {
        recentBlogs = allBlogs.take(5).toList(); // get 5 most recent
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching blogs: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(defaultBackground),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
              child: SearchBar(
                hintText: 'Search...',
                padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 20)),
                leading: const Icon(Icons.search, color: Colors.white, size: 32),
                textStyle: WidgetStatePropertyAll(
                  GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                elevation: const WidgetStatePropertyAll(0),
                backgroundColor: const WidgetStatePropertyAll(Color(0xff3c3838)),
              ),
            ),

            // 📰 Recent Blogs (replaces Trad Day containers)
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recentBlogs.length,
                        itemBuilder: (context, index) {
                          final blog = recentBlogs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[850],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (blog.imageUrl != null)
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      child: Image.network(
                                        blog.imageUrl!,
                                        height: 140,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      blog.title ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Text(
                                      blog.name ?? '',
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // 📚 Grid of Blog Categories
            Padding(
              padding: EdgeInsets.all(8.0),
              child: EventGrid(),
            )
          ],
        ),
      ),
    );
  }
}

class BlogsCard {
  final Image icon;
  final String title;
  BlogsCard({required this.icon, required this.title});
}

class EventGrid extends StatelessWidget {
  final List<BlogsCard> Blogs = [
    BlogsCard(
        icon: Image.asset('assets/images/internblog.jpg'),
        title: 'Internship Blogs'),
    BlogsCard(
        icon: Image.asset('assets/images/placementblog.jpg'),
        title: 'Placement Blogs'),
    BlogsCard(
        icon: Image.asset('assets/images/internera.jpg'), title: 'Intern Era'),
    BlogsCard(
        icon: Image.asset('assets/images/appingguide.jpg'),
        title: 'Apping Guide'),
    BlogsCard(
        icon: Image.asset('assets/images/incaseyoudontknow.jpg'),
        title: 'In Case You Don\'t Know'),
    BlogsCard(
        icon: Image.asset('assets/images/thenvsnow.jpg'), title: 'Then vs Now'),
    BlogsCard(
        icon: Image.asset('assets/images/semex.jpg'),
        title: 'Semester Exchange'),
  ];

  @override
  Widget build(BuildContext context) {
    const double maxCrossAxisExtent = 250;
    const double crossAxisSpacing = 10;
    const double mainAxisSpacing = 10;
    const double childAspectRatio = 1;

    double screenWidth = MediaQuery.of(context).size.width;
    int columns = (screenWidth / (maxCrossAxisExtent + crossAxisSpacing)).ceil();
    int rows = (Blogs.length / columns).ceil();

    double itemHeight = maxCrossAxisExtent / childAspectRatio;
    double gridHeight = (itemHeight * rows) + (mainAxisSpacing * (rows - 1));

    return SizedBox(
      height: gridHeight - 200,
      child: GridView.builder(
        itemCount: Blogs.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 200,
            width: 200,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: const Color(0xffc25923), width: 2),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.pushNamed(context, '/internblog');
                            break;
                          case 1:
                            Navigator.pushNamed(context, '/placementblogs');
                            break;
                          case 2:
                            Navigator.pushNamed(context, '/internera');
                            break;
                          case 4:
                            Navigator.pushNamed(context, '/icydontknow');
                            break;
                          case 5:
                            Navigator.pushNamed(context, '/thenvsnow');
                            break;
                          case 6:
                            Navigator.pushNamed(context, '/semex');
                            break;
                          
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Blogs[index].icon,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      Blogs[index].title,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
