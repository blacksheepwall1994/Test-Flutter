// import 'package:flutter/material.dart';

// var abc;

// class NotiLabel extends StatefulWidget {
//   const NotiLabel({Key? key}) : super(key: key);

//   @override
//   State<NotiLabel> createState() => _NotiLabelState();
// }

// class _NotiLabelState extends State<NotiLabel> {
//   var opened = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(10.0),
//       child: Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: opened
//               ? [
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         opened = !opened;
//                       });
//                     },
//                     child: const Icon(Icons.cancel),
//                   ),
//                   Container(width: 8),
//                   Flexible(
//                       child: TextField(
//                     onChanged: (text) {
//                       abc = text;
//                       print('First text field: $text');
//                     },
//                     decoration: const InputDecoration(
//                         isDense: true,
//                         contentPadding: EdgeInsets.fromLTRB(
//                             10, 10, 10, 0), // control your hints text size

//                         border: OutlineInputBorder(),
//                         hintText: 'Nhập từ khoá'),
//                   ))
//                 ]
//               : [
//                   const Text(
//                     "Thông báo",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         opened = !opened;
//                       });
//                     },
//                     child: const Icon(
//                       Icons.search,
//                       size: 28,
//                     ),
//                   ),
//                 ]),
//     );
//   }
// }
