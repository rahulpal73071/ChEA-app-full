import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/publication.dart';

class PublicationCard extends StatelessWidget {
  final Publication publication;

  const PublicationCard({super.key, required this.publication});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0f0c29), Color(0xFF302b63), Color(0xFF24243e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyanAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              publication.image,
              height: 460,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            publication.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
              shadows: [
                Shadow(blurRadius: 4, color: Colors.cyan, offset: Offset(0, 2))
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            publication.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.cyanAccent, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    publication.publishDate,
                    style: const TextStyle(color: Colors.white60),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.menu_book_outlined, color: Colors.cyanAccent, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    '${publication.pages} pages',
                    style: const TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              onPressed: () => _launchURL(publication.url),
              icon: const Icon(Icons.open_in_new),
              label: const Text("Read Document"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
