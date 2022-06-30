import 'package:assignment2_riverpod/models/failure/failure.dart';
import 'package:assignment2_riverpod/models/post/post.dart';
import 'package:assignment2_riverpod/services/post/post_list_repository_service.dart';
import 'package:assignment2_riverpod/utils/status.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postListRepositoryServiceProvider =
    Provider.autoDispose<PostListRepositoryService>(
        (ref) => PostListRepositoryService());

//Method 1 :
//***********************************************************************//
final postListStatusProvider = StateProvider<Status>((ref) => Status.loading);
final selectedPostIdProvider = StateProvider((ref) => 0);

final postListProviderVM =
    FutureProvider<Either<List<Post>, Failure>>((ref) async {
  final postListRepoService = ref.read(postListRepositoryServiceProvider);
  final fetchStatusProvider = ref.read(postListStatusProvider.notifier);
  fetchStatusProvider.state = Status.loading;
  final response = await postListRepoService.getPosts();
  fetchStatusProvider.state = Status.completed;
  return response;
});

//***********************************************************************//

//Method 2 :
class PostListResponse {
  PostListResponse(this._status, this.either, this.selectedPostId);
  Status _status = Status.loading;
  Either<List<Post>, Failure> either;
  Status get status => _status;
  int selectedPostId = 0;
}

class PostListResponseVM extends StateNotifier<PostListResponse> {
  PostListResponseVM()
      : super(PostListResponse(Status.loading, Right(Failure("Loading")), 0));

  void getPosts(WidgetRef ref) async {
    final repoService = ref.read(postListRepositoryServiceProvider);
    final response = await repoService.getPosts();

    state = PostListResponse(Status.completed, response, 0);
  }
}

final postListVM = Provider<PostListResponseVM>((ref) => PostListResponseVM());
final postListVMProvider =
    StateNotifierProvider<PostListResponseVM, PostListResponse>(
        (ref) => ref.read(postListVM));
