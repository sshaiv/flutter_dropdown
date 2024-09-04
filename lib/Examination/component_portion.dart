import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ComponentPortion extends StatelessWidget {
  final Function onChiefComplaintsPressed;

  ComponentPortion({required this.onChiefComplaintsPressed});

  final TextEditingController _ChiefController = TextEditingController();
  final TextEditingController _AllergyController = TextEditingController();
  final TextEditingController _DiagnosisController = TextEditingController();
  final TextEditingController _ExaminationController = TextEditingController();
  final TextEditingController _FamilyHistoryController = TextEditingController();
  final TextEditingController _PastController = TextEditingController();
  final TextEditingController _SurgicalController = TextEditingController();



  // Method to show the Chief Complaints popup
  void _showChiefPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter'),
          content: TextField(
            controller: _ChiefController,
            decoration: const InputDecoration(
              labelText: 'Enter here...',
              suffixIcon: Icon(Icons.check), // Icon for the click action
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the data to the console
                print('Chief save are: ${_ChiefController.text}');


                // Clear the text field
                _ChiefController.clear();

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

  //Allergy Popup
  void _showAllergyPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter'),
          content: TextField(
            controller: _AllergyController,
            decoration: const InputDecoration(
              labelText: 'Enter here...',
              suffixIcon: Icon(Icons.check), // Icon for the click action
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the data to the console
                print('Allergy save are: ${_AllergyController.text}');

                // Clear the text field
                _AllergyController.clear();

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

  //Diagnosis Popup
  void _showDiagnosisPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter'),
          content: TextField(
            controller: _DiagnosisController,
            decoration: const InputDecoration(
              labelText: 'Enter here...',
              suffixIcon: Icon(Icons.check), // Icon for the click action
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the data to the console
                print('Diagnosis save are: ${_DiagnosisController.text}');

                // Clear the text field
                _DiagnosisController.clear();

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

  //Show Examination Findings
  void _showExaminationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter'),
          content: TextField(
            controller: _ExaminationController,
            decoration: const InputDecoration(
              labelText: 'Enter here...',
              suffixIcon: Icon(Icons.check), // Icon for the click action
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the data to the console
                print('Examination save are: ${_ExaminationController.text}');

                // Clear the text field
                _ExaminationController.clear();

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

  //Family History
  void _showFamilyHistoryPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter'),
          content: TextField(
            controller: _FamilyHistoryController,
            decoration: const InputDecoration(
              labelText: 'Enter here...',
              suffixIcon: Icon(Icons.check), // Icon for the click action
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the data to the console
                print('Family History save are: ${_FamilyHistoryController.text}');

                // Clear the text field
                _FamilyHistoryController.clear();

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

  //Past
  void _showPastPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter'),
          content: TextField(
            controller: _PastController,
            decoration: const InputDecoration(
              labelText: 'Enter here...',
              suffixIcon: Icon(Icons.check), // Icon for the click action
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the data to the console
                print('Past save are: ${_PastController.text}');

                // Clear the text field
                _PastController.clear();

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


  //Surgical
  void _showSurgicalPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter'),
          content: TextField(
            controller: _SurgicalController,
            decoration: const InputDecoration(
              labelText: 'Enter here...',
              suffixIcon: Icon(Icons.check), // Icon for the click action
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save the data to the console
                print('Surgical save are: ${_SurgicalController.text}');

                // Clear the text field
                _SurgicalController.clear();

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
                  onTap: () => _showAllergyPopup(context), // Call the popup method
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
                  onTap: () => _showDiagnosisPopup(context), // Call the popup method
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
                  onTap: () => _showExaminationPopup(context), // Call the popup method
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
                  onTap: () => _showFamilyHistoryPopup(context), // Call the popup method
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
                  onTap: () => _showPastPopup(context), // Call the popup method
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
                  onTap: () => _showSurgicalPopup(context), // Call the popup method
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

              ]
            ),
          ]
        ),
      ),
    );
  }
}



