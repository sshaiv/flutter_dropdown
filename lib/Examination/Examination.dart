import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:medicine_doc/Examination/vital_data.dart';
import 'ComponentPortion/Allergy.dart';
import 'ComponentPortion/ChiefComplaint.dart';
import 'ComponentPortion/ExaminationFindings.dart';
import 'ComponentPortion/FamilyHistory.dart';
import 'ComponentPortion/PastMedicalHistory.dart';
import 'ComponentPortion/SurgicalHistory.dart';
import 'ComponentPortion/diagnosis.dart';
import 'Investigation.dart';
import 'medicine_dropdown.dart';

// Define the PatientDetails data model
class PatientDetails {
  final String name;
  final int age;
  final String gender;

  PatientDetails({
    required this.name,
    required this.age,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
    };
  }
}

// Examination Page Stateful Widget
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
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  DateTime? _selectedDate;
  bool _isFullView = false;

  @override
  void dispose() {
    _controller.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  // Method to open date picker
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

  // Method to save follow-up data
  void _saveData() {
    final String date = _selectedDate != null ? _selectedDate.toString() : 'No date selected';
    final String remark = _remarkController.text.isNotEmpty ? _remarkController.text : 'No remark entered';

    print('Date: $date');
    print('Remark: $remark');

    setState(() {
      _selectedDate = null;
      _remarkController.clear();
    });
  }

  // Method to save checkup data
  void _checkupData() {
    final String checkupData = _controller.text.isNotEmpty ? _controller.text : 'No data entered';

    print('Doctor Note: $checkupData');

    setState(() {
      _controller.clear();
    });
  }

  // Method to push patient details
  Future<void> _pushPatientDetails() async {
    final patientDetails = PatientDetails(
      name: widget.name,
      age: widget.age,
      gender: widget.gender,
    );

    try {
      final response = await http.post(
        Uri.parse('https://your-backend-url.com/patient-details'), // Replace with your backend URL
        headers: {'Content-Type': 'application/json'},
        body: json.encode(patientDetails.toJson()),
      );

      if (response.statusCode == 200) {
        print('Patient details saved successfully');
      } else {
        print('Failed to save patient details');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // Method to toggle between full view and lite view
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
                        const SizedBox(height: 10),

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
                        Chiefcomplaint(),
                        Allergy(),
                        Diagnosis(),
                        Examinationfindings(),
                        Familyhistory(),
                        Pastmedicalhistory(),
                        Surgicalhistory(),
                      ],
                    ),
                  SizedBox(height: 20,),

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

                  SizedBox(height:10 ,),

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

                  SizedBox(height:10 ,),

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
                        child: Text(
                          _isFullView ? 'Lite View' : 'Full View',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
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

