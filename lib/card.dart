import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class carddd extends StatefulWidget {
  carddd(
      {super.key,
      required this.link,
      required this.message,
      required this.uid,
      required this.timestamp,
      required this.name,
      required this.photoURL});
  String link;
  String message;
  String uid;
  String timestamp;
  String photoURL;
  String name;
  @override
  State<carddd> createState() => _cardddState();
}

class _cardddState extends State<carddd> {
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    final String completeUrl = uri.scheme.isEmpty ? 'https://$url' : url;

    if (!await launchUrl(Uri.parse(completeUrl))) {
      throw Exception('Could not launch $completeUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 221, 235, 243),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.photoURL),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    widget.name,
                    style: GoogleFonts.firaCode(
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                maxLines: 30,
                widget.message,
                style: GoogleFonts.firaCode(
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                _launchURL(widget.link);
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 110,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 6, 52, 72),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.link_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "View",
                          style: GoogleFonts.firaCode(
                            textStyle: TextStyle(fontSize: 20),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
