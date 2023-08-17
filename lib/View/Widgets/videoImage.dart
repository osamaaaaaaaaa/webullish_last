// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webullish/utils/AppColors.dart';

/// Stateful widget to fetch and then display video content.
class videoimageviw extends StatefulWidget {
  late String link;
  videoimageviw({required this.link});
  @override
  _VideoAppState createState() => _VideoAppState(link: link);
}

class _VideoAppState extends State<videoimageviw> {
  late String link;
  _VideoAppState({required this.link});
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(link)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? Container(
              width: 300,
              height: 200,
              child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: VideoPlayer(_controller)),
            )
          : Container(
              child: CircularProgressIndicator(
                color: AppColors.gold,
              ),
            ),
    );
    // floatingActionButton:
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
