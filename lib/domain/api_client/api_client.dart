import 'dart:convert';
import 'dart:io';
import 'package:uuid/uuid.dart';
//import 'package:http/http.dart' as http;

class ApiClient {
  final _client = HttpClient();
  // static const _host = 'https://sok.tomskneft.ru';
  static const _clubId = '937a5809-51a2-11e7-abe3-00237da8a880';
  static const _apiLogin = 'MobileClient';
  static const _apiPassword = 'gA0do1ry';
  static const _apiKey = '86476cb1-558e-4684-a621-fujedb269968';
  static String logPassBase64 =
      base64.encode(utf8.encode('$_apiLogin:$_apiPassword'));

  Future<String> auth({required String phone, required String password}) {
    final token = _makeToken(phone: phone, password: password);
    return token;
  }

  Future<String> _makeToken(
      {required String phone, required String password}) async {
    const notificationId = Uuid();
    final url =
        Uri.parse('https://sok.tomskneft.ru/MobService/hs/api/v3/auth_client');
    final parameters = <String, dynamic>{
      "phone": phone,
      "password": password,
      "Request_id": notificationId.v4(),
      "club_id": _clubId,
    };

    final request = await _client.postUrl(url);
    request.headers.add('usertoken', '');
    request.headers.add('ApiKey', _apiKey);
    //request.headers.add('Host', _host);
    request.headers.add('Authorization', 'Basic $logPassBase64');
    request.headers.add('Content-Type', 'application/json');
    //request.headers.contentLength = jsonEncode(parameters).length;
    //request.headers.add('Content-Length', jsonEncode(parameters).toString().length.toString());

    request.write(jsonEncode(parameters));

    final response = await request.close();

    // final json = await response
    //     .transform(utf8.decoder)
    //     .toList()
    //     .then((value) => value.join)
    //     .then((v) => jsonDecode(v as [String]) as Map<String, dynamic>);
    final responseBody = await response.transform(utf8.decoder).join();
    final data = json.decode(responseBody);

    final responeData = data['data'];
    final token = responeData['user_token'] as String;
    return token;
  }
}
// Future<String> _makeToken(
  //     {required String phone, required String password}) async {
  //   const notificationId = Uuid();
  //   final url =
  //       Uri.parse('https://sok.tomskneft.ru/MobService/hs/api/v3/auth_client');
  //   final body = <String, dynamic>{
  //     "phone": phone,
  //     "password": password,
  //     "Request_id": notificationId.v4(),
  //     "club_id": _clubId,
  //   };
  //   final response = await http.post(url,
  //       headers: {
  //         'usertoken': '',
  //         'ApiKey': _apiKey,
  //         //'Host': _host,
  //         'Authorization': 'Basic $logPassBase64',
  //         'Content-Type': 'application/json'
  //       },
  //       body: jsonEncode(body));
  //   final json = utf8.decode(response.bodyBytes);

  //   // final json = await response
  //   //     .transform(utf8.decoder)
  //   //     .toList()
  //   //     .then((value) => value.join)
  //   //     .then((v) => jsonDecode(v as String) as Map<String, dynamic>);
  //   // final responeData = json['data'];
  //   // final token = responeData['user_token'] as String;
  //   // return token;
  //   return json;
  // }