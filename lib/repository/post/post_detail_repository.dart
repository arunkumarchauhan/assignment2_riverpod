import 'package:assignment2_riverpod/models/failure/failure.dart';
import 'package:assignment2_riverpod/models/post/post_detail.dart';
import 'package:either_dart/either.dart';

abstract class PostDetailRepository {
  Future<Either<PostDetail, Failure>> getPostDetail(int postId);
}
