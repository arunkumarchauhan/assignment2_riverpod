import 'package:assignment2_riverpod/data/network_api_service.dart';
import 'package:assignment2_riverpod/models/failure/failure.dart';
import 'package:assignment2_riverpod/models/post/post.dart';
import 'package:assignment2_riverpod/models/post/post_detail.dart';
import 'package:assignment2_riverpod/repository/post/post_list_repository.dart';
import 'package:either_dart/either.dart';

class PostListRepositoryService extends PostListRepository {
  final NetworkApiService _apiService = NetworkApiService();
  Either<List<Post>, Failure> _getPostListEither(Object obj) {
    late Either<List<Post>, Failure> either;
    if (obj is List) {
      either = Left(Post.postsFromMap(obj as List));
    } else if (obj is Failure) {
      either = Right(obj);
    } else {
      either = Right(Failure("Something went wrong!"));
    }
    return either;
  }

  Either<PostDetail, Failure> _getPostDetailEither(Object obj) {
    late Either<PostDetail, Failure> either;
    if (obj is Map) {
      either = Left(PostDetail.fromMap(obj as Map<String, dynamic>));
    } else if (obj is Failure) {
      either = Right(obj);
    } else {
      either = Right(Failure("Something went wrong!"));
    }
    return either;
  }

  @override
  Future<Either<List<Post>, Failure>> getPosts() async {
    var response;
    try {
      response = await _apiService.getRequest();
    } catch (e) {
      response = e;
    }
    return _getPostListEither(response);
  }

  @override
  Future<Either<PostDetail, Failure>> getPostDetail(int postId) async {
    var response = await _apiService.getRequest(subUrl: postId.toString());
    return _getPostDetailEither(response);
  }
}
