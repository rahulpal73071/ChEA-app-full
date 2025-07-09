import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/facad_model.dart';

class FacadCard extends StatelessWidget {
  final Facad facad;

  const FacadCard({super.key, required this.facad});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1e3c72), Color(0xFF2a5298)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.lightBlueAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlueAccent.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              facad.image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            facad.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            facad.position,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.lightBlueAccent,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            facad.department,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 6),
          _infoItem(Icons.email, facad.email),
          const SizedBox(height: 4),
          _infoItem(Icons.phone, facad.phone),
          
          const SizedBox(height: 4),
          _infoItem(Icons.confirmation_number_outlined, "Roll: ${facad.roll}"),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              onPressed: () => _launchURL(facad.url),
              icon: const Icon(Icons.open_in_new),
              label: const Text("Visit Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.lightBlueAccent, size: 18),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
