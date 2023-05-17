import 'package:audiobook/helper/services/database_service.dart';
import 'package:audiobook/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:math' as math;

import '../books.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 70, right: 15, left: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.more_vert),
                  ),
                  const Text(
                    "Explore",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xffff26b6c),
                        fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.notifications_none),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "New Release Book",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Category",
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
              const SizedBox(height: 10),
              FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                      ),
                      child: Center(
                        child: Text(
                          "Thriller",
                          style: TextStyle(
                              color: Colors.red.shade600,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                      ),
                      child: Center(
                        child: Text(
                          "Suspense",
                          style: TextStyle(
                              color: Colors.yellow.shade600,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                      ),
                      child: Center(
                        child: Text(
                          "Humor",
                          style: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Featured Books",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "more",
                      style: TextStyle(color: Color(0xffff26b6c)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      left: 0,
                      right: 10,
                      bottom: 5,
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
              SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      left: 0,
                      right: 10,
                      bottom: 5,
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
                                        height: 160,
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
            ],
          ),
        ),
      ),
    );
  }
}
