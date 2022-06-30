import 'dart:convert';

class PostDetail {
  PostDetail({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory PostDetail.fromJson(String str) =>
      PostDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PostDetail.fromMap(Map<String, dynamic> json) => PostDetail(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
