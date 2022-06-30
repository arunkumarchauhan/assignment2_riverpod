import 'package:assignment2_riverpod/utils/status.dart';
import 'package:assignment2_riverpod/view_model/post/post_detail_view_model.dart';
import 'package:assignment2_riverpod/view_model/post/post_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailScreen2 extends ConsumerWidget {
  const PostDetailScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Post Detail Screen 2",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: ref
            .watch(postDetailResponseProvider(
                ref.read(postListVMProvider).selectedPostId))
            .when(
              data: (data) {
                if (data.status == Status.completed) {
                  return data.either.fold((left) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.lightGreen,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ..._buildItem(
                                context, left.id.toString(), "Post ID : "),
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
                return CircularProgressIndicator();
              },
              error: (error, stackTrace) => Center(
                child: Text("${error.toString()}  ${stackTrace.toString()}"),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
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
