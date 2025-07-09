import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayCard extends StatefulWidget {
  final String backgroundImage;
  final String title;
  final Uri googleDriveLink;

  const DisplayCard({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.googleDriveLink,
  });

  @override
  _DisplayCardState createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  late Future<double> _aspectRatio;

  Future<double> _calculateAspectRatio() async {
    final ImageProvider imageProvider = AssetImage(widget.backgroundImage);
    final Completer<Size> completer = Completer<Size>();
    imageProvider.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo image, bool synchronousCall) {
        final Size imageSize = Size(
          image.image.width.toDouble(),
          image.image.height.toDouble(),
        );
        completer.complete(imageSize);
      }),
    );
    final Size imageSize = await completer.future;
    return imageSize.width / imageSize.height;
  }

  @override
  void initState() {
    super.initState();
    _aspectRatio = _calculateAspectRatio();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: _aspectRatio,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            onTap: () async {

                await launchUrl(widget.googleDriveLink);

            },
            child: AspectRatio(
              aspectRatio: snapshot.data!,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(widget.backgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                          Colors.black,
                        ],
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.nunitoSans(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
