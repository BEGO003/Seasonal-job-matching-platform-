class PersonalInformationModel {
  final String name;
  final String email;
  final String number;
  final String country;

  const PersonalInformationModel({
    this.name = 'Jhon Doe',
    this.email = 'jhonatDoe26@gmail.com',
    this.number = '123-456-789',
    this.country = 'Egypt',
  });
  
  static const empty = PersonalInformationModel();

  PersonalInformationModel copyWith({
    String? name,
    String? email,
    String? number,
    String? country,
  }) {
    return PersonalInformationModel(
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
      'country': country,
    };
  }

  factory PersonalInformationModel.fromJson(Map<String, dynamic> json) {
    return PersonalInformationModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      number: json['number'] ?? '',
      country: json['country'] ?? '',
    );
  }

}