import 'dart:convert';
import 'package:http/http.dart' as http;

class PSService {
  final String baseUrl = 'https://api-v2.paksouls.com/api';

  // Helper function to handle response and errors
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return json.decode(response.body);
      case 400:
        throw Exception('Bad request: ${response.body}');
      case 401:
        throw Exception('Unauthorized: ${response.body}');
      case 403:
        throw Exception('Forbidden: ${response.body}');
      case 404:
        throw Exception('Not found: ${response.body}');
      case 500:
        throw Exception('Internal server error: ${response.body}');
      default:
        throw Exception(
            'Unexpected error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<dynamic> get(String apiUrl, {Map<String, String>? headers}) async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + apiUrl), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error making GET request: $e');
    }
  }

  Future<dynamic> post(String apiUrl, Map<String, dynamic> parameters,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + apiUrl),
        headers: headers != null
            ? {...headers, 'Content-Type': 'application/json'}
            : {'Content-Type': 'application/json'},
        body: json.encode(parameters),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error making POST request: $e');
    }
  }

  Future<dynamic> put(String apiUrl, Map<String, dynamic> parameters,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.put(
        Uri.parse(baseUrl + apiUrl),
        headers: headers,
        body: json.encode(parameters),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error making PUT request: $e');
    }
  }

  Future<dynamic> patch(String apiUrl, Map<String, dynamic> parameters,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.patch(
        Uri.parse(baseUrl + apiUrl),
        headers: headers,
        body: json.encode(parameters),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error making PATCH request: $e');
    }
  }

  Future<dynamic> delete(String apiUrl,
      {Map<String, dynamic>? parameters, Map<String, String>? headers}) async {
    try {
      final response = await http.delete(
        Uri.parse(baseUrl + apiUrl),
        headers: headers,
        body: parameters != null ? json.encode(parameters) : null,
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error making DELETE request: $e');
    }
  }
}
