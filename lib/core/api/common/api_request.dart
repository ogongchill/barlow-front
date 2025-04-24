import 'package:dio/dio.dart';

enum RequestType{
  query,
  body,
  multipart,
  ;
}

sealed class ApiRequest {

  final RequestType type;

  ApiRequest(this.type);
}

class QueryRequest extends ApiRequest {
  final Map<String, dynamic> query;

  QueryRequest(this.query) : super(RequestType.query);
}

class BodyRequest<T> extends ApiRequest {

  final Map<String, dynamic> body;

  BodyRequest(this.body): super(RequestType.body);
}

class MultipartRequest extends ApiRequest {

  final FormData formData;

  MultipartRequest(this.formData): super(RequestType.multipart);
}
