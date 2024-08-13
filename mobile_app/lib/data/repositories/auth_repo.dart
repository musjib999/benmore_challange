import '../../domain/domain.dart';
import '../source/remote/api_endpoints.dart';
import '../source/remote/remote_data.dart';

class AuthRepo extends AuthAbstract {
  static String authUrl = '';
  static String appUrl = '';
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final _api = RemoteData();

  @override
  Future<AuthResponse> login(
      {required String email, required String password}) async {
    try {
      final response = await _api.postData(
        url: "${ApiEndPoints.user}/login",
        data: {
          'email': email,
          'password': password,
        },
      );
      final data = AuthResponse.fromJson(response['data']);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> register({
    required String username,
    required String email,
    required String password,
    required String profilePic,
  }) async {
    try {
      final response = await _api.postData(
        url: "${ApiEndPoints.user}/register",
        data: {
          "username": username,
          "email": email,
          "password": password,
          "profilePic": profilePic,
        },
      );
      final data = User.fromJson(response['data']);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future updateProfile(
      {required String id,
      String? username,
      String? profilePic,
      required String token}) async {
    try {
      final response = await _api.updateData(
        url: '${ApiEndPoints.user}/$id',
        data: {
          "username": username,
          "profilePic": profilePic,
        },
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      User user = User.fromJson(response['data']);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUser({required String token}) async {
    try {
      final response = await _api.getData(
        url: '$appUrl/users',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      User user = User.fromJson(response['data']);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> followUser(
      {required String token,
      required String userId,
      required String followeeId,
      required String status}) async {
    try {
      final response = await _api.postData(
        url: '${ApiEndPoints.user}/$userId/$followeeId/$status',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      return response['message'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future changePassword(
      {required String oldPassword, required String newPassword}) async {}
}
