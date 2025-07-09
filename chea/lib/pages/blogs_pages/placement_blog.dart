import 'package:flutter/material.dart';
import 'package:chea/pages/blogs_pages/blogs/blog_model.dart';
import 'package:chea/pages/blogs_pages/blogs/blog_service.dart';
import 'package:chea/utils/bottom_navbar.dart';
import 'package:chea/utils/cheagpt.dart';
import 'package:chea/utils/side_navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'buildCard.dart';

class PlacementBlog extends StatefulWidget {
  @override
  _PlacementBlogState createState() => _PlacementBlogState();
}

class _PlacementBlogState extends State<PlacementBlog> with SingleTickerProviderStateMixin {
  List<Blog> blogs = [];
  bool isLoading = true;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    fetchBlogs();
    _tabController = TabController(length: 1, vsync: this);
  }

  Future<void> fetchBlogs() async {
    try {
      final blogService = BlogService();
      List<Blog> fetchedBlogs = await blogService.fetchBlogsByType('Placement');

      setState(() {
        blogs = fetchedBlogs;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching blogs: $e');
      setState(() => isLoading = false);
    }
  }

  List<Widget> buildBlogCards() {
    return blogs.map((blog) {
      return buildCard(
        imageUrl: blog.imageUrl ?? '',
        description: blog.thought ?? '',
        Title: blog.title ?? '',
        title: blog.name ?? '',
        date: blog.date ?? '',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff08050c),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ChEAGPT(context),
          ),
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {
                Navigator.pushNamed(context, '/postblog');
              },
              child: const Icon(Icons.add),
              tooltip: "Post Blog",
            ),
          ),
        ],
      ),

      bottomNavigationBar: MyNavigationBar(
        selectedIndex: 1,
        onItemTapped: (int index) {
          if (index == 0)
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          else if (index == 2)
            Navigator.pushNamedAndRemoveUntil(context, '/opportunities', (route) => false);
          else if (index == 3)
            Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
        },
      ),

      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xff08050c),
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 20),
            child: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/Hamburger_LG.svg',
                    height: 40,
                  ),
                );
              },
            ),
          ),
        ],
        title: Image.asset(
          'assets/icons/logo.png',
          height: 90,
          alignment: Alignment.centerLeft,
        ),
      ),
      endDrawer: buildDrawer(width: MediaQuery.of(context).size.width),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Placement Blogs",
              style: TextStyle(
                  color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            color: Colors.black,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.orange,
              tabs: const [
                Tab(child: Text('2025', style: TextStyle(color: Colors.white))),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : blogs.isEmpty
                    ? const Center(
                        child: Text(
                          "No blogs yet.",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      )
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                            child: Column(children: buildBlogCards()),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
