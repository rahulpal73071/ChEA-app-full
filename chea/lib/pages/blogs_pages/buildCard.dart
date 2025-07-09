import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blogPage.dart';

class buildCard extends StatelessWidget {
  final String imageUrl;      // Should be a full network URL
  final String description;
  final bool isBookmarked = false;
  final String Title;
  final String title;
  final String date;

  const buildCard({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.Title,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogPage(
                imageUrl: imageUrl,
                description: description,
                isBookmarked: false,
                title: title,
                date: date,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xff201f1f),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: imageUrl.startsWith('http')
                    ? Image.network(
                        imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey,
                          child: const Icon(Icons.broken_image, color: Colors.white),
                        ),
                      )
                    : Image.asset(
                        imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Text(
                  Title,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
