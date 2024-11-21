import 'quiz.dart';

class Answer {
  bool isCorrect = true;

  Answer({required this.isCorrect});
}

abstract class Submission {
  final  int getScore();
  Answer? getAnswerFor(Question question);
}
