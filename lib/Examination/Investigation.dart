import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class InvestigationModel {
  final double itemid;
  final String itemname;

  InvestigationModel({
    required this.itemid,
    required this.itemname,
  });

  factory InvestigationModel.fromJson(Map<String, dynamic> json) => InvestigationModel(
    itemid: json["itemid"].toDouble(),
    itemname: json["itemname"],
  );
}

class InvestigationDropdown extends StatefulWidget {
  const InvestigationDropdown({Key? key}) : super(key: key);

  @override
  _InvestigationDropdownState createState() => _InvestigationDropdownState();
}

class _InvestigationDropdownState extends State<InvestigationDropdown> {
  final TextEditingController textEditingController = TextEditingController();
  String? selectedValue;
  List<String> items = [];
  List<String> filteredItems = [];
  List<String> allItems = [];
  bool isLoading = false;
  bool hasMoreItems = true;
  int batchSize = 20;

  final TextEditingController unitController = TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController instructionController = TextEditingController();

  Map<String, String>? savedData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // final url = Uri.parse('https://doctorapi.medonext.com/api/PathAPI/GetMedicine');
    final url = Uri.parse('#');
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(json.decode(response.body));
        print(response.body);

        final List<InvestigationModel> investigations = data.map((item) => InvestigationModel.fromJson(item)).toList();
        print(investigations);

        allItems = investigations.map((e) => e.itemname).toList();
        filterItems();
        isLoading = false;
        print(allItems);
      } else {
        print('Error: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void loadMoreItems() {
    if (!hasMoreItems) return;

    final startIndex = filteredItems.length;
    final endIndex = (startIndex + batchSize).clamp(0, items.length);

    filteredItems.addAll(items.sublist(startIndex, endIndex));
    hasMoreItems = endIndex < items.length;
  }

  void filterItems() {
    final query = textEditingController.text.toLowerCase();
    filteredItems = [];
    hasMoreItems = true;
    items = allItems.where((item) => item.toLowerCase().startsWith(query)).toList();
    loadMoreItems();
    print(items);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    unitController.dispose();
    frequencyController.dispose();
    durationController.dispose();
    startDateController.dispose();
    instructionController.dispose();
    super.dispose();
  }

  void _onSelect(String? value) {
    setState(() {
      selectedValue = value;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        startDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _saveData() {
    setState(() {
      savedData = {
        'Investigation': selectedValue ?? '',
        'Unit': unitController.text,
        'Frequency': frequencyController.text,
        'Duration': durationController.text,
        'Start Date': startDateController.text,
        'Instruction': instructionController.text,
      };

      // Clear all fields after saving
      selectedValue = null;
      unitController.clear();
      frequencyController.clear();
      durationController.clear();
      startDateController.clear();
      instructionController.clear();
    });
  }

  void _editData() {
    if (savedData != null) {
      setState(() {
        selectedValue = savedData!['Investigation'];
        unitController.text = savedData!['Unit'] ?? '';
        frequencyController.text = savedData!['Frequency'] ?? '';
        durationController.text = savedData!['Duration'] ?? '';
        startDateController.text = savedData!['Start Date'] ?? '';
        instructionController.text = savedData!['Instruction'] ?? '';
      });
    }
  }

  void _deleteData() {
    setState(() {
      savedData = null;
      selectedValue = null;
      unitController.clear();
      frequencyController.clear();
      durationController.clear();
      startDateController.clear();
      instructionController.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupMenuButton<String>(
          onSelected: _onSelect,
          child: ListTile(
            title: Text(selectedValue ?? 'Select Investigation'),
            trailing: Icon(Icons.arrow_drop_down),
            
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                enabled: false,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              hintText: 'Search for an item...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (value) {
                              filterItems();
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 8),
                          Flexible(
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                                  loadMoreItems();
                                  setState(() {});
                                  return true;
                                }
                                return false;
                              },
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 200),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ...filteredItems.map((item) {
                                      return ListTile(
                                        title: Text(
                                          item,
                                          style: TextStyle(color: Colors.black87),
                                        ),
                                        onTap: () {
                                          _onSelect(item);
                                          Navigator.pop(context);
                                        },
                                      );
                                    }).toList(),
                                    if (isLoading)
                                      Center(child: CircularProgressIndicator())
                                    else if (hasMoreItems)
                                      ListTile(
                                        title: Text('Load more', style: TextStyle(color: Colors.black87)),
                                        onTap: () {
                                          loadMoreItems();
                                          setState(() {});
                                        },
                                      ),
                                    if (!isLoading && !hasMoreItems)
                                      Center(child: Text('No option available', style: TextStyle(color: Colors.black87))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ];
          },
          onCanceled: () {
            textEditingController.clear();
            filterItems();
            setState(() {});
          },
        ),
        if (selectedValue != null) ...[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveData,
          ),
        
        ],

        //display SavedData in a Card
        if (savedData != null) ...[
          Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Investigation: ${savedData!['Investigation']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 2, 66, 130),)),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: _editData,
                      ),
                      SizedBox(width: 30),
                      IconButton(
                        icon: Icon(Icons.delete_forever,color: Colors.red,),
                        onPressed: _deleteData,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}



