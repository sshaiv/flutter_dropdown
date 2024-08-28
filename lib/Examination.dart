import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExaminationPage extends StatefulWidget {
  final String name;
  final int age;
  final String gender;

  const ExaminationPage({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
  });

  @override
  _ExaminationPageState createState() => _ExaminationPageState();
}

class MedicineModel {
  final double itemid;
  final String itemname;

  MedicineModel({
    required this.itemid,
    required this.itemname,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) => MedicineModel(
    itemid: json["itemid"],
    itemname: json["itemname"],
  );
}

class _ExaminationPageState extends State<ExaminationPage> {
  // Controller to manage the text input
  final TextEditingController _controller = TextEditingController();

  //Component Popup
  final TextEditingController _textController = TextEditingController();

  //Follow up
  DateTime? _selectedDate;
  final TextEditingController _remarkController = TextEditingController();


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final TextEditingController textEditingController = TextEditingController();
  String? selectedValue = "1 2 3 100mg Tablet (4'S)";


  // Define a list of TextEditingControllers for each input field
  final List<TextEditingController> controllers =
  List.generate(10, (index) => TextEditingController());

  List<String> items = ["1 2 3 100mg Tablet (4'S)"];



  //medicine dropdown fetch data
  Future<void> fetchData() async {
    final url = Uri.parse('https://doctorapi.medonext.com/api/PathAPI/GetMedicine');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // print(response.body);

        final  List<dynamic> data = json.decode(json.decode(response.body));
        
        setState(() {
          items = data.map((e) => MedicineModel.fromJson(e).itemname).toList();

        });
        print('item data : $items');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    // Dispose all controllers when the widget is disposed
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();

    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    List<String> cardTexts = [
      'Height',
      'Weight',
      'BMI',
      'BP',
      'Temperature',
      'Pulse',
      'R.R',
      'Head Circumference',
      'Spo2',
      'Pain Score'
    ];



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

    // save follow up data
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
      print('Checkup Data: $checkupData');

      // Clear the input field after saving
      setState(() {
        _controller.clear();
      });
    }

    // Method to show the Chiefpopup
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
                  print('Chief Complaints : ${_textController.text}');

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


    return Scaffold(
      appBar: AppBar(
        title:Text("Examination"),

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
                            const SizedBox(
                              width: 10,
                            ),
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

                  // Vital Data Section
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/heart-rate.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Vital Data',
                        style: GoogleFonts.daysOne(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cardTexts.length,
                      itemBuilder: (context, index) {
                        return IntrinsicWidth(
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 25,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    cardTexts[index],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: controllers[index],
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  //Add Check-Ups
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row containing TextField and Save button
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Doctor Note',
                                ),
                                minLines: 1,
                                maxLines: null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Save button
                            ElevatedButton(
                              onPressed: _checkupData,
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Medicine Dropdown

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
                        ),
                      ),
                    ],
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select Medicine',
                        style: TextStyle(fontSize: 14),
                      ),

    items: items.map((item) {
    print('Item: $item');
    return DropdownMenuItem<String>(
    value: item,
    child: Text(
    item,
    style: const TextStyle(fontSize: 14),
    ),
    );
    }).toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 200,
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for an item...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return item.value.toString().contains(searchValue);
                        },
                      ),
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          textEditingController.clear();
                        }
                      },
                    ),
                  ),



                  const SizedBox(height: 20),


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

                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Text(
                          'Select Investigation',
                          style: TextStyle(fontSize: 14),
                        ),
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: textEditingController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: textEditingController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return item.value.toString().contains(searchValue);
                          },
                        ),
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //follow up
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
                              const Text(
                                ' Date : ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width:20),
                              SizedBox(
                                width: 200.0,  // Set the desired width
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
                              const Text(
                                'Remark ',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  height: 40,
                                  child: TextField(
                                    controller: _remarkController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter your remark',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: _saveData,
                              child: const Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  //Component portion
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[

                              GestureDetector(
                                onTap: () => _showChiefPopup(context), // Show popup on container click
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
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(
                                  width:
                                  10),

                              Container(
                                width: 100,
                                height: 75,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Image.asset(
                                      'assets/images/allergys.png',
                                      width: 25.0,
                                      height: 25.0,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(height: 8.0),
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
                              const SizedBox(
                                  width:
                                  10), // Horizontal spacing between containers
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
                                    SizedBox(height: 8.0),
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
                          const SizedBox(
                              height: 25), // Vertical spacing between rows
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
                              const SizedBox(
                                  width:
                                  10), // Horizontal spacing between containers
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
                                      'assets/images/symptoms.png',
                                      // 'assets/images/surgical.png',
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
                              const SizedBox(width: 10),
                              Container(
                                width: 200,
                                height: 75,
                                color: Colors.white,
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align children to the start (left) of the column
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Center the column content vertically
                                  children: [
                                    Text(
                                      'Follow up',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      ' : ',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      ' : ',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      ' ',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
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
            ),
          ),
        ],
      ),
    );
  }
}
