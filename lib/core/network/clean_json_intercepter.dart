import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

dynamic parseJson(String jsonStr) {
  return jsonDecode(jsonStr);
}

class CleanJsonInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data is String) {
      final cleaned = cleanJson(response.data);
      try {
        final decoded = await compute(parseJson, cleaned);
        response.data = decoded;
      } catch (e) {
        throw Exception('Failed to decode JSON response: ${response.data}');
      }
    }

    super.onResponse(response, handler);
  }
}

String cleanJson(String input) {
  return input.replaceAllMapped(
    RegExp(r',(\s*[\]}])'),
    (match) => match.group(1)!,
  );
}
