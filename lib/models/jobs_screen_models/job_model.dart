class JobModel {
  final int id;
  final String title;
  final String description;
  final String type;
  final String location;
  final String startDate;
  final String endDate;
  final double salary;
  final String status;
  final int numofpositions;
  final String workarrangement;
  final int jobposterId;
  final String jobposterName;

  const JobModel({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.type = '',
    this.location = '',
    this.startDate = '',
    this.endDate = '',
    this.salary = 0,
    this.status = '',
    this.numofpositions = 0,
    this.workarrangement = '',
    this.jobposterId = 0,
    this.jobposterName = '',
  });

  static const empty = JobModel();

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      location: json['location'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      salary: json['salary'] ?? 0,
      status: json['status'] ?? '',
      numofpositions: json['numofpositions'] ?? 0,
      workarrangement: json['workarrangement'] ?? '',
      jobposterId: json['jobposterId'] ?? 0,
      jobposterName: json['jobposterName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
      'salary': salary,
      'status': status,
      'numofpositions': numofpositions,
      'workarrangement': workarrangement,
      'jobposterId': jobposterId,
      'jobposterName': jobposterName,
    };
  }

  // CRITICAL: copyWith method for immutable updates
  JobModel copyWith({
    int? id,
    String? title,
    String? description,
    String? type,
    String? location,
    String? startDate,
    String? endDate,
    double? salary,
    String? status,
    int? numofpositions,
    String? workarrangement,
    int? jobposterId,
    String? jobposterName,
  }) {
    return JobModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      salary: salary ?? this.salary,
      status: status ?? this.status,
      numofpositions: numofpositions ?? this.numofpositions,
      workarrangement: workarrangement ?? this.workarrangement,
      jobposterId: jobposterId ?? this.jobposterId,
      jobposterName: jobposterName ?? this.jobposterName,
    );
  }

  // CRITICAL: Equality comparison for Riverpod
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is JobModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.type == type &&
        other.location == location &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.salary == salary &&
        other.status == status &&
        other.numofpositions == numofpositions &&
        other.workarrangement == workarrangement &&
        other.jobposterId == jobposterId &&
        other.jobposterName == jobposterName;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      type,
      location,
      startDate,
      endDate,
      salary,
      status,
      numofpositions,
      workarrangement,
      jobposterId,
      jobposterName,
    );
  }
}