class PersonalInformationModel {
  final String name;
  final String email;
  final String phone;
  final String country;

  const PersonalInformationModel({
    this.name = 'Jhon Doe',
    this.email = 'jhonatDoe26@gmail.com',
    this.phone = '123-456-789',
    this.country = 'Egypt',
  });
  
  static const empty = PersonalInformationModel();

  PersonalInformationModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? country,
  }) {
    return PersonalInformationModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'country': country,
    };
  }

  factory PersonalInformationModel.fromJson(Map<String, dynamic> json) {
    return PersonalInformationModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      country: json['country'] ?? '',
    );
  }

}