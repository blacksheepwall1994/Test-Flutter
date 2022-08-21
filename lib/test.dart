// import 'package:dio/dio.dart';

// final Dio dio = Dio();
// void main(List<String> args) async {
//   Future<Map> getData() async {
//     Options optionsLogin = Options(
//       headers: {
//         'content-type': 'application/json; charset=utf-8',
//         'x-gapo-workspace-id': '581860791816317',
//         'x-gapo-lang': 'vi',
//       },
//     );

//     var dataLogin = {
//       "client_id": "6n6rwo86qmx7u8aahgrq",
//       "device_model": "Simulator iPhone 11",
//       "device_id": "76cce865cbad4d02",
//       "password":
//           "4bff60a3797bc8053cd40253218c93afa7962fb966d012c844e254ad7788147e",
//       "trusted_device": true,
//       "email": "nguyenmanhtoan@gapo.com.vn"
//     };
//     var login = await dio.post(
//       "https://staging-api.gapowork.vn/auth/v3.0/login",
//       data: dataLogin,
//       options: optionsLogin,
//     );
//     var token = login.data["data"]["access_token"];
//     Options optionsNoti = Options(headers: {
//       'x-gapo-workspace-id': '581860791816317',
//       'x-gapo-lang': 'vi',
//       'x-gapo-user-id': ' 1042179540',
//       'Authorization': '$token'
//     });
//     var listNoti = await dio.get(
//       "https://staging-api.gapowork.vn/mini-task/v1.0/notify?workspace_id=582567209681709&limit=30",
//       options: optionsNoti,
//     );
//     return listNoti.data;
//   }

//   var abc = await getData();

//   List high = (abc['highlights'] ?? []).map((e) {
//     int offset = (e['offset'] ?? 0);
//     num length = offset + (e['length'] ?? 0);
//     return (abc['body'] ?? "").toString().substring(offset, length.toInt());
//   }).toList();
//   List need = [];
//   for (var e in high) {
//     need.addAll(e.split(" "));
//   }
//   print(need);
// }
