import 'package:audioplayers/audioplayers.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  const AudioFile(
      {required this.advancedPlayer, required this.audioPath, super.key});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  // final String path =
  //     "https://etc.usf.edu/lit2go/audio/mp3/the-adventures-of-huckleberry-finn-002-chapter-1.99.mp3";

  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  bool isBook = false;
  Color color = Colors.black;
  Icon icon = const Icon(
    Icons.bookmark_border,
  );

  final List<IconData> _icons = [
    Icons.play_circle_fill_outlined,
    Icons.pause_circle_filled
  ];

  int index = 0;
  @override
  void initState() {
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.advancedPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });
    widget.advancedPlayer.setSourceUrl(widget.audioPath);

    widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = Duration.zero;
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget btnStart() {
    return GestureDetector(
      onTap: () {
        if (isPlaying == false) {
          widget.advancedPlayer.play(UrlSource(widget.audioPath));
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
      child: isPlaying == false
          ? Icon(
              _icons[0],
              size: 50,
            )
          : Icon(
              _icons[1],
              size: 50,
            ),
    );
  }

  Widget btnFast() {
    return GestureDetector(
      onTap: () {
        widget.advancedPlayer.seek(Duration(seconds: _position.inSeconds + 10));
      },
      child: const Icon(
        Icons.fast_forward,
        color: Colors.amber,
      ),
    );
  }

  Widget btnSlow() {
    return GestureDetector(
      onTap: () {
        widget.advancedPlayer.seek(Duration(seconds: _position.inSeconds - 10));
      },
      child: const Icon(
        CommunityMaterialIcons.rewind,
        color: Colors.amber,
      ),
    );
  }

  Widget btnPrev() {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.advancedPlayer.setSource(UrlSource(widget.audioPath));
        });
      },
      child: const Icon(
        CommunityMaterialIcons.skip_previous,
        color: Colors.amber,
      ),
    );
  }

  Widget btnNext() {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.advancedPlayer.setSource(UrlSource(widget.audioPath));
        });
      },
      child: const Icon(
        CommunityMaterialIcons.skip_next,
        color: Colors.amber,
      ),
    );
  }

  Widget btnRepeat() {
    return GestureDetector(
      onTap: () {
        if (isRepeat == false) {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat = true;
            color = Colors.red;
          });
        } else if (isRepeat == true) {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
          setState(() {
            isRepeat = false;
            color = Colors.black;
          });
        }
      },
      child: Icon(
        Icons.repeat,
        color: color,
      ),
    );
  }

  Widget btnBookmark() {
    return GestureDetector(
      onTap: () {
        if (isBook == false) {
          setState(() {
            isBook = true;
            icon = const Icon(
              Icons.bookmark,
            );
          });
        } else if (isBook == true) {
          setState(() {
            isBook = false;
            icon = const Icon(
              Icons.bookmark_border,
            );
          });
        }
      },
      child: icon,
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          btnPrev(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnNext(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.indigo,
        inactiveColor: Colors.blueGrey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _position.toString().split('.')[0],
                    style: const TextStyle(fontSize: 16),
                  ),
                  slider(),
                  Text(
                    _duration.toString().split('.')[0],
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          loadAsset(),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              btnRepeat(),
              btnBookmark(),
            ],
          ),
        ],
      ),
    );
  }
}
