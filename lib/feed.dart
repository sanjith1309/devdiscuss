import 'package:diss/auth_service.dart';
import 'package:diss/card.dart';
import 'package:diss/newpost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class feed extends StatefulWidget {
  const feed({super.key});

  @override
  State<feed> createState() => _feedState();
}

class _feedState extends State<feed> {
  final databaseReference = FirebaseDatabase.instance.reference().child('feed');
  final dateFormat = DateFormat('dd-MM-yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 52, 72),
        title: Text(
          "<DevDiscuss>",
          style: GoogleFonts.firaCode(
            textStyle: TextStyle(fontSize: 25),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back;",
                          style: GoogleFonts.firaCode(
                            textStyle: const TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          user?.displayName != null ? user!.displayName! : "",
                          style: GoogleFonts.firaCode(
                            textStyle: const TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 45.0),
                child: FirebaseAnimatedList(
                  query: databaseReference.orderByChild('timestamp'),
                  sort: (a, b) {
                    Map<dynamic, dynamic>? aValueMap =
                        a.value as Map<dynamic, dynamic>?;
                    Map<dynamic, dynamic>? bValueMap =
                        b.value as Map<dynamic, dynamic>?;
                    int? aValue =
                        aValueMap != null ? aValueMap['timestamp'] : null;
                    int? bValue =
                        bValueMap != null ? bValueMap['timestamp'] : null;
                    if (aValue != null && bValue != null) {
                      return bValue.compareTo(
                          aValue); // Sort in descending order of timestamp
                    } else {
                      return 0;
                    }
                  },
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map<dynamic, dynamic>? value =
                        snapshot.value as Map<dynamic, dynamic>?;
                    if (value != null) {
                      final message = value['message'] as String? ?? '';
                      final link = value['link'] as String? ?? '';
                      final timestamp = value['timestamp'] as int? ?? 0;
                      final userid = value['userid'] as String? ?? '';
                      final photourl = value['photoURL'] as String? ?? '';
                      final name = value['name'] as String;
                      return SizeTransition(
                        sizeFactor: animation,
                        child: carddd(
                          link: link,
                          message: message,
                          timestamp: timestamp.toString(),
                          uid: userid,
                          name: name,
                          photoURL: photourl,
                        ),
                      );
                    } else {
                      return const SizedBox(); // Return an empty SizedBox if data is null or marked as 'solved'
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => newpost(),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 6, 52, 72),
        icon: const Icon(Icons.add_circle_sharp,
            size: 30), // Adjust the size of the icon here
        label: const Text(
          "New Post",
          textAlign: TextAlign.center, // Center align the text
        ),
      ),
    );
  }
}

class Message {
  final String message;
  final String link;
  final int timestamp;
  final String userid;

  Message(
      {required this.message,
      required this.link,
      required this.timestamp,
      required this.userid});
}
