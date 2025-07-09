import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/auth_service.dart';
import '../utils/bottom_navbar.dart';
import '../utils/cheagpt.dart';

int defaultBackground = 0xff09050d;

class UserService {
  static const String url = 'http://172.28.102.117:8000/users/data/';
  static const String favUrl = 'http://172.28.102.117:8000/opportunities/get_favorite/';

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) return null;

    final response = await http.get(Uri.parse(url), headers: {'Authorization': 'Token $token'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error: ${response.statusCode} -> ${response.body}");
      return null;
    }
  }

  Future<List<dynamic>> getFavoriteOpportunities() async {
    final token = await AuthService().getToken();
    final response = await http.get(Uri.parse(favUrl), headers: {'Authorization': 'Token $token'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Failed to fetch favorites: ${response.body}");
      return [];
    }
  }

  Future<void> performLogout(BuildContext context) async {
    await AuthService().logout();
    Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (route) => false);
  }
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserService userService = UserService();
  Map<String, dynamic>? userData;
  List<dynamic> favoriteOpportunities = [];

  String name = '';
  String email = '';
  String rollNumber = '';
  bool isPage1ResumeUploaded = false;
  bool isPage2ResumeUploaded = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final data = await userService.getUserData();
    final favs = await userService.getFavoriteOpportunities();

    if (data != null) {
      setState(() {
        userData = data;
        name = data['name'] ?? '';
        email = data['email'] ?? '';
        rollNumber = data['roll_no'] ?? '';
        isPage1ResumeUploaded = data['resume1'] != null;
        isPage2ResumeUploaded = data['resume2'] != null;
        favoriteOpportunities = favs;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> _uploadFile(String resumeType, File file) async {
    final token = await AuthService().getToken();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://172.28.102.117:8000/users/update_$resumeType/'),
    );

    request.headers['Authorization'] = 'Token $token';
    request.files.add(await http.MultipartFile.fromPath(resumeType, file.path));
    final response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        if (resumeType == 'resume1') isPage1ResumeUploaded = true;
        if (resumeType == 'resume2') isPage2ResumeUploaded = true;
      });
    } else {
      print("Upload error: ${response.statusCode}");
    }
  }

  Future<void> _pickAndUploadResume(String resumeType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      File file = File(result.files.single.path!);
      await _uploadFile(resumeType, file);
    }
  }

  Widget buildResumeCard(String title, String subtitle, bool uploaded, String type) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xff3c3838), width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xff3c3838),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(Icons.file_copy_outlined, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: GoogleFonts.montserrat(
                      color: const Color(0xff666161),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    )),
              ],
            ),
          ),
          TextButton(
            onPressed: uploaded ? null : () => _pickAndUploadResume(type),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: uploaded ? const Color(0xff3c3838) : null,
                borderRadius: BorderRadius.circular(15),
                gradient: !uploaded
                    ? const LinearGradient(colors: [Color(0xffFF7A00), Color(0xffD45151)])
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  uploaded ? 'Uploaded' : 'Upload',
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFavoriteOpportunityCard(dynamic opportunity) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff3c3838)),
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff1a1a1a),
      ),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.redAccent, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(opportunity['title'] ?? '',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                Text("Stipend: ${opportunity['stipend'] ?? 'N/A'}",
                    style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white60)),
                Text("Domain: ${opportunity['domain'] ?? 'N/A'}",
                    style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white60)),
                Text("Last Date: ${opportunity['lastDateOfApply'] ?? 'N/A'}",
                    style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white60)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(defaultBackground),
      floatingActionButton: ChEAGPT(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyNavigationBar(
        selectedIndex: 3,
        onItemTapped: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              break;
            case 1:
              Navigator.pushNamedAndRemoveUntil(context, '/blog', (route) => false);
              break;
            case 2:
              Navigator.pushNamedAndRemoveUntil(context, '/opportunities', (route) => false);
              break;
          }
        },
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome, $name',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 36, color: Colors.white, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text(email,
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 18, color: Colors.white60, fontStyle: FontStyle.italic)),
                            const SizedBox(height: 30),
                            Text('Resumes',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
                            buildResumeCard(
                                '1 Page Resume', 'Upload your 1-page resume', isPage1ResumeUploaded, 'resume1'),
                            buildResumeCard(
                                '2 Page Resume', 'Upload your 2-page resume', isPage2ResumeUploaded, 'resume2'),
                            const SizedBox(height: 30),
                            Text('Favorite Opportunities',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
                            ...favoriteOpportunities.map(buildFavoriteOpportunityCard).toList(),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.white),
                      title: const Text('Log Out', style: TextStyle(color: Colors.white)),
                      onTap: () => userService.performLogout(context),
                      tileColor: const Color(0xff3c3838),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
