class CommentModel {
  String commentId;
  String content;
  String userId;
  String userName;
  String profileAvatar;
  DateTime? createdAt;

  CommentModel({
    required this.commentId,
    required this.content,
    required this.userId,
    required this.userName,
    required this.profileAvatar,
    this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['comment_id'],
      content: json['content'] ?? "",
      userId: json['user_id'],
      userName: json['user_name'] ?? "",
      profileAvatar: json['profile_avatar'] ?? "",
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }
}
