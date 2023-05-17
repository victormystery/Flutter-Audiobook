// ignore_for_file: non_constant_identifier_names

import 'package:audiobook/helper/services/database_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../audio_file.dart';

class BookScreen extends StatefulWidget {
  final booksData;
  final int index;
  const BookScreen({this.booksData, required this.index, super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late AudioPlayer advancedPlayer;
  Stream<QuerySnapshot>? _audio;
  final panelController = PanelController();
  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
    getAudio();
  }

  getAudio() {
    DatabaseService().getAudio().then((value) {
      setState(() {
        _audio = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final panelHeigth = MediaQuery.of(context).size.height * 0.1;
    return Material(
      color: Colors.grey.shade100,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, bottom: 20),
        child: Column(
          children: [
            Stack(children: [
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        advancedPlayer.stop();
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      "Now Playing",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xffff26b6c),
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
              BookWidget(advancedPlayer: advancedPlayer),
            ]),
          ],
        ),
      ),
    );
  }

  Widget BookWidget({required AudioPlayer advancedPlayer}) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              widget.booksData[widget.index]['imageUrl'],
              width: 190,
              height: 240,
            ),
            const SizedBox(height: 40),
            Text(widget.booksData[widget.index]['Book_Title']),
            const SizedBox(height: 10),
            Text(widget.booksData[widget.index]['Author']),
          ],
        ),
        AudioFile(
          advancedPlayer: advancedPlayer,
          audioPath: widget.booksData[widget.index]['audio'],
        ),
      ],
    );
  }
}
