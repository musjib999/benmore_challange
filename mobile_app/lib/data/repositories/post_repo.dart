import 'package:benmore_challange/controller/auth_controller.dart';
import 'package:benmore_challange/data/source/remote/api_endpoints.dart';
import 'package:benmore_challange/data/source/remote/remote_data.dart';
import 'package:benmore_challange/domain/domain.dart';

class PostRepo {
  final RemoteData _data = RemoteData();
  Future<List<Post>> getAllPosts({required String accessToken}) async {
    try {
      final response = await _data.getData(
        url: ApiEndPoints.post,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );
      final body = response['data'] as List;
      if (body.isEmpty) {
        return [];
      } else {
        final shipments = body.map((e) => Post.fromJson(e)).toList();
        return shipments;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PostModel> getOnePost(
      {required String id, required String accessToken}) async {
    try {
      final response = await _data.getData(
        url: '${ApiEndPoints.post}/$id',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );
      final body = response['data'];

      final shipments = PostModel.fromJson(body);
      return shipments;
    } catch (e) {
      rethrow;
    }
  }

  Future<Post?> addPost(
      {required String title,
      required String description,
      required String image,
      required String userId,
      required String accessToken}) async {
    try {
      final response = await _data.postData(
        url: ApiEndPoints.post,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        data: {
          'title': title,
          'description': description,
          'imageUrl': image,
          'userId': userId,
        },
      );
      final body = response['data'];
      final shipments = Post(
        id: body['_id'],
        title: body['title'],
        description: body['description'],
        imageUrl: body['image_url'],
        createdAt: DateTime.parse(body['created_at']),
        likes: body['likes'],
        likedBy: List<String>.from(body["likedBy"].map((x) => x)),
        assignedTo: Profile(
          id: AuthController.instance.user.value!.id,
          username: AuthController.instance.user.value!.username,
          profilePic: AuthController.instance.user.value!.profilePic,
        ),
      );
      return shipments;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> getUserPost(
      {required String userId, required String accessToken}) async {
    try {
      final response = await _data.getData(
        url: '${ApiEndPoints.post}/user/$userId',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );
      final body = response['data'] as List;
      if (body.isEmpty) {
        return [];
      } else {
        final shipments = body.map((e) => Post.fromJson(e)).toList();
        return shipments;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> likePost(
      {required String postId,
      required String userId,
      required String accessToken}) async {
    try {
      final response = await _data.postData(
        url: '${ApiEndPoints.post}/$postId/$userId/like',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
      );
      final body = response['ok'] as bool;
      return body;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> comment(
      {required String postId,
      required String userId,
      required String comment,
      required String accessToken}) async {
    try {
      await _data.postData(
        url: '${ApiEndPoints.post}/$postId/comment',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        },
        data: {
          'userId': userId,
          'commentText': comment,
        },
      );
      return comment;
    } catch (e) {
      rethrow;
    }
  }
}
