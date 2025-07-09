import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../models/event_model.dart';

class EventCardWidget extends StatelessWidget {
  final Event event;

  const EventCardWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final icon = _getLucideIcon(event.type);
    final color = _getColor(event.type);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xff1a1a2e), Color(0xff1f1b24)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(icon, size: 120, color: color),
          const SizedBox(height: 16),
          Text(
            event.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: color.withOpacity(0.8),
                  offset: const Offset(0, 0),
                )
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _showLinksDialog(context, event),
            icon: const Icon(Icons.visibility),
            label: const Text("View"),
            style: ElevatedButton.styleFrom(
              backgroundColor: color.withOpacity(0.9),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 12,
              shadowColor: color.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  void _showLinksDialog(BuildContext context, Event event) {
    final color = _getColor(event.type);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xff1a1a2e),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Links",
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: event.links.map((link) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _launchURL(link.url),
                  icon: Icon(_getIconForType(link.type), size: 20),
                  label: Text(link.type),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Close", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  IconData _getLucideIcon(String type) {
    switch (type.toLowerCase()) {
      case 'cultural':
        return LucideIcons.partyPopper;
      case 'farewell':
        return LucideIcons.userMinus;
      case 'sports':
        return LucideIcons.trophy;
      case 'academic':
        return LucideIcons.bookOpen;
      case 'orientation':
        return LucideIcons.compass;
      case 'trip':
        return LucideIcons.bus;
      case 'traditional':
        return LucideIcons.shirt;
      case 'panel':
        return LucideIcons.mic2;
      case 'valfi':
        return LucideIcons.award;
      default:
        return LucideIcons.calendarDays;
    }
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'photos':
        return Icons.photo_library;
      case 'video':
        return Icons.ondemand_video;
      case 'document':
        return Icons.insert_drive_file;
      default:
        return Icons.link;
    }
  }

  Color _getColor(String type) {
    switch (type.toLowerCase()) {
      case 'cultural':
        return Colors.orangeAccent;
      case 'farewell':
        return Colors.pinkAccent;
      case 'sports':
        return Colors.greenAccent;
      case 'academic':
        return Colors.lightBlueAccent;
      case 'orientation':
        return Colors.purpleAccent;
      case 'trip':
        return Colors.tealAccent;
      case 'traditional':
        return Colors.amberAccent;
      case 'panel':
        return Colors.redAccent;
      case 'valfi':
        return Colors.indigoAccent;
      default:
        return Colors.deepOrangeAccent;
    }
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
