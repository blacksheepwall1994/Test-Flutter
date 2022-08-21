import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:tiengviet/tiengviet.dart';

final Dio dio = Dio();
List<Map<String, dynamic>> searchValue = [];
var searchText = '';
var data = [];
var opened = false;
List<bool> tapped = [];
void main(List<String> args) async {
  runApp(const MyApp());
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
  List formatxt(int index, data) {
    // List abc = [];
    List high = (data![index]['highlights'] ?? []).map((e) {
      int offset = (e['offset'] ?? 0);
      num length = offset + (e['length'] ?? 0);
      return (data![index]['body'] ?? "")
          .toString()
          .substring(offset, length.toInt());
    }).toList();
    List need = [];
    for (var e in high) {
      need.addAll(e.split(" "));
    }
    return need;
  }

  Widget buildItem(index, data) {
    final List<String> split = data![index]["body"].toString().split(" ");
    tapped.add(false);
    return InkWell(
      onTap: () {
        setState(() {
          tapped[index] = !tapped[index];
        });
      },
      child: Container(
        color: tapped[index] ? Colors.amber.shade100 : null,
        padding: const EdgeInsets.all(12.0),
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
                    child: data![index]["image"].toString().isEmpty
                        ? Container(color: Colors.green)
                        : Image.network(
                            data![index]["image"]
                                .toString()
                                .replaceAll("\$size\$", "1000x1000"),
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
                        data![index]["icon"].toString(),
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
                  RichText(
                      text: TextSpan(
                    children: split
                        .map((e) => TextSpan(
                            text: '$e ',
                            style: formatxt(index, data).contains(e)
                                ? const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)
                                : const TextStyle(color: Colors.black)))
                        .toList(),
                  )),
                  Text(
                    DateFormat('dd/MM/yyyy, HH:mm')
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            data![index]["created_at"]!))
                        .toString(),
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container notiBar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            opened
                ? InkWell(
                    onTap: () {
                      setState(() {
                        opened = !opened;
                        searchText = '';
                        searchValue.clear();
                      });
                    },
                    child: const Icon(Icons.cancel),
                  )
                : const Text(
                    "Thông báo",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
            Container(
              width: opened ? 8 : 0,
            ),
            opened
                ? Flexible(
                    child: TextField(
                    onChanged: (text) {
                      setState(() {
                        searchValue.clear();
                        searchText = TiengViet.parse(text).toLowerCase();
                        for (var data in data) {
                          {
                            if (TiengViet.parse(
                                        data["body"].toString().toLowerCase())
                                    .contains(searchText) &&
                                !searchValue.contains(data)) {
                              searchValue.add(data);
                              // print(data)
                            }
                          }
                        }
                      });
                    },
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(
                            10, 10, 10, 0), // control your hints text size
                        border: OutlineInputBorder(),
                        hintText: 'Nhập từ khoá'),
                  ))
                : InkWell(
                    onTap: () {
                      setState(() {
                        opened = !opened;
                      });
                    },
                    child: const Icon(
                      Icons.search,
                      size: 28,
                    ),
                  ),
          ]),
    );
  }

  Future<Map> getData() async {
    Options optionsLogin = Options(
      headers: {
        'content-type': 'application/json; charset=utf-8',
        'x-gapo-workspace-id': '581860791816317',
        'x-gapo-lang': 'vi',
      },
    );

    var dataLogin = {
      "client_id": "6n6rwo86qmx7u8aahgrq",
      "device_model": "Simulator iPhone 11",
      "device_id": "76cce865cbad4d02",
      "password":
          "4bff60a3797bc8053cd40253218c93afa7962fb966d012c844e254ad7788147e",
      "trusted_device": true,
      "email": "nguyenmanhtoan@gapo.com.vn"
    };
    var login = await dio.post(
      "https://staging-api.gapowork.vn/auth/v3.0/login",
      data: dataLogin,
      options: optionsLogin,
    );
    var token = login.data["data"]["access_token"];
    Options optionsNoti = Options(headers: {
      'x-gapo-workspace-id': '581860791816317',
      'x-gapo-lang': 'vi',
      'x-gapo-user-id': ' 1042179540',
      'Authorization': '$token'
    });
    var listNoti = await dio.get(
      "https://staging-api.gapowork.vn/mini-task/v1.0/notify?workspace_id=582567209681709&limit=30",
      options: optionsNoti,
    );
    return await listNoti.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            notiBar(),
            FutureBuilder<Map>(
              future: getData(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return const Text("Đang xử lý");
                }
                if (snapshot.hasError) {
                  return const Text("Error");
                }
                if (snapshot.hasData) {
                  // tapped.clear();
                  data = snapshot.data!["data"];
                  if (searchValue.isEmpty && searchText.isEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!["data"].length,
                        itemBuilder: (context, index) =>
                            buildItem(index, snapshot.data!["data"]),
                      ),
                    );
                  } else if (searchValue.isEmpty && searchText.isNotEmpty) {
                    return const Text("Không có kết quả phù hợp");
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: searchValue.length,
                          itemBuilder: (context, index) =>
                              buildItem(index, searchValue)),
                    );
                  }
                }
                return const Text("Có lỗi đã xảy ra");
                // return buildItem(0, snapshot.data!["data"]);
              },
            )
            // searchValue.isEmpty
            //     ?
            //     : Expanded(
            //         child:
            // ListView.builder(
            //         itemCount: searchValue.length,
            //         itemBuilder: (context, index) =>
            //             buildItem(index, searchValue.asMap()),
            //       ))
          ],
        ),
      ),
    );
  }
}
