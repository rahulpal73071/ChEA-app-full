import 'package:chea/pages/event_pages/template.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TimeCapsule extends StatefulWidget {
  @override
  _TimeCapsuleState createState() => _TimeCapsuleState();
}

class _TimeCapsuleState extends State<TimeCapsule>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomTabView(
        // icon: 'assets/images/1.png',
        pageTitle: 'Time Capsule', tabs: [
        TabData(
          title: '2021 - 2022',
          content: Container(
            color: Color(defaultBackground),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: 'Zrc0L-1uPOQ',
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              // aspectRatio: 1920 / 1008,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
            ),
            )
          ),
        TabData(
          title: '2020 - 2021',
          content: Container(
            color: Color(defaultBackground),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: 'QpG4g8WW8C0',
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              // aspectRatio: 1920 / 1008,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
