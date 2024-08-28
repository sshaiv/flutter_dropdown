import 'package:flutter/material.dart';
import 'Examination.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final List<String> titles = ['Ms.', 'Mrs.', 'Mr.'];
  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];
  final List<String> countries = [
    'India',
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'China',
    'Brazil'
  ];

  final _formKey = GlobalKey<FormState>();

  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController alternateMobileNoController =
  TextEditingController(); // New field
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  String selectedTitle = 'Ms.';
  String selectedGender = 'Male';
  String selectedState = 'Andhra Pradesh';
  String selectedCountry = 'India';

  DateTime? selectedDOB;
  int? age;

  @override
  void initState() {
    super.initState();
    if (selectedDOB != null) {
      age = DateTime.now().year - selectedDOB!.year;
    }
  }

  void calculateAge(DateTime dob) {
    setState(() {
      selectedDOB = dob;
      age = DateTime.now().year - dob.year;
    });
  }

  void handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      // Print data to the console
      print('Mobile No.: ${mobileNoController.text}');
      print('Alternate Mobile No.: ${alternateMobileNoController.text}');
      print('Title: $selectedTitle');
      print('First Name: ${firstNameController.text}');
      print('Last Name: ${lastNameController.text}');
      print('DOB: $selectedDOB');
      print('Age: $age');
      print('Gender: $selectedGender');
      print('Aadhar: ${aadharController.text}');
      print('City: ${cityController.text}');
      print('State: $selectedState');
      print('Country: $selectedCountry');

      // Navigate to the ExaminationPage with data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExaminationPage(
            name: '${firstNameController.text} ${lastNameController.text}',
            age: age ?? 0,
            gender: selectedGender,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.white
        ),
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.content_paste_search, color: Colors.white), // White icon
            SizedBox(width: 8),
            Text(
              'Patient Registration',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // White text
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 2, 66, 130),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background image with blur effect
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(
                'assets/images/background.png', // Replace with your image asset
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          // Content with blur effect
          Positioned.fill(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color:
                  Colors.white.withOpacity(0.5), // Adjust opacity as needed
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
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
                                    child: TextField(
                                      controller: mobileNoController,
                                      decoration: const InputDecoration(
                                        hintText: 'Mobile No.',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownButtonFormField<String>(
                                  value: selectedTitle,
                                  items: titles.map((title) {
                                    return DropdownMenuItem(
                                      value: title,
                                      child: Text(title),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTitle = value!;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Title',
                                    labelStyle: TextStyle(
                                      fontSize:
                                      18, // Adjust label text size here
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: firstNameController,
                                  decoration: const InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(
                                      fontSize:
                                      18, // Adjust label text size here
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'First Name is required';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: lastNameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(
                                      fontSize:
                                      18, // Adjust label text size here
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Last Name is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          labelText: 'Age',
                                          hintText: age != null ? '$age' : '',
                                          labelStyle: const TextStyle(
                                            fontSize:
                                            18, // Adjust label text size here
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: () async {
                                        DateTime? pickedDate =
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null) {
                                          calculateAge(pickedDate);
                                        }
                                      },
                                      child: const Text(
                                        'Select DOB',
                                        style: TextStyle(
                                          color: Colors
                                              .red, // Change text color to red
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: selectedGender,
                                  items: genders.map((gender) {
                                    return DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value!;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Gender',
                                    labelStyle: TextStyle(
                                      fontSize:
                                      18, // Adjust label text size here
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: alternateMobileNoController,
                                  decoration: const InputDecoration(
                                    labelText: 'Mobile No.',
                                    labelStyle: TextStyle(
                                      fontSize:
                                      18, // Adjust label text size here
                                    ),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Alternate Mobile No. is required';
                                    } else if (value.length != 10) {
                                      return 'Mobile No. must be 10 digits';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: aadharController,
                                  decoration: const InputDecoration(
                                    labelText: 'Aadhar',
                                    labelStyle: TextStyle(
                                      fontSize:
                                      18, // Adjust label text size here
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Aadhar is required';
                                    } else if (value.length != 12) {
                                      return 'Aadhar must be 12 digits';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: cityController,
                                  decoration: const InputDecoration(
                                    labelText: 'City',
                                    labelStyle: TextStyle(
                                      fontSize:
                                      18, // Adjust label text size here
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'City is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: selectedState,
                                  items: states.map((state) {
                                    return DropdownMenuItem(
                                      value: state,
                                      child: Text(state),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedState = value!;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'State',
                                    labelStyle: TextStyle(
                                      fontSize:
                                      18, // Adjust label text size here
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String>(
                                  value: selectedCountry,
                                  items: countries.map((country) {
                                    return DropdownMenuItem(
                                      value: country,
                                      child: Text(country),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCountry = value!;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Country',
                                    labelStyle: TextStyle(
                                      fontSize:
                                      18, // Adjust label text size here
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: handleSave,
                              icon: const Icon(Icons.save),
                              label: const Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors
                                    .red, // Change the button color to red
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ExaminationPage(
                                      name: 'shraddha',
                                      age: 23,
                                      gender: 'F',
                                    ), // Replace with the actual page widget
                                  ),
                                );
                              },
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.red, // Customize the text color
                                  fontSize: 10, // Customize the text size
                                ),
                              ),
                            )
                          ],
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
