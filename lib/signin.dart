import 'package:diss/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              SvgPicture.asset(
                'assets/start.svg',
                height: 300,
                width: 300,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left:30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hey there!",
                    style: GoogleFonts.firaCode(
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome back to;",
                    style: GoogleFonts.firaCode(
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.only(left: 30) ,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "<DevDiscuss>",
                    style: GoogleFonts.firaCode(
                      textStyle:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 9, 32, 53)),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
                icon: const Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: FaIcon(FontAwesomeIcons.google),
                ),
                label: Padding(
                  padding: const EdgeInsets.only(top:20,bottom: 20,left: 20),
                  child: Text(
                    "Sign in With Google >",
                    style: GoogleFonts.firaCode(
                      textStyle: TextStyle(fontSize: 19),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
