import 'package:assignment2_riverpod/models/failure/failure.dart';
import 'package:assignment2_riverpod/models/post/post_detail.dart';
import 'package:assignment2_riverpod/services/post/post_detail_repository_service.dart';
import 'package:assignment2_riverpod/utils/status.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//***********************************************************************//

//Method 1 :
final postDetailStatusProvider =
    StateProvider.autoDispose<Status>((ref) => Status.loading);

final postDetailRepoServiceProvider =
    Provider((ref) => PostDetailRepositoryService());

final postDetailProviderVM =
    FutureProvider.family<Either<PostDetail, Failure>, int>(
        (ref, int postId) async {
  final fetchStatusProvider = ref.read(postDetailStatusProvider.notifier);
  fetchStatusProvider.state == Status.loading;
  final postDetailService = ref.read(postDetailRepoServiceProvider);
  final response = await postDetailService.getPostDetail(postId);
  fetchStatusProvider.state = Status.completed;
  return response;
});

//***********************************************************************//

//Method 2:
class PostDetailResponse {
  PostDetailResponse(this.status, this.either);
  Status status = Status.loading;
  Either<PostDetail, Failure> either;
}

final postDetailResponse =
    PostDetailResponse(Status.loading, Right(Failure("Loading")));

class PostDetailVM extends StateNotifier<PostDetailResponse> {
  PostDetailVM() : super(postDetailResponse);

  void getPostDetail(WidgetRef ref, int postId) async {
    final fProvider = ref.read(postDetailRepoServiceProvider);
    final response = await fProvider.getPostDetail(postId);
    state = PostDetailResponse(Status.completed, response);
  }
}

final postDetailVM = Provider<PostDetailVM>((ref) => PostDetailVM());
final postDetailVmProvider =
    StateNotifierProvider<PostDetailVM, PostDetailResponse>(
        (ref) => ref.watch(postDetailVM));

//***********************************************************************//

//Method 3:
final postDetailResponseProvider =
    FutureProvider.family<PostDetailResponse, int>((ref, int postId) async {
  final postDetailService = ref.read(postDetailRepoServiceProvider);
  final response = await postDetailService.getPostDetail(postId);
  return PostDetailResponse(Status.completed, response);
});
