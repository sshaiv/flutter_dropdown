import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'dart:ui'; // Import for ImageFilter
import 'AddPatient.dart'; // Import the new page

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
          // Background Image with Blur Effect
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background.png'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter:
              ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Light blur effect
              child: Container(
                color: Colors.black
                    .withOpacity(0.1), // Slight dark overlay for readability
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
                        0.15), // Very light transparency for the card
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
                        height: 150, // Adjust the height as needed
                      ),
                      const SizedBox(height: 16), // Add spacing here
                      Text(
                        'Welcome to MedoNext',
                        style: GoogleFonts.roboto(
                          fontSize: 24, // Adjusted font size
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
                            fontSize: 20, // Adjusted font size
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 2, 66, 130),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32), // Add spacing here

                      // Clickable image with very light blur background
                      GestureDetector(
                        onTap: () {
                          // Navigate to the Add Patient page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddPatientPage()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10), // Circular border
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // Match the shape to the container
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Very light blur background
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 3,
                                      sigmaY: 3), // Reduced blur intensity
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(
                                          0.2), // Very light red background
                                    ),
                                  ),
                                ),
                                // Image
                                Image.asset(
                                  'assets/images/addpatientbtn.png', // Replace with your icon image
                                  height: 100, // Adjust the size as needed
                                  width: 150,
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
