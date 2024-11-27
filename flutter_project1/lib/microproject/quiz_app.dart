import 'package:flutter/material.dart';
import 'model/quiz.dart';
import 'model/submission.dart';
import 'screens/welcome_screen.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';

Color appColor = Colors.blue[500] as Color;

enum QuizState { notStarted, started, finished }

class QuizApp extends StatefulWidget {
  const QuizApp(this.quiz, {super.key});
  final Quiz quiz;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState quizState = QuizState.notStarted;
  int currentIndex = 0;
  Submission? submission;

  void startQuiz() {
    setState(() {
      quizState = QuizState.started;
      //store user's answer
      submission = Submission();
    });
  }

  void onTap(String select) {
    setState(() {
      submission!.answers.add(Answer(
          question: widget.quiz.questions[currentIndex],
          questionAnswer: select));
      if (currentIndex < widget.quiz.questions.length - 1) {
        currentIndex += 1;
      } else {
        quizState = QuizState.finished;
      }
    });
  }
  void restart() {
    setState(() {
      quizState = QuizState.started;
      currentIndex = 0;
      submission!.answers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: appColor,
        body: Center(
          child: Builder(builder: (BuildContext context) {
            switch (quizState) {
              case QuizState.notStarted:
                return WelcomeScreen(
                  startQuiz: startQuiz,
                  quizTitle: widget.quiz.title,
                );
              case QuizState.started:
                return QuestionScreen(
                  question: widget.quiz.questions,   
                  onTap: onTap, 
                  questionIndex: currentIndex, 
                  questions: widget.quiz.questions
                );
              case QuizState.finished:
                return ResultScreen(
                  quiz: widget.quiz,
                  submission: submission!,
                );
            }
          }),
        ),
      ),
    );
  }
}
