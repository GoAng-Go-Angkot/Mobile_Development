import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//////// Provider untuk ApiService
final apiServiceProvider = Provider((_) => ApiService());

/// StateNotifierProvider untuk auth flow (register & login)
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final api = ref.watch(apiServiceProvider);
  return AuthNotifier(api);
});

/// State untuk loading/error
class AuthState {
  final bool isLoading;
  final String? error;
  const AuthState({this.isLoading = false, this.error});
  AuthState copyWith({bool? isLoading, String? error}) =>
      AuthState(isLoading: isLoading ?? this.isLoading, error: error);
}

/////////// AuthNotifier untuk menangani register & login
class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService _api;
  final FlutterSecureStorage _storage;

  AuthNotifier(this._api)
      : _storage = const FlutterSecureStorage(),
        super(const AuthState());

  /////////// Register driver
Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String route,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _api.registerDriver(
        username: username,
        email: email,
        password: password,
        route: route,
      );
      return true;
    } on DioException catch (e) {
      final serverErrors = e.response?.data['errors'];
      final msg = serverErrors?.toString() ?? e.message;
      state = state.copyWith(error: msg);
      return false;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /////// Login driver
Future<bool> login({
  required String email,
  required String password,
}) async {
  state = state.copyWith(isLoading: true, error: null);
  try {
    final token = await _api.loginDriver(
      email: email,
      password: password,
    );
    await _storage.write(key: 'jwt', value: token);
    return true;
  } on DioException catch (e) {
    final serverErrors = e.response?.data['errors'];
    final msg = serverErrors?.toString() ?? e.message;
    state = state.copyWith(error: msg);
    return false;
  } catch (e) {
    state = state.copyWith(error: e.toString());
    return false;
  } finally {
    state = state.copyWith(isLoading: false);
  }
}
}
