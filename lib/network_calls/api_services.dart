import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:heady_assignement/network_calls/api_url_endpoint.dart';

import 'package:http/io_client.dart' as http;

part 'api_services.chopper.dart';
@ChopperApi()
abstract class ApiService extends ChopperService {
  static ApiService create(String baseUrl) {
    final client = ChopperClient(
      client: http.IOClient(
        HttpClient()..connectionTimeout = const Duration(seconds: 60),
      ),
      baseUrl: baseUrl,
      //services: [_$ApiService()],
      converter: JsonConverter(),
    );
    return _$ApiService(client);
  }

  @Get(path: API_ENDPOINT.getAllProductData)
  Future<Response> getAlProductData();


}
