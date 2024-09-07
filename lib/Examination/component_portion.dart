// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
//
// class ComponentPortion extends StatelessWidget {
//   final Function onChiefComplaintsPressed;
//
//   ComponentPortion({required this.onChiefComplaintsPressed});
//
//   // Placeholder methods for API calls
//   Future<List<String>> fetchDataForDropdown(String endpoint) async {
//     // TODO: Implement API call
//     return Future.delayed(Duration(seconds: 2), () => ['Option 1', 'Option 2', 'Option 3']);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Column(
//           children: <Widget>[
//             // Card List
//             for (var item in [
//               {'title': 'Chief Complaints', 'iconPath': 'assets/images/symptoms.png', 'endpoint': 'chief_complaints'},
//               {'title': 'Allergy History', 'iconPath': 'assets/images/allergys.png', 'endpoint': 'allergy_history'},
//               {'title': 'Diagnosis', 'iconPath': 'assets/images/diagnosis.png', 'endpoint': 'diagnosis'},
//               {'title': 'Examination Findings', 'iconPath': 'assets/images/search.png', 'endpoint': 'examination_findings'},
//               {'title': 'Family History', 'iconPath': 'assets/images/family.png', 'endpoint': 'family_history'},
//               {'title': 'Past Medical History', 'iconPath': 'assets/images/past.png', 'endpoint': 'past_medical_history'},
//               {'title': 'Surgical History', 'iconPath': 'assets/images/surgical.png', 'endpoint': 'surgical_history'}
//             ])
//               _buildCard(
//                 title: item['title']!,
//                 iconPath: item['iconPath']!,
//                 dropdownItems: fetchDataForDropdown(item['endpoint']!),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard({
//     required String title,
//     required String iconPath,
//     required Future<List<String>> dropdownItems,
//   }) {
//     return Builder(
//       builder: (context) {
//         // final screenWidth = MediaQuery.of(context).size.width;
//         return Card(
//           child: Container(
//             width: 350,
//             padding: EdgeInsets.all(8.0),
//             color: Colors.white,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       iconPath,
//                       width: 25.0,
//                       height: 25.0,
//                       fit: BoxFit.cover,
//                     ),
//                     SizedBox(width: 8.0),
//                     Expanded(
//                       child: Text(
//                         title,
//                         style: GoogleFonts.handjet(color: Colors.black, fontSize: 12),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10.0),
//                 FutureBuilder<List<String>>(
//                   future: dropdownItems,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return Text('No data available');
//                     } else {
//                       return TypeAheadField<String>(
//                         textFieldConfiguration: TextFieldConfiguration(
//                           decoration: InputDecoration(
//                             labelText: 'Select $title',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                         suggestionsCallback: (pattern) async {
//                           return snapshot.data!.where((item) => item.toLowerCase().contains(pattern.toLowerCase()));
//                         },
//                         itemBuilder: (context, suggestion) {
//                           return ListTile(
//                             title: Text(suggestion),
//                           );
//                         },
//                         onSuggestionSelected: (suggestion) {
//                           // Handle the selected suggestion
//                           print('Selected: $suggestion');
//                         },
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//



