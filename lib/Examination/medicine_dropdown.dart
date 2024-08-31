import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MedicineModel {
  final double itemid;
  final String itemname;

  MedicineModel({
    required this.itemid,
    required this.itemname,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) => MedicineModel(
    itemid: json["itemid"].toDouble(),
    itemname: json["itemname"],
  );
}

class MedicineDropdown extends StatefulWidget {
  const MedicineDropdown({Key? key}) : super(key: key);

  @override
  _MedicineDropdownState createState() => _MedicineDropdownState();
}

class _MedicineDropdownState extends State<MedicineDropdown> {
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

  List<Map<String, String>> savedDataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://doctorapi.medonext.com/api/PathAPI/GetMedicine');

    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(json.decode(response.body));
        print(response.body);

        final List<MedicineModel> medicines = data.map((item) => MedicineModel.fromJson(item)).toList();
        print(medicines);

        allItems = medicines.map((e) => e.itemname).toList();
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
      final newEntry = {
        'Medicine': selectedValue ?? '',
        'Unit': unitController.text,
        'Frequency': frequencyController.text,
        'Duration': durationController.text,
        'Start Date': startDateController.text,
        'Instruction': instructionController.text,
      };

      savedDataList.add(newEntry);

      // Clear all fields after saving
      selectedValue = null;
      unitController.clear();
      frequencyController.clear();
      durationController.clear();
      startDateController.clear();
      instructionController.clear();
    });
  }

  void _editData(int index) {
    final selectedData = savedDataList[index];
    setState(() {
      selectedValue = selectedData['Medicine'];
      unitController.text = selectedData['Unit'] ?? '';
      frequencyController.text = selectedData['Frequency'] ?? '';
      durationController.text = selectedData['Duration'] ?? '';
      startDateController.text = selectedData['Start Date'] ?? '';
      instructionController.text = selectedData['Instruction'] ?? '';

      // Remove the old entry
      savedDataList.removeAt(index);
    });
  }

  void _deleteData(int index) {
    setState(() {
      savedDataList.removeAt(index);
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
            title: Text(selectedValue ?? 'Select Medicine'),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: unitController,
                    decoration: InputDecoration(
                      labelText: 'Unit',
                      hintText: 'Enter unit', // Placeholder text
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: frequencyController,
                    decoration: InputDecoration(
                      labelText: 'Frequency',
                      hintText: 'Enter frequency', // Placeholder text
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: durationController,
                    decoration: InputDecoration(
                      labelText: 'Duration',
                      hintText: 'Enter duration', // Placeholder text
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: startDateController,
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      hintText: 'Select start date', // Placeholder text
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                    onTap: () {
                      _selectDate(context);
                    },
                    readOnly: true,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: instructionController,
                    decoration: InputDecoration(
                      labelText: 'Instruction',
                      hintText: 'Enter instructions', // Placeholder text
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _saveData,
                ),
              ],
            ),
          ),
        ],
        // Display saved data in multiple cards
        Column(
          children: savedDataList.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;

            return Card(
              child: ListTile(
                title: Text(data['Medicine'] ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Unit: ${data['Unit'] ?? ''}'),
                    Text('Frequency: ${data['Frequency'] ?? ''}'),
                    Text('Duration: ${data['Duration'] ?? ''}'),
                    Text('Start Date: ${data['Start Date'] ?? ''}'),
                    Text('Instruction: ${data['Instruction'] ?? ''}'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editData(index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteData(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
