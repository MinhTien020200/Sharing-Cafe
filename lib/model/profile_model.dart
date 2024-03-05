class ProfileModel {
  final String image;
  final String name;
  final String? description;
  final int age;

  ProfileModel({
    required this.image,
    required this.name,
    this.description,
    required this.age,
  });
}
