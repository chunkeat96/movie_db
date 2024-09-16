import 'package:movie_db/config/app_config.dart';
import 'package:movie_db/global/secure_local_storage.dart';
import 'package:movie_db/res/label.dart';
import 'package:movie_db/server/response_entity.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

extension MapEx on Map? {
  StringBuffer logString(String title) {
    StringBuffer requestLog = StringBuffer();
    requestLog.writeln('===================== $title =====================');
    this?.forEach((key, value) {
      requestLog.writeln('$key = $value');
    });
    return requestLog;
  }

  Map<String, String> get baseHeaders {
    Map<String, String> params;
    if (this == null) {
      params = {};
    } else {
      params = Map.from(this!);
    }
    params['Authorization'] = Get.find<SecureLocalStorage>().accessToken;
    return params;
  }

  Map<String, dynamic> get baseParams {
    Map<String, dynamic> params;
    if (this == null) {
      params = {};
    } else {
      params = Map.from(this!);
    }
    params['language'] = 'en-US';
    params['api_key'] = '60c3f8820e02fcc4739484f0e814d9cf';
    params['watch_region'] = 'SG';
    return params;
  }
}

extension ResponseEx on Response {
  StringBuffer get responseLog {
    StringBuffer responseLog = StringBuffer();
    responseLog.writeln('===================== Response =====================');
    responseLog.writeln('statusCode = $statusCode');
    responseLog.writeln('url = ${request?.url}');
    responseLog.writeln('data = $bodyString');
    return responseLog;
  }

  StringBuffer get errorLog {
    StringBuffer errorLog = StringBuffer();
    errorLog.writeln('===================== Error =====================');
    errorLog.writeln('url = ${request?.url}');
    errorLog.writeln('statusCode = $statusCode');
    errorLog.writeln('message = $statusText');
    errorLog.writeln('data = $bodyString');
    return errorLog;
  }
}

class ServerRepository extends GetConnect {

  @override
  void onInit() {
    super.onInit();

    httpClient.baseUrl = Get.find<AppConfig>().config.appUrlKey;
    httpClient.timeout = const Duration(seconds: 30);

    httpClient.addResponseModifier((request, response) {

      if (response.isOk) {
        Get.find<Logger>().d(response.responseLog);
      } else {
        Get.find<Logger>().d(response.errorLog);
      }

      return response;
    });
  }

  Future<ResponseEntity<T>> loadEntityData<T>(
      String url, {
        String method = 'POST',
        Map<String, dynamic>? body,
        String contentType = 'application/json',
        Map<String, String>? headers,
        Map<String, dynamic>? query,
        T Function(dynamic)? decoder,
        dynamic Function(double)? uploadProgress
      }) async {
    try {
      headers = headers ?? {}.baseHeaders;
      body = body?.baseParams;
      query = query?.baseParams;

      final requestLog = Map.from({
        'url' : url,
        'headers' : headers,
        'method' : method,
        'body' : body,
        'query' : query,
      }).logString('Request');

      Get.find<Logger>().d(requestLog);

      var response = await request<ResponseEntity<T>>(
          url,
          method,
          body: body,
          contentType: contentType,
          headers: headers,
          query: query,
          decoder: (data) => data is Map ? ResponseEntity<T>.fromJson(data, fromJsonT: decoder)
              : ResponseEntity(success: false, message: Label.parseError.tr),
          uploadProgress: uploadProgress
      );

      if (response.isOk) {
        return response.body!;
      } else if (response.statusCode == null) {
        return ResponseEntity(success: false, message: Label.connectionError.tr);
      } else {
        return ResponseEntity(success: false, message: response.statusText ?? '', statusCode: response.statusCode);
      }

    } catch(e, s) {
      final runTimeLog = Map.from({
        'url' : url,
        'headers' : headers,
        'method' : method,
        'body' : body,
        'query' : query,
        'info' : decoder == null ? '### Please check the decoder whether is null ###' : '### Parse Error ###'
      }).logString('Runtime Error');

      Get.find<Logger>().f(runTimeLog, error: e, stackTrace: s);

      return ResponseEntity(success: false, message: Label.parseError.tr);
    }
  }
}