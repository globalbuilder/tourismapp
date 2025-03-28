import 'package:dio/dio.dart';
import 'package:tourism_frontend/core/config/constants/api_endpoints.dart';
import 'package:tourism_frontend/features/accounts/models/user_model.dart';
import 'package:tourism_frontend/features/accounts/models/profile_model.dart';

/// Combines Auth + User + Profile + Password logic.
class AccountsService {
  final Dio dio;
  String? accessToken;
  String? refreshToken;
  UserModel? currentUser;
  ProfileModel? currentProfile;

  AccountsService({required this.dio});

  // ------------------ AUTH PART ------------------
  /// Login => POST /accounts/login/ (returns refresh, access)
  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(ApiEndpoints.login, data: {
        'username': username,
        'password': password,
      });
      accessToken = response.data['access'];
      refreshToken = response.data['refresh'];
      // Optionally load user data
    } on DioException catch (e) {
      throw Exception(e.response?.data?['detail'] ?? 'Login failed');
    }
  }

  /// Register => POST /accounts/register/
  /// Expects username, first_name, last_name, password1, password2, optional image
  Future<void> register({
    required String username,
    required String firstName,
    required String lastName,
    required String password1,
    required String password2,
  }) async {
    try {
      await dio.post(ApiEndpoints.register, data: {
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'password1': password1,
        'password2': password2,
        // 'image': <multipart if needed>
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data?['detail'] ?? 'Registration failed');
    }
  }

  /// Refresh => POST /accounts/refresh/
  Future<void> refreshTokens() async {
    if (refreshToken == null) return;
    try {
      final response = await dio.post(ApiEndpoints.refresh, data: {
        'refresh': refreshToken,
      });
      accessToken = response.data['access'];
      // refresh remains the same
    } on DioException catch (e) {
      throw Exception(e.response?.data?['detail'] ?? 'Token refresh failed');
    }
  }

  /// Logout => POST /accounts/logout/ with { "refresh": <token> }
  Future<void> logout() async {
    if (refreshToken == null) return;
    try {
      await dio.post(ApiEndpoints.logout, data: {'refresh': refreshToken});
    } catch (_) {
      // ignore errors
    }
    accessToken = null;
    refreshToken = null;
    currentUser = null;
    currentProfile = null;
  }

  // ------------------ USER & PROFILE PART ------------------
  /// getUser => GET /accounts/user/
  Future<UserModel> getUser() async {
    if (accessToken == null) {
      throw Exception('No access token, please login first');
    }
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    try {
      final response = await dio.get(ApiEndpoints.user);
      currentUser = UserModel.fromJson(response.data);
      return currentUser!;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['detail'] ?? 'Failed to load user');
    }
  }

  /// updateUser => PUT/PATCH /accounts/user/
  /// for now we do a simple patch
  Future<UserModel> updateUser({
    String? firstName,
    String? lastName,
  }) async {
    if (accessToken == null) {
      throw Exception('No access token, please login');
    }
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    try {
      final response = await dio.patch(ApiEndpoints.user, data: {
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
      });
      currentUser = UserModel.fromJson(response.data);
      return currentUser!;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['detail'] ?? 'Failed to update user');
    }
  }

  /// getProfile => GET /accounts/profile/
  Future<ProfileModel> getProfile() async {
    if (accessToken == null) throw Exception('Login required');
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    try {
      final response = await dio.get(ApiEndpoints.profile);
      currentProfile = ProfileModel.fromJson(response.data);
      return currentProfile!;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['detail'] ?? 'Failed to load profile');
    }
  }

  /// updateProfile => PATCH /accounts/profile/
  Future<ProfileModel> updateProfile({
    String? email,
    String? phoneNumber,
    String? address,
    String? biography,
    String? website,
  }) async {
    if (accessToken == null) throw Exception('Login required');
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    final data = <String, dynamic>{
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (address != null) 'address': address,
      if (biography != null) 'biography': biography,
      if (website != null) 'website': website,
    };
    try {
      final response = await dio.patch(ApiEndpoints.profile, data: data);
      currentProfile = ProfileModel.fromJson(response.data);
      return currentProfile!;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['detail'] ?? 'Failed to update profile');
    }
  }

  /// changePassword => PUT/PATCH /accounts/change-password/
  /// old_password, new_password1, new_password2
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword1,
    required String newPassword2,
  }) async {
    if (accessToken == null) throw Exception('Login required');
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    try {
      await dio.patch(ApiEndpoints.changePassword, data: {
        'old_password': oldPassword,
        'new_password1': newPassword1,
        'new_password2': newPassword2,
      });
    } on DioException catch (e) {
      throw Exception(e.response?.data?['detail'] ?? 'Failed to change password');
    }
  }
}
