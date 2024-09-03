// import 'package:flutter/material.dart';
//
// class VitalData extends StatelessWidget {
//   final List<TextEditingController> controllers;
//
//   const VitalData({
//     Key? key,
//     required this.controllers,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> cardTexts = [
//       'Height',
//       'Weight',
//       'BMI',
//       'BP',
//       'Temperature',
//       'Pulse',
//       'R.R',
//       'Head Circumference',
//       'Spo2',
//       'Pain Score'
//     ];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Image.asset(
//               'assets/images/heart-rate.png',
//               width: 24,
//               height: 24,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               'Vital Data',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         SizedBox(
//           height: 120,  // Height to accommodate separate containers
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: cardTexts.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 120,  // Set a fixed width for each container
//                 margin: const EdgeInsets.only(right: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 25,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         cardTexts[index],
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.black54,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 8),
//                       Expanded(
//                         child: TextField(
//                           controller: controllers[index],
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                           ),
//                           onSubmitted: (value) {
//                             print('${cardTexts[index]}: $value');
//                             controllers[index].clear();  // Clear the field after saving
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VitalData extends StatelessWidget {
  final List<TextEditingController> controllers;

  const VitalData({
    Key? key,
    required this.controllers,
  }) : super(key: key);

  // Function to handle the POST request
  Future<void> postVitalData(Map<String, String> vitalData) async {
    final url = Uri.parse('http://localhost:3000/vitals'); // Replace with your API URL
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(vitalData),
      );

      if (response.statusCode == 200) {
        print('Data posted successfully');
      } else {
        print('Failed to post data');
      }
    } catch (e) {
      print('Error: $e');
    }
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cardTexts.length,
            itemBuilder: (context, index) {
              return Container(
                width: 120,
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
                          onSubmitted: (value) {
                            print('${cardTexts[index]}: $value');
                            controllers[index].clear(); // Clear the field after saving

                            // Prepare data to be posted
                            Map<String, String> vitalData = {};
                            for (int i = 0; i < controllers.length; i++) {
                              vitalData[cardTexts[i]] = controllers[i].text;
                            }

                            // Post the data to the API
                            postVitalData(vitalData);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
