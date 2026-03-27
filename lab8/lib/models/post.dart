class Post {
  final int? userId;
  final int? id;
  final String title;
  final String body;

  Post({
    this.userId,
    this.id,
    required this.title,
    required this.body,
  });

  // Chuyển từ JSON sang Object (Xử lý an toàn dữ liệu null)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  // Chuyển từ Object sang JSON để gửi đi (POST)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'userId': userId ?? 1,
    };
  }
}
