// ignore_for_file: prefer_const_constructors

import 'package:animated_background/animated_background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nidController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> addUser(String name, String nid, String phone, String address) {
    // Call the user's CollectionReference to add a new user
    return students.add(
      {
        'full_name': name, // John Doe
        'nid_number': nid, // Stokes and Sons
        'phone': phone,
        'address': address, // 42
      },
    ).then((value) {
      setState(() {
        isWorking = false;
      });
    }).catchError((error) => print("Failed to add user: $error"));
  }

  bool isWorking = false;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: AnimatedBackground(
        vsync: this,
        behaviour: BubblesBehaviour(),
        child: Column(
          children: [
            SizedBox(
              height: totalHeight * 0.05,
            ),
            Center(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText('Students Archive',
                      textStyle: GoogleFonts.lobster(
                        fontSize: totalHeight * 0.065,
                        color: Colors.pink[300],
                      ),
                      speed: Duration(
                        milliseconds: 200,
                      ))
                ],
                isRepeatingAnimation: true,
              ),
            ),
            SizedBox(
              height: totalHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: totalHeight * 0.07,
                  width: totalWidth * 0.4,
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
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Enter Student Name",
                          labelText: "Name",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
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
                Container(
                  height: totalHeight * 0.07,
                  width: totalWidth * 0.4,
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
                        controller: nidController,
                        decoration: InputDecoration(
                          hintText: "Enter Student NID number",
                          labelText: "NID",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: totalHeight * 0.07,
                  width: totalWidth * 0.4,
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
                        controller: phoneController,
                        decoration: InputDecoration(
                          hintText: "Enter Student Phone Number",
                          labelText: "Phone",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
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
                Container(
                  height: totalHeight * 0.07,
                  width: totalWidth * 0.4,
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
                        controller: addressController,
                        decoration: InputDecoration(
                          hintText: "Enter Student address",
                          labelText: "Address",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
              ],
            ),
            SizedBox(
              height: totalHeight * 0.03,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(
                    () {
                      isWorking = true;
                    },
                  );
                  if (nameController.value.text == "" ||
                      nidController.value.text == "" ||
                      phoneController.value.text == "" ||
                      addressController.value.text == "") {
                    CoolAlert.show(
                      width: totalWidth * 0.5,
                      context: context,
                      type: CoolAlertType.error,
                      text: "Please Fill Every Field!",
                    );

                    setState(() {
                      isWorking = false;
                    });
                  } else {
                    addUser(
                      nameController.value.text,
                      nidController.value.text,
                      phoneController.value.text,
                      addressController.value.text,
                    );
                  }

                  nameController.clear();
                  nidController.clear();
                  phoneController.clear();
                  addressController.clear();
                },
                child: isWorking == true
                    ? CircularProgressIndicator()
                    : Container(
                        height: totalHeight * 0.05,
                        width: totalWidth * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.pink[300],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Center(
                          child: Text(
                            "Add Student",
                            style: GoogleFonts.lobster(
                              fontSize: totalHeight * 0.025,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: totalHeight * 0.01,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Container(
                  height: 200.0,
                  width: 100.0,
                  color: Colors.red,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
