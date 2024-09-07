import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

// Define the ChiefcomplaintModel class
class PastmedicalhistoryModel {
  final double itemid;
  final String itemname;

  PastmedicalhistoryModel({
    required this.itemid,
    required this.itemname,
  });

  factory PastmedicalhistoryModel.fromJson(Map<String, dynamic> json) => PastmedicalhistoryModel(
    itemid: json["itemid"].toDouble(),
    itemname: json["itemname"],
  );
}

class Pastmedicalhistory extends StatefulWidget {
  const Pastmedicalhistory({super.key});

  @override
  State<Pastmedicalhistory> createState() => _PastmedicalhistoryState();
}

class _PastmedicalhistoryState extends State<Pastmedicalhistory> {
  final TextEditingController textEditingController = TextEditingController();

  String? selectedValue;
  List<String> allItems = [];
  List<String> filteredItems = [];
  bool isLoading = false;
  bool hasMoreItems = true;
  int batchSize = 20; // Define your batch size here
  List<String> items = []; // Store filtered items

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
        final List<PastmedicalhistoryModel> medicines = data.map((item) => PastmedicalhistoryModel.fromJson(item)).toList();

        allItems = medicines.map((e) => e.itemname).toList();
        filterItems();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onSelect(String item) {
    setState(() {
      selectedValue = item;
    });
  }

  void loadMoreItems() {
    if (!hasMoreItems) return;

    final startIndex = filteredItems.length;
    final endIndex = (startIndex + batchSize).clamp(0, items.length);

    setState(() {
      filteredItems.addAll(items.sublist(startIndex, endIndex));
      hasMoreItems = endIndex < items.length;
    });
  }

  void filterItems() {
    final query = textEditingController.text.toLowerCase();
    setState(() {
      filteredItems = [];
      hasMoreItems = true;
      items = allItems.where((item) => item.toLowerCase().startsWith(query)).toList();
      loadMoreItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/past.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Pastmedicalhistory',
                  style: GoogleFonts.daysOne(fontSize: 15),
                ),
              ],
            ),
            PopupMenuButton<String>(
              onSelected: _onSelect,
              child: ListTile(
                title: Text(selectedValue ?? 'Select Pastmedicalhistory',style: TextStyle(fontSize: 10),),
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
                                            title: Text(item, style: TextStyle(color: Colors.black87)),
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
                                            },
                                          ),
                                        if (!isLoading && !hasMoreItems)
                                          Center(child: Text('No more options available', style: TextStyle(color: Colors.black87))),
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
          ],
        ),
      ),
    );
  }
}
