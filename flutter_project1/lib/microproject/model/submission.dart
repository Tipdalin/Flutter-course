// ignore: unused_import
import 'package:flutter/material.dart';

import 'quiz.dart';

class Answer {
  final Question question;
  final String questionAnswer;

  Answer({required this.question, required this.questionAnswer});

//Check answer
  bool isCorrect() {
    return questionAnswer == question.goodAnswer;
  }
}

//Calculate
class Submission {
  List<Answer> answers = [];

  int getScore() {
    int score = 0;
    for (var answer in answers) {
      if (answer.isCorrect()) {
        score += 1;
      }
    }
    return score;
  }
}
//Retrieve answer
// Answer? getAnswerFor(Question question, answers) {
//   for (var answer in answers) {
//     if (answer.question == question) {
//       return answer;
//     }
//   }
//   return null;
// }

// add
void addAnswer(Question question, String answer, answers) {
  answers.add(Answer(question: question, questionAnswer: answer));
}

void removeAnswer(answers) {
  answers.remove();
}

// void main() {
//   Question q1 = const Question(
//       title: "Who is the best teacher?",
//       possibleAnswers: ["ronan", "hongly", 'leangsiv'],
//       goodAnswer: 'ronan');
//   Question q2 = const Question(
//       title: "Which color is the best?",
//       possibleAnswers: ["blue", "red", 'green'],
//       goodAnswer: 'red');

//List<Question> myQuestions = [q1, q2];

//   // Create a quiz
//   Quiz myQuiz = Quiz(title: "Crazy Quiz", questions: myQuestions);
//   print('Quiz Title: ${myQuiz.title}');
//   print('Number of Questions : ${myQuiz.questions.length}');
//   //Create a submission
//   Submission submission = Submission();

//   //Display score
//   print('Score ${submission.getScore()} ');

//   //retrieve
//   print('Answer ${submission.answers}');
// }
