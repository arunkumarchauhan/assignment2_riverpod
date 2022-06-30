import 'package:assignment2_riverpod/models/failure/failure.dart';
import 'package:assignment2_riverpod/models/post/post.dart';
import 'package:either_dart/either.dart';

abstract class PostListRepository {
  Future<Either<List<Post>, Failure>> getPosts();
}
