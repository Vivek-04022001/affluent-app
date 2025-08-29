import 'dart:convert';
import 'dart:io';

import 'package:affluent/constants/app_config.dart';
import 'package:affluent/main.dart';
import 'package:affluent/services/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ApiServices {
  static final Dio _dio = Dio();
  static const String baseUrl = AppConfig.appBaseUrl;
  static const String apiKey = AppConfig.apiKey;
  static bool _isHandlingUnauthorized = false;

  static final SecureStorageService _storage = SecureStorageService();

  static void initialize() {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // You can modify the request here if needed
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          // You can handle the response here if needed
          return handler.next(response); // Continue with the response
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            // Handle 401 Unauthorized
            await _handleUnauthorizedError();
          }
          return handler.next(error); // Continue with the error
        },
      ),
    );
  }

  static Future<void> _handleUnauthorizedError() async {
    if (_isHandlingUnauthorized) return;

    _isHandlingUnauthorized = true;
    await _storage.deleteBearerToken();

    final ctx = navigatorKey.currentContext;
    if (ctx != null && ctx.mounted) {
      GoRouter.of(ctx).go(AppConfig.kAuthExpiredRedirectPath);
    }

    _isHandlingUnauthorized = false;
  }

  static Future<Map<String, dynamic>?> _postForm(
    String endpoint,
    Map<String, dynamic> data, {
    bool useBearerToken = true,
  }) async {
    final String url = '$baseUrl$endpoint';

    try {
      FormData formData = FormData.fromMap(data);

      Options options = await _buildRequestOptions(useBearerToken);

      final response = await _dio.post(url, options: options, data: formData);

      return _parseResponse(response);
    } on DioException catch (error) {
      // Return the API error response directly if available
      if (error.response != null && error.response?.data != null) {
        return error.response?.data;
      }
      // Fallback to a generic error message if no response data is available
      return {'success': false, 'message': error.message};
    }
  }

  static Future<Map<String, dynamic>?> _get(
    String endpoint, {
    bool useBearerToken = true,
  }) async {
    final String url = '$baseUrl$endpoint';

    try {
      final options = await _buildRequestOptions(useBearerToken);

      final response = await _dio.get(url, options: options);

      return _parseResponse(response);
    } on DioException catch (error) {
      if (error.response != null && error.response?.data != null) {
        return error.response?.data;
      }
      return {'success': false, 'message': error.message};
    }
  }

  static Future<Map<String, dynamic>?> _delete(
    String endpoint, {
    bool useBearerToken = true,
  }) async {
    final String url = '$baseUrl$endpoint';

    try {
      final options = await _buildRequestOptions(useBearerToken);

      final response = await _dio.delete(url, options: options);

      return _parseResponse(response);
    } on DioException catch (error) {
      if (error.response != null && error.response?.data != null) {
        return error.response?.data;
      }
      return {'success': false, 'message': error.message};
    }
  }

  static Future<Map<String, dynamic>?> _postWithoutData(
    String endpoint, {
    bool useBearerToken = true,
  }) async {
    final String url = '$baseUrl$endpoint';

    try {
      Options options = await _buildRequestOptions(useBearerToken);

      final response = await _dio.post(
        url,
        options: options,
        queryParameters: useBearerToken ? null : {'API_KEY': apiKey},
      );

      return _parseResponse(response);
    } on DioException catch (error) {
      return {'success': false, 'message': error.message};
    }
  }

  static Future<Options> _buildRequestOptions(bool useBearerToken) async {
    if (useBearerToken) {
      String? token = await _storage.getBearerToken();
      return Options(
        headers: {'Authorization': 'Bearer $token', 'X-API-KEY': apiKey},
      );
    }

    return Options(headers: {'X-API-KEY': apiKey});
  }

  static Map<String, dynamic>? _parseResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else if (response.data is String) {
        return jsonDecode(response.data);
      } else {
        throw Exception('Unexpected response format');
      }
    } else if (response.statusCode == 401) {
      return {
        'success': false,
        'message': response.data['message'] ?? 'Unauthorized',
        'error': response.data['error'] ?? 'Token has expired',
      };
    } else {
      return {'success': false, 'message': 'Invalid response'};
    }
  }

  static Future<MultipartFile> createMultipartFile(File file) async {
    final String? mimeType = lookupMimeType(file.path);
    final String filename = file.path.split('/').last;

    if (mimeType != null) {
      final parts = mimeType.split('/');
      return await MultipartFile.fromFile(
        file.path,
        filename: filename,
        contentType: MediaType(parts[0], parts[1]),
      );
    } else {
      return await MultipartFile.fromFile(
        file.path,
        filename: filename,
        contentType: MediaType('application', 'octet-stream'),
      );
    }
  }
}
