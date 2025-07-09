class Blog {
  final int? id;
  final String? name;
  final String? title;
  final String? thought;
  final String? blogType;
  final String? imageUrl;
  final String? date;

  Blog({
    required this.id,
    required this.name,
    required this.title,
    required this.thought,
    required this.blogType,
    required this.imageUrl,
    required this.date,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
    id: json['id'],
    name: json['name'] ?? '',
    title: json['title'] ?? '',
    thought: json['thought'] ?? '',
    blogType: json['blog_type'] ?? '',
    imageUrl: json['image'] ?? '',
    date: json['date'] ?? '',
    );
  }
}
