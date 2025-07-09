class Member {
  final String name;
  final String position;
  final String department;
  final String phone;
  final String email;
  final String image;
  final String description;
  final Map<String, String> social;

  Member({
    required this.name,
    required this.position,
    required this.department,
    required this.phone,
    required this.email,
    required this.image,
    required this.description,
    required this.social,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      position: json['position'],
      department: json['department'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      description: json['description'],
      social: Map<String, String>.from(json['social']),
    );
  }
}
