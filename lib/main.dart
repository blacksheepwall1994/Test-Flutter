import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:test_ui/module/notilabel.dart';

import 'notification.dart';

NotificationResponse? notificationResponse;
var loadData = () async {
  final String response = await rootBundle.loadString('assets/json/noti.json');
  notificationResponse = NotificationResponse.fromRawJson(response);
};
void main(List<String> args) async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  loadData();
  // notificationResponse.data?.forEach((element) {
  //   debugPrint("${element.toJson()}");
  //   debugPrint("____________________");
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Widget formatxt(String text) {
  //   for (int i = 0; i < text.length; i++) {
  //     if(i>= notificationResponse!.data![0].message!.highlights![0].offset && i<= ){

  //     }
  //   }
  // }
  Widget buildItem(index) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          SizedBox(
            height: 56,
            width: 56,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.network(
                    notificationResponse!.data![index].image!,
                    fit: BoxFit.cover,
                  ),
                ),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(2.5), // Border radius
                    child: ClipOval(
                        child: Image.network(
                      notificationResponse!.data![index].icon.toString(),
                      height: 24,
                      width: 24,
                    )),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 12,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notificationResponse!.data![index].message!.text.toString(),
                //style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('dd/MM/yyyy, HH:mm')
                    .format(DateTime.fromMillisecondsSinceEpoch(
                        notificationResponse!.data![index].receivedAt! * 1000))
                    .toString(),
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            const NotiLabel(),
            Expanded(
              child: ListView.builder(
                itemCount: notificationResponse!.data!.length,
                itemBuilder: (context, index) => buildItem(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
