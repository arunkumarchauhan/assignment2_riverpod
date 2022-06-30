import 'package:assignment2_riverpod/data/network_api_service.dart';
import 'package:assignment2_riverpod/models/failure/failure.dart';
import 'package:assignment2_riverpod/models/post/post_detail.dart';
import 'package:assignment2_riverpod/repository/post/post_detail_repository.dart';
import 'package:either_dart/either.dart';

class PostDetailRepositoryService extends PostDetailRepository {
  final NetworkApiService _apiService = NetworkApiService();

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
  Future<Either<PostDetail, Failure>> getPostDetail(int postId) async {
    var response;
    try {
      response = await _apiService.getRequest(subUrl: '/$postId');
    } catch (e) {
      response = e;
    }
    return _getPostDetailEither(response);
  }
}
