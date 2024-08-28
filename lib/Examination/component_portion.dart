import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComponentPortion extends StatelessWidget {
  final Function onChiefComplaintsPressed;

  ComponentPortion({required this.onChiefComplaintsPressed});

  final TextEditingController _textController = TextEditingController();

  // Method to show the Chief Complaints popup
  void _showChiefPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chief Complaints'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Enter your Complaints...',
              suffixIcon: Icon(Icons.check), // Icon for the click action
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the data to the console
                print('Chief Complaints: ${_textController.text}');

                // Clear the text field
                _textController.clear();

                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => _showChiefPopup(context), // Call the popup method
                  child: Container(
                    width: 100,
                    height: 75,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/symptoms.png',
                          width: 25.0,
                          height: 25.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Chief Complaints',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 75,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/allergys.png',
                        width: 25.0,
                        height: 25.0,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Allergy History',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 75,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/diagnosis.png',
                        width: 25.0,
                        height: 25.0,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Diagnosis',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 75,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/search.png',
                        width: 25.0,
                        height: 25.0,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Examination Findings',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 75,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/family.png',
                        width: 25.0,
                        height: 25.0,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Family History',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 75,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/past.png',
                        width: 25.0,
                        height: 25.0,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Past Medical History',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 75,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/symptoms.png',
                        width: 25.0,
                        height: 25.0,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Surgical History',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ]
        ),
      ),
    );
  }
}

               