import 'package:get/get_connect/http/src/status/http_status.dart';

class ResponseEntity<T> {
  late bool success;
  late String message;
  int? statusCode;

  T? data;
  List<T> listData = [];
  List list = [];

  ResponseEntity({
    required this.success,
    required this.message,
    this.statusCode,
  });


  ResponseEntity.fromJson(Map json, {T Function(Object json)? fromJsonT}) {
    message = json["msg"] ?? '';

    String rst = '1';
    if (json["code"] != null) {
      if (json["code"] is String) {
        rst = json["code"];
      } else {
        rst = json["code"].toString();
      }
    }

    if (rst == '1') {
      success = true;
    } else {
      success = false;
      statusCode = HttpStatus.badRequest;
    }

    var jsonData = json;
    if (fromJsonT != null) {
      data = fromJsonT(jsonData);
    }
  }


}