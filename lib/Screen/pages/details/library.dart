import 'package:audiobook/helper/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widget/widget.dart';
import '../books.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    "Library",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xffff26b6c),
                        fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.more_vert),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Played",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "see all",
                      style: TextStyle(color: Color(0xffff26b6c)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 10,
                      bottom: 0,
                      child: SizedBox(
                        height: 160,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: DatabaseService().books,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var documents = snapshot.data!.docs;

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: documents.length == int
                                      ? 4
                                      : documents.length,
                                  // controller:
                                  //     PageController(viewportFraction: 0.2),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        nextScreen(
                                            context,
                                            BookScreen(
                                                booksData: documents,
                                                index: index));
                                      },
                                      child: SizedBox(
                                        height: 180,
                                        child: Container(
                                          width: 146,
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Image.network(
                                            documents[index]['imageUrl'],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const CircularProgressIndicator();
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Playlist",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("There is no saved playlist"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Bookmark",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text("see all"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 2))),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.play_circle_outline,
                            color: Color(0xffff26b6c),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Chapter -01"),
                              SizedBox(height: 5),
                              Text("2:02 8:30mins"),
                              SizedBox(height: 8),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 2))),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.play_circle_outline,
                            color: Color(0xffff26b6c),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Chapter -01"),
                              SizedBox(height: 5),
                              Text("2:02 8:30mins"),
                              SizedBox(height: 8),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 2))),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.play_circle_outline,
                            color: Color(0xffff26b6c),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Chapter -01"),
                              SizedBox(height: 5),
                              Text("2:02 8:30mins"),
                              SizedBox(height: 8),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
