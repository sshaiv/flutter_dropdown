import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  DateTime? _dob;
  String? _selectedTitle;
  String? _selectedGender;
  bool _showMoreDetails = false;

  final List<String> _titles = ['Mr', 'Mrs', 'Ms'];
  final List<String> _genders = ['Male', 'Female', 'Other'];

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Format the date as dd-MM-yyyy
      final String? formattedDob = _dob != null
          ? "${_dob!.day.toString().padLeft(2, '0')}-${_dob!.month.toString().padLeft(2, '0')}-${_dob!.year}"
          : null;

      final Map<String, String> formData = {
        'mobileno': _mobileController.text,
        'firstname': _firstNameController.text,
        'lastname': _lastNameController.text,
        'initialid': _selectedTitle ?? '',
        'age': _ageController.text,
        'dob': formattedDob ?? '',
        'genderid': _selectedGender ?? '',
        'aadharno': _aadharController.text,
        'address': _addressController.text,
        'cityid': _cityController.text,
        'stateid': _stateController.text,
        'countryid': _countryController.text,
      };

      try {
        final response = await http.post(
          Uri.parse('https://f71e-103-117-65-66.ngrok-free.app/frmOPDDoctorExamination/patientregister'),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: formData,
        );

        final result = response.body;
        if (result == 'patient registered successfully') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
          _formKey.currentState?.reset();
          _mobileController.clear();
          _firstNameController.clear();
          _lastNameController.clear();
          _ageController.clear();
          _aadharController.clear();
          _addressController.clear();
          _cityController.clear();
          _stateController.clear();
          _countryController.clear();
          setState(() {
            _dob = null;
            _selectedTitle = null;
            _selectedGender = null;
            _showMoreDetails = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
        }
      } catch (error) {
        print('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred while registering the patient.')));
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Please Enter a Valid Contact Number',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile Number is required';
                  }
                  return null;
                },
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
                onChanged: (value) {
                  // Calculate DOB from age if needed
                },
              ),
              GestureDetector(
                onTap: _selectDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'DOB',
                      suffixIcon: Icon(Icons.calendar_today),
                      hintText: _dob == null ? 'Select Date' : _dob!.toLocal().toString().split(' ')[0],
                    ),
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
                    onPressed: _submitForm,
                    child: Text('Create'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle modify action
                    },
                    child: Text('Modify'),
                  ),
                ],
              ),
              // Table for displaying patient data can be implemented if needed
            ],
          ),
        ),
      ),
    );
  }
}
