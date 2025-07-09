import 'package:flutter/material.dart';
import '../models/member_model.dart';

class MemberCard extends StatelessWidget {
  final Member member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420, // 👈 Increased height to avoid overflow
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.cyanAccent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.5),
            blurRadius: 10,
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
              color: Colors.white12,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              member.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            member.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            member.position,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.cyanAccent,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            member.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          _infoItem(Icons.phone, member.phone),
          const SizedBox(height: 6),
          _infoItem(Icons.email, member.email),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: member.social.entries.map((entry) {
              return IconButton(
                onPressed: () {},
                icon: Icon(
                  _getSocialIcon(entry.key),
                  color: Colors.cyanAccent,
                  size: 28,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyanAccent, size: 20),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  IconData _getSocialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return Icons.camera_alt_outlined;
      case 'linkedin':
        return Icons.business_center_outlined;
      case 'facebook':
        return Icons.facebook_outlined;
      case 'twitter':
        return Icons.alternate_email;
      default:
        return Icons.link_outlined;
    }
  }
}
