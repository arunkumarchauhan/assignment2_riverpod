import 'package:assignment2_riverpod/models/failure/failure.dart';
import 'package:assignment2_riverpod/models/post/post.dart';
import 'package:assignment2_riverpod/utils/app_urls.dart';
import 'package:assignment2_riverpod/utils/status.dart';
import 'package:assignment2_riverpod/view_model/post/post_detail_view_model.dart';
import 'package:assignment2_riverpod/view_model/post/post_list_view_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Post List Screen",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Consumer(builder: (BuildContext context, WidgetRef ref, _) {
        AsyncValue<Either<List<Post>, Failure>> model =
            ref.watch(postListProviderVM);

        final status = ref.watch(postListStatusProvider);
        if (status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (status == Status.completed) {
          return model.value!.fold((left) {
            return ListView.separated(
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: left.length,
                itemBuilder: (ctx, index) {
                  Post _post = left[index];
                  return buildTile(context, _post, ref);
                });
          }, (right) => Center(child: Text(right.message)));
        }
        return const Text("Something went wrong from UI");
      }),
    );
  }

  Widget buildTile(BuildContext context, Post _post, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        //Method 1 , Detail Screen 1:
        ref.read(selectedPostIdProvider.notifier).state = _post.id;
        Navigator.pushNamed(context, AppUrls.detail);

        //Method 2 , Detail Screen 2 :
        // ref.read(postListVMProvider).selectedPostId = _post.id;
        // Navigator.pushNamed(context, AppUrls.detail2);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextRow(context, _post.id.toString(), "Post ID : "),
            const SizedBox(
              height: 8,
            ),
            _buildTextRow(context, _post.userId.toString(), "User ID : "),
            const SizedBox(
              height: 8,
            ),
            _buildTextRow(context, _post.title, "Title : "),
            const SizedBox(
              height: 8,
            ),
            _buildTextRow(context, _post.body, "Body : "),
          ],
        ),
      ),
    );
  }

  Row _buildTextRow(BuildContext context, String body, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Flexible(
          child: Text(body,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline3),
        ),
      ],
    );
  }
}
