import 'package:flutter/material.dart';

class NotiLabel extends StatefulWidget {
  const NotiLabel({Key? key}) : super(key: key);

  @override
  State<NotiLabel> createState() => _NotiLabelState();
}

class _NotiLabelState extends State<NotiLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Thông báo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            Icon(
              Icons.search,
              size: 28,
            )
          ]),
    );
  }
}
