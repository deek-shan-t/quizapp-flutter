class FeaturedMember {
  final int id;
  final String name;
  final String position;
  final String contact;

  FeaturedMember({
    required this.id,
    required this.name,
    required this.position,
    required this.contact,
  });

  factory FeaturedMember.fromJson(Map<String, dynamic> json) {
    return FeaturedMember(
      id: json['id'] as int,
      name: json['name'] as String,
      position: json['position'] as String,
      contact: json['contact'] as String,
    );
  }
}
