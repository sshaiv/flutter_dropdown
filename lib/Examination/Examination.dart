import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_doc/Examination/ComponentPortion/Allergy.dart';
import 'package:medicine_doc/Examination/ComponentPortion/ChiefComplaint.dart';
import 'package:medicine_doc/Examination/ComponentPortion/ExaminationFindings.dart';
import 'package:medicine_doc/Examination/ComponentPortion/FamilyHistory.dart';
import 'package:medicine_doc/Examination/ComponentPortion/PastMedicalHistory.dart';
import 'package:medicine_doc/Examination/ComponentPortion/SurgicalHistory.dart';
import 'package:medicine_doc/Examination/ComponentPortion/diagnosis.dart';
import 'package:medicine_doc/Examination/Investigation.dart';
import 'package:medicine_doc/Examination/component_portion.dart';
import 'package:medicine_doc/Examination/medicine_dropdown.dart';
import 'package:medicine_doc/Examination/vital_data.dart';

class ExaminationPage extends StatefulWidget {
  final String name;
  final int age;
  final String gender;

  ExaminationPage({
    required this.name,
    required this.age,
    required this.gender,
  });

  @override
  _ExaminationPageState createState() => _ExaminationPageState();
}

class _ExaminationPageState extends State<ExaminationPage> {
  // Controller to manage the text input
  final TextEditingController _controller = TextEditingController();

  // Follow up
  DateTime? _selectedDate;
  final TextEditingController _remarkController = TextEditingController();

  bool _isFullView = false; // Lite view is default, so start with false

  @override
  void dispose() {
    _controller.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  // Function to open date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  // Save follow-up data
  void _saveData() {
    final String date = _selectedDate != null ? _selectedDate.toString() : 'No date selected';
    final String remark = _remarkController.text.isNotEmpty ? _remarkController.text : 'No remark entered';

    // Print data to console
    print('Date: $date');
    print('Remark: $remark');

    // Clear fields
    setState(() {
      _selectedDate = null;
      _remarkController.clear();
    });
  }

  // Define the _checkupData method
  void _checkupData() {
    final String checkupData = _controller.text.isNotEmpty ? _controller.text : 'No data entered';

    // Print the checkup data to the console
    print('Doctor Note: $checkupData');

    // Clear the input field after saving
    setState(() {
      _controller.clear();
    });
  }

  void _handleChiefComplaintsPressed() {
    print('Chief Complaints pressed');
  }

  void _toggleView() {
    setState(() {
      _isFullView = !_isFullView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Examination"),
      ),
      body: Stack(
        children: [
          // Background image with blur effect
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(
                'assets/images/examinationBG.png',
                color: Colors.white.withOpacity(0.1),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          // Content
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Patient Details
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/patientdetail.png',
                              width: 24,
                              height: 30,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Patients Details',
                              style: GoogleFonts.daysOne(
                                fontSize: 18,
                                color: const Color.fromARGB(255, 2, 66, 130),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Name : ${widget.name}',
                              style: GoogleFonts.josefinSans(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '(  ${widget.age}',
                              style: GoogleFonts.josefinSans(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              ' ,  ${widget.gender} ) ',
                              style: GoogleFonts.josefinSans(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Vital Data
                  VitalData(controllers: List.generate(10, (index) => TextEditingController())),
                  const SizedBox(height: 10),

                  // Add Check-Ups
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/doc_note.png',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                'Doctor Note ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Row containing TextField and Save button
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Start typing here....',
                                    labelStyle: TextStyle(fontSize: 10),
                                  ),
                                  minLines: 1,
                                  maxLines: null,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Save button
                              ElevatedButton(
                                onPressed: _checkupData,
                                child: const Text('Next'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ComponentPortion visibility based on _isFullView
                  if (_isFullView)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        // ComponentPortion(onChiefComplaintsPressed: _handleChiefComplaintsPressed),
                        // ComponentPortion(),
                        Chiefcomplaint(),
                        Allergy(),
                        Diagnosis(),
                        Examinationfindings(),
                        Familyhistory(),
                        Pastmedicalhistory(),
                        Surgicalhistory(),
                      ],
                    ),
                  SizedBox(height: 15,),

                  // Medicine Dropdown Section
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/medicine.png',
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Medicine',
                        style: GoogleFonts.daysOne(
                          fontSize: 18,
                          textStyle: TextStyle(color: Color.fromARGB(255, 154, 46, 38)),
                        ),
                      ),
                    ],
                  ),
                  const MedicineDropdown(),


                  // Investigation Dropdown
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/microscope.png',
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Investigations',
                        style: GoogleFonts.daysOne(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const InvestigationDropdown(),


                  // Follow-up
                  Container(
                    width: 325,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Follow up',
                            style: GoogleFonts.daysOne(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 2, 66, 130),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                ' Date : ',
                                style: GoogleFonts.dmSerifText(color: Colors.black, fontSize: 16),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                width: 215.0,
                                child: ElevatedButton(
                                  onPressed: () => _selectDate(context),
                                  child: Text(
                                    _selectedDate == null
                                        ? 'Select Date'
                                        : _selectedDate.toString().split(' ')[0],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              Text(
                                'Remark : ',
                                style: GoogleFonts.dmSerifText(color: Colors.black, fontSize: 16),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: TextField(
                                    controller: _remarkController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: _saveData,
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  // Toggle View Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: _toggleView,
                        child: Text(_isFullView ? 'Lite View' : 'Full View',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
