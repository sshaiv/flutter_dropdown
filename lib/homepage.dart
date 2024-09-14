import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'AddPatient.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
                   Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter:
              ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black
                    .withOpacity(0.1),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                        0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/medonextlogo.png',
                        height: 150,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome to MedoNext',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Next Generation Health Care Solutions.....Patient Care with Embedded Solution',
                          style: GoogleFonts.barlowCondensed(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 2, 66, 130),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  PatientRegistrationPage()),
                                // builder: (context) =>  AddPatientPage()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10), // Circular border
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [

                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 3,
                                      sigmaY: 3),
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color:Colors.white.withOpacity(0.2),
                                      // color: Colors.red.withOpacity(
                                      //     0.2), // Very light red background
                                    ),
                                  ),
                                ),
                                // Image
                                Image.asset(
                                  'assets/images/addpatientbtn.png',
                                  height: 50,
                                  width: 75,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

