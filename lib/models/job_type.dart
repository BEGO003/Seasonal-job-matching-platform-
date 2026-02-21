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
        return 'Full Time';
      case JobType.partTime:
        return 'Part Time';
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

  String get apiValue {
    switch (this) {
      case JobType.fullTime:
        return 'FULL_TIME';
      case JobType.partTime:
        return 'PART_TIME';
      case JobType.freelance:
        return 'FREELANCE';
      case JobType.contract:
        return 'CONTRACT';
      case JobType.temporary:
        return 'TEMPORARY';
      case JobType.volunteer:
        return 'VOLUNTEER';
      case JobType.internship:
        return 'INTERNSHIP';
    }
  }
}
