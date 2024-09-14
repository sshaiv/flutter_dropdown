import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Examination/Examination.dart';

class PatientRegistrationPage extends StatefulWidget {
  @override
  _PatientRegistrationPageState createState() => _PatientRegistrationPageState();
}

class _PatientRegistrationPageState extends State<PatientRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  static const String baseUrl = 'https://4b2a-103-117-65-66.ngrok-free.app';

  DateTime? _dob;
  String? _selectedTitle;
  String? _selectedGender;
  String? _selectedAgeUnit = 'Years';
  bool _showMoreDetails = false;
  bool _isModification = false;

  @override
  void initState() {
    super.initState();
    _mobileController.addListener(_checkMobileNumber);
    _ageController.addListener(() {
      _calculateDobFromAge(_ageController.text, _selectedAgeUnit);
    });
  }

  @override
  void dispose() {
    _mobileController.removeListener(_checkMobileNumber);
    _mobileController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _aadharController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  final List<String> _titles = ['Mr', 'Mrs', 'Ms'];
  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _ageUnits = ['Years', 'Months', 'Days']; // Age units

  Future<void> _checkMobileNumber() async {
    final mobileNumber = _mobileController.text;
    if (mobileNumber.length != 10) {
      return;
    }

    if (mobileNumber.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('${baseUrl}/frmOPDDoctorExamination/patientregister?mobileno=$mobileNumber'),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        );

        if (response.statusCode != 200) {
          return;
        }
        final Map<String, dynamic> data = json.decode(response.body);
        _handleDataSet(data);
        setState(() {
          _isModification = true;
        });
      } catch (error) {
        print('Error fetching data: $error');
      }
    } else {
      setState(() {
        _firstNameController.clear();
        _lastNameController.clear();
        _selectedTitle = null;
        _ageController.clear();
        _dobController.clear();
        _selectedGender = null;
        _aadharController.clear();
        _addressController.clear();
        _cityController.clear();
        _stateController.clear();
        _countryController.clear();
        _dob = null;
        _isModification = false;
      });
    }
  }

  void _handleDataSet(Map<String, dynamic> data) {
    setState(() {
      _firstNameController.text = data['firstname'] ?? _firstNameController.text;
      _lastNameController.text = data['lastname'] ?? _lastNameController.text;
      _selectedTitle = data['initialid'] ?? _selectedTitle;
      _ageController.text = data['age'] ?? _ageController.text;
      _dobController.text = data['dob'] ?? _dobController.text;
      _selectedGender = data['genderid'] ?? _selectedGender;
      _aadharController.text = data['aadharno'] ?? _aadharController.text;
      _addressController.text = data['address'] ?? _addressController.text;
      _cityController.text = data['cityid'] ?? _cityController.text;
      _stateController.text = data['stateid'] ?? _stateController.text;
      _countryController.text = data['countryid'] ?? _countryController.text;
      _dob = DateTime.tryParse(data['dob'] ?? _dob?.toIso8601String() ?? '');
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final String? formattedDob = _dob != null
          ? "${_dob!.year}-${_dob!.month.toString().padLeft(2, '0')}-${_dob!.day.toString().padLeft(2, '0')}"
          : null;
      final Map<String, String> formData = {
        'mobileno': _mobileController.text,
        'alternateMobileNo': '',
        'initialid': _selectedTitle ?? '',
        'firstname': _firstNameController.text,
        'lastname': _lastNameController.text,
        'age': _ageController.text,
        'genderid': _selectedGender ?? '',
        'aadharno': _aadharController.text,
        'cityid': _cityController.text,
        'stateid': _stateController.text,
        'countryid': _countryController.text,
        'address': _addressController.text,
        'dob': formattedDob ?? '',
      };

      try {
        final Uri uri = Uri.parse('${baseUrl}/frmOPDDoctorExamination/patientregister');
        final response = _isModification
            ? await http.put(
          uri,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: formData,
        )
            : await http.post(
          uri,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: formData,
        );

        if (response.statusCode != 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred while ${_isModification ? 'updating' : 'registering'} the patient.')));
          return;
        }

        final result = response.body;
        if (result == 'patient already exists') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));

        print('Navigating to ExaminationPage with data: ${_firstNameController.text} ${_lastNameController.text}, ${_ageController.text}, ${_selectedGender}');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExaminationPage(
              name: '${_firstNameController.text} ${_lastNameController.text}',
              age: int.tryParse(_ageController.text) ?? 0,
              gender: _selectedGender ?? '',
            ),
          ),
        );

      } catch (error) {
        print('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred while ${_isModification ? 'updating' : 'registering'} the patient.')));
      }
    }
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dob = pickedDate;
        // Formatting date as day-month-year
        _dobController.text = "${_dob!.day.toString().padLeft(2, '0')}-${_dob!.month.toString().padLeft(2, '0')}-${_dob!.year}";

        // Optionally, update age if necessary
        _ageController.text = ((DateTime.now().difference(pickedDate).inDays) ~/ 365).toString();
      });
    }
  }


  void _calculateDobFromAge(String age, String? ageUnit) {
    if (age.isNotEmpty) {
      final int ageInt = int.tryParse(age) ?? 0;
      final now = DateTime.now();
      DateTime calculatedDob;

      switch (ageUnit) {
        case 'Months':
          calculatedDob = DateTime(now.year, now.month - ageInt, now.day);
          break;
        case 'Days':
          calculatedDob = now.subtract(Duration(days: ageInt));
          break;
        default:
          calculatedDob = DateTime(now.year - ageInt, now.month, now.day);
          break;
      }

      setState(() {
        _dob = calculatedDob;
        _dobController.text = "${_dob!.day.toString().padLeft(2, '0')}-${_dob!.month.toString().padLeft(2, '0')}-${_dob!.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.content_paste_search, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Patient Registration',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 2, 66, 130),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _mobileController,
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mobile Number is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedTitle,
                items: _titles.map((title) {
                  return DropdownMenuItem(
                    value: title,
                    child: Text(title),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTitle = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First Name is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last Name is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Age is required';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedAgeUnit,
                items: _ageUnits.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAgeUnit = value;
                    _calculateDobFromAge(_ageController.text, value);
                  });
                },
                decoration: InputDecoration(labelText: 'Age Unit'),
              ),
              GestureDetector(
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      labelText: 'DOB',
                      suffixIcon: Icon(Icons.calendar_today_rounded),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Date of Birth is required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: _genders.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a gender';
                  }
                  return null;
                },
              ),
              if (_showMoreDetails) ...[
                TextFormField(
                  controller: _aadharController,
                  decoration: InputDecoration(labelText: 'Aadhar No'),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'City'),
                ),
                TextFormField(
                  controller: _stateController,
                  decoration: InputDecoration(labelText: 'State'),
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                ),
              ],
              TextButton(
                onPressed: () {
                  setState(() {
                    _showMoreDetails = !_showMoreDetails;
                  });
                },
                child: Text(_showMoreDetails ? '- Remove Details' : '+ Add More Details'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: _submitForm,
                    child: Text(
                      _isModification ? 'Update' : 'Create',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),


                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExaminationPage(
                              name: '${_firstNameController.text} ${_lastNameController.text}',
                              age: int.tryParse(_ageController.text) ?? 0,
                              gender: _selectedGender ?? '',
                            ),
                          ),
                        );
                      },
                      child: const Text('Next'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


