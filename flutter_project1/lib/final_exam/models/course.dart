class StudentScore {
  final String studentName;
  final double studentScore;
  StudentScore(this.studentScore, {required this.studentName});
}

class Course {
  final String courseName;
  final List<StudentScore> studentScores;
  Course({required this.courseName, required this.studentScores, required String name, required double score});
}
