import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;
  int pageSize = 20;

  @override
  void initState() {
    super.initState();
    fetchData(page);

    textEditingController.addListener(() {
      filterItems();
    });
  }

  Future<void> fetchData(int page) async {
    if (!hasMore) return;

    final url = Uri.parse('https://doctorapi.medonext.com/api/PathAPI/GetMedicine?page=$page&pageSize=$pageSize');

    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Decode the response body as JSON
        final List<dynamic> data = json.decode(json.decode(response.body));

        print('Fetched data: $data');

        setState(() {
          final newItems = data.map((e) => MedicineModel.fromJson(e).itemname).toList();
          if (newItems.length < pageSize) {
            hasMore = false;
          }
          items.addAll(newItems);
          filteredItems = List.from(items);
          isLoading = false;
          page++;
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }



  void filterItems() {
    final query = textEditingController.text.toLowerCase();
    setState(() {
      filteredItems = items.where((item) => item.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void _onSelect(String? value) {
    setState(() {
      selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: _onSelect,
      child: ListTile(
        title: Text(selectedValue ?? 'Select Medicine'),
        trailing: Icon(Icons.arrow_drop_down),
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                hintText: 'Search for an item...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          ...filteredItems.map((item) {
            return PopupMenuItem<String>(
              value: item,
              child: ListTile(
                title: Text(item),
              ),
            );
          }).toList(),
          if (isLoading)
            PopupMenuItem(
              child: Center(child: CircularProgressIndicator()),
            ),
          if (!hasMore && !isLoading)
            PopupMenuItem(
              child: Center(child: Text('No more items')),
            ),
        ];
      },
      onCanceled: () {
        textEditingController.clear();
        filterItems(); // Reset filter when the menu closes
      },
    );
  }
}
