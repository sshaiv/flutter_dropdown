import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComponentPortion extends StatelessWidget {
  final Function onChiefComplaintsPressed;

  ComponentPortion({required this.onChiefComplaintsPressed});

  final TextEditingController _textController = TextEditingController();

  // Method to show the Chief Complaints popup
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Enter here...',
              suffixIcon: Icon(Icons.check), // Icon for the click action
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the data to the console
                print('save are: ${_textController.text}');

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
                  onTap: () => _showPopup(context), // Call the popup method
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
                         Text(
                          'Chief Complaints',
                            style:GoogleFonts.handjet(color:Colors.black,fontSize:12)
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                //allergys
                GestureDetector(
                  onTap: () => _showPopup(context), // Call the popup method
                  child: Container(
                    width: 100,
                    height: 75,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/allergys.png',
                          width: 25.0,
                          height: 25.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Allergy History',
                            style:GoogleFonts.handjet(color:Colors.black,fontSize:12)
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),


                GestureDetector(
                  onTap: () => _showPopup(context), // Call the popup method
                  child: Container(
                    width: 100,
                    height: 75,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/diagnosis.png',
                          width: 25.0,
                          height: 25.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8.0),
                         Text(
                          'Diagnosis',
                             style:GoogleFonts.handjet(color:Colors.black,fontSize:12)
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => _showPopup(context), // Call the popup method
                  child: Container(
                    width: 105,
                    height: 75,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/search.png',
                          width: 25.0,
                          height: 25.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8.0),
                         Text(
                          'Examination Findings',
                             style:GoogleFonts.handjet(color:Colors.black,fontSize:12)
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _showPopup(context), // Call the popup method
                  child: Container(
                    width: 100,
                    height: 75,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/family.png',
                          width: 25.0,
                          height: 25.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Family History',
                            style:GoogleFonts.handjet(color:Colors.black,fontSize:12)
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _showPopup(context), // Call the popup method
                  child: Container(
                    width: 100,
                    height: 75,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/past.png',
                          width: 25.0,
                          height: 25.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8.0),
                         Text(
                          'PastMedicalHistory',
                             style:GoogleFonts.handjet(color:Colors.black,fontSize:12)
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => _showPopup(context), // Call the popup method
                  child: Container(
                    width: 100,
                    height: 75,
                    color: Colors.white,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/surgical.png',
                          width: 25.0,
                          height: 25.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8.0),
                         Text(
                          'Surgical History',
                             style:GoogleFonts.handjet(color:Colors.black,fontSize:12)
                        ),
                      ],
                    ),
                  ),
                ),
SizedBox(width: 10,),
                GestureDetector(
                  onTap: () => _showPopup(context), // Call the popup method
                  child: Container(
                    width: 200,
                    height: 75,
                    // color: Colors.white,
            child: Row(
              children: [
                ElevatedButton(
                    // onPressed: _SavePage,
                    onPressed: () {
                      print('save btn pressed');
                    },
                    child: Text('Save'),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  // onPressed: _SavePage,
                  onPressed: () {
                    print('print btn pressed');
                  },
                  child: Text('Print'),
                ),
              ],
            ),
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

               