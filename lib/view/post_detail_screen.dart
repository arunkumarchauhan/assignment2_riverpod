import 'package:assignment2_riverpod/models/failure/failure.dart';
import 'package:assignment2_riverpod/models/post/post_detail.dart';
import 'package:assignment2_riverpod/utils/status.dart';
import 'package:assignment2_riverpod/view_model/post/post_detail_view_model.dart';
import 'package:assignment2_riverpod/view_model/post/post_list_view_model.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Detail Screen",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          final status = ref.watch(postDetailStatusProvider);
          final AsyncValue<Either<PostDetail, Failure>> _post =
              ref.read(postDetailProviderVM(ref.read(selectedPostIdProvider)));

          if (status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (status == Status.completed) {
            return _post.value!.fold((left) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.lightGreen,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._buildItem(context, left.id.toString(), "Post ID : "),
                      ..._buildItem(
                          context, left.userId.toString(), "User ID : "),
                      ..._buildItem(context, left.title, "Title : "),
                      ..._buildItem(context, left.body, "Description : "),
                    ],
                  ),
                ),
              );
            },
                (right) => Center(
                      child: Text(right.message),
                    ));
          }

          return const Center(child: Text("Something Went Wrong In UI "));
        },
      ),
    );
  }

  List<Widget> _buildItem(BuildContext context, String body, String title) {
    return [
      const SizedBox(
        height: 10,
      ),
      Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        body,
        style: Theme.of(context).textTheme.headline3,
      ),
      const SizedBox(
        height: 10,
      ),
    ];
  }
}
