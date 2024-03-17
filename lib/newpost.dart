import 'package:diss/feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class newpost extends StatefulWidget {
  const newpost({super.key});
  @override
  State<newpost> createState() => _newpostState();
}

class _newpostState extends State<newpost> {
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController _message = TextEditingController();
  TextEditingController _link = TextEditingController();

  void _postDataToFirebase() {
    String message = _message.text;
    String link = _link.text;
    if (message.isNotEmpty) {
      DatabaseReference postRef =
          FirebaseDatabase.instance.reference().child('feed').push();
      postRef.set({
        'message': message,
        'link': link,
        'timestamp': ServerValue.timestamp,
        'userid': user?.uid,
        'photoURL': user?.photoURL,
        'name':user?.displayName,
      }).then((_) {
        _message.clear();
        _link.clear();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Posted!'),
          duration: Duration(seconds: 2),
        ));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add post : $error'),
          duration: Duration(seconds: 2),
        ));
        print(error);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => feed(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a message before posting!'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed
      _message.dispose();
      _link.dispose();
      super.dispose();
    }

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 52, 72),
        title: Text(
          "New post",
          style: GoogleFonts.firaCode(
            textStyle: TextStyle(fontSize: 25),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                maxLines: 5,
                controller: _message, // Assign the controller to the TextField
                decoration: const InputDecoration(
                  hintText: 'Enter the message',
                  labelText: 'Enter the message',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextField(
                controller: _link, // Assign the controller to the TextField
                decoration: const InputDecoration(
                  hintText: 'Paste a Valid link',
                  labelText: 'Add a reference link',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 6, 52, 72),
                      ),
                    ),
                    onPressed: _postDataToFirebase,
                    icon: Icon(Icons.send),
                    label: Text(" Post"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
