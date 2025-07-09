class Publication {
  final String id;
  final String name;
  final String image;
  final String url;
  final String type;
  final int pages;
  final String description;
  final String publishDate;
  final String category;

  Publication({
    required this.id,
    required this.name,
    required this.image,
    required this.url,
    required this.type,
    required this.pages,
    required this.description,
    required this.publishDate,
    required this.category,
  });

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      url: json['url'],
      type: json['type'],
      pages: json['pages'],
      description: json['description'],
      publishDate: json['publishDate'],
      category: json['category'],
    );
  }
}
