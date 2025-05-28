// lib/services/api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:goang_driver/driver_app/models/driver_profile.dart';
// import 'package:goang_driver/driver_app/providers/driver_status_provider.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(BaseOptions(
          baseUrl: dotenv.env['API_URL'] ?? '',
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        )) {

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  /// POST /api/driver/register
  Future<Map<String, dynamic>> registerDriver({
    required String username,
    required String email,
    required String password,
    required String route,
  }) async {
    final resp = await _dio.post(
      '/api/driver/register',
      data: {
        'username': username,
        'email': email,
        'password': password,
        'route': route,
      },
    );
    return resp.data['data'] as Map<String, dynamic>;
  }

  /// POST /driver/login
  Future<String> loginDriver({
    required String email,
    required String password,
  }) async {
    final resp = await _dio.post(
      'api/driver/login',
      data: {'email': email, 'password': password},
    );
    // resp.data == { "data": { "token": "…"} }
    return resp.data['data']['token'] as String;
  }

  // /// GET /api/driver
  // Future<DriverProfile> getDriverProfile() async {
  //   final resp = await _dio.get('/api/driver');
  //   final data = resp.data['data'] as Map<String, dynamic>;
  //   return DriverProfile.fromJson(data);
  // }

  // /// GET /api/driver/{id}/status
  // Future<Map<String, dynamic>> getDriverStatus({required int id}) async {
  //   final resp = await _dio.get('/api/driver/$id/status');
  //   return resp.data['data'] as Map<String, dynamic>;
  // }

  // /// PATCH /api/driver/{id}/status (online/offline)
  // Future<void> updateDriverStatus({
  //   required int id,
  //   required OnlineStatus state,
  // }) async {
  //   await _dio.patch(
  //     '/api/driver/$id/status',
  //     data: {'online': state == OnlineStatus.online},
  //   );
  // }

  // /// PATCH /api/driver/{id}/status (full/available)
  // Future<void> updateDriverFull({
  //   required int id,
  //   required bool full,
  // }) async {
  //   await _dio.patch(
  //     '/api/driver/$id/status',
  //     data: {'full': full},
  //   );
  // }
}