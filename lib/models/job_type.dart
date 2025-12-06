enum JobType {
  fullTime,
  partTime,
  freelance,
  contract,
  temporary,
  volunteer,
  internship,
}

extension JobTypeExtension on JobType {
  String get label {
    switch (this) {
      case JobType.fullTime:
        return 'Full_time';
      case JobType.partTime:
        return 'Part_time';
      case JobType.freelance:
        return 'Freelance';
      case JobType.contract:
        return 'Contract';
      case JobType.temporary:
        return 'Temporary';
      case JobType.volunteer:
        return 'Volunteer';
      case JobType.internship:
        return 'Internship';
    }
  }
}
