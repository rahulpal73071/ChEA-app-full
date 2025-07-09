class Blog {
  final int id;
  final String name;
  final String title;
  final String thought;
  final String blogType;
  final String imageUrl;
  final String date;

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

class Opportunity {
  final int id;
  final String title;
  final String stipend;
  final String location;
  final String lastDateOfApply;
  final String description;
  final String domain;
  final String role;
  final String opportunityType;

  Opportunity({
    required this.id,
    required this.title,
    required this.stipend,
    required this.location,
    required this.lastDateOfApply,
    required this.description,
    required this.domain,
    required this.role,
    required this.opportunityType,
  });

  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
      id: json['id'],
      title: json['title'],
      stipend: json['stipend'],
      location: json['location'],
      lastDateOfApply: json['lastDateOfApply'],
      description: json['description'],
      domain: json['domain'],
      role: json['role'],
      opportunityType: json['OpportunityType'],
    );
  }
}
