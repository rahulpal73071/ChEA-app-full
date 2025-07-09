class Facad {
  final String name;
  final String image;
  final String email;
  final String phone;
  final String url;
  final String roll;
  final String department;
  
  final String position;

  Facad({
    required this.name,
    required this.image,
    required this.email,
    required this.phone,
    required this.url,
    required this.roll,
    required this.department,
    
    required this.position,
  });

  factory Facad.fromJson(Map<String, dynamic> json) {
    return Facad(
      name: json['name'],
      image: json['image'],
      email: json['email'],
      phone: json['phone'],
      url: json['url'],
      roll: json['roll'],
      department: json['department'],
      position: json['position'],
    );
  }
}
