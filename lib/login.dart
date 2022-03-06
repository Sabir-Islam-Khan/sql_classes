// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:animated_background/animated_background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sql_students/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  var colorizeColors = [
    Colors.black,
    Colors.white,
    Colors.blueAccent,
    Colors.purple,
  ];

  void loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      setState(() {
        user = userCredential.user;
      });

      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
      print(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isTrying = false;
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: AnimatedBackground(
        vsync: this,
        behaviour: RacingLinesBehaviour(),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables

          children: [
            SizedBox(
              height: totalHeight * 0.05,
            ),
            Center(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    'SQL Students Console',
                    textStyle: GoogleFonts.lobster(
                      fontSize: totalHeight * 0.065,
                    ),
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ),
            SizedBox(
              height: totalHeight * 0.2,
            ),
            Container(
              height: totalHeight * 0.07,
              width: totalWidth * 0.6,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: totalWidth * 0.02,
                    right: totalWidth * 0.02,
                    bottom: totalHeight * 0.01,
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter admin email address",
                      labelText: "Email",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    cursorColor: Colors.pink,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: totalHeight * 0.02,
            ),
            Container(
              height: totalHeight * 0.07,
              width: totalWidth * 0.6,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: totalWidth * 0.02,
                    right: totalWidth * 0.02,
                    bottom: totalHeight * 0.01,
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      labelText: "Password",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    cursorColor: Colors.pink,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: totalHeight * 0.06,
            ),
            isTrying == false
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isTrying = true;
                      });
                      loginUser(emailController.value.text,
                          passwordController.value.text);
                    },
                    child: Container(
                      height: totalHeight * 0.05,
                      width: totalWidth * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.purple[500],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.lobster(
                            fontSize: totalHeight * 0.025,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: totalHeight * 0.07,
                    width: totalWidth * 0.1,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
