import 'package:assignment2_riverpod/models/failure/failure.dart';
import 'package:assignment2_riverpod/models/post/post.dart';
import 'package:assignment2_riverpod/utils/app_urls.dart';
import 'package:assignment2_riverpod/utils/status.dart';
import 'package:assignment2_riverpod/view_model/post/post_detail_view_model.dart';
import 'package:assignment2_riverpod/view_model/post/post_list_view_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListScreen3 extends ConsumerWidget {
  const PostListScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _postListVM = ref.read(postListVM);
    _postListVM.getPosts(ref);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Post List Screen 3",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Consumer(builder: (BuildContext context, WidgetRef ref, _) {
        final _postListVMProvider = ref.watch(postListVMProvider);

        final status = ref.watch(postListStatusProvider);
        if (_postListVMProvider.status == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_postListVMProvider.status == Status.completed) {
          return _postListVMProvider.either.fold((left) {
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
//Method 3 , Detail Screen 3:
        Navigator.pushNamed(context, AppUrls.detail3);
        ref.read(postDetailVM).getPostDetail(ref, _post.id);
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
