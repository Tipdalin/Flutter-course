import 'package:flutter/material.dart';
import 'package:w3_s2_practice/microproject/model/quiz.dart';
import 'package:w3_s2_practice/microproject/model/submission.dart';
import 'package:w3_s2_practice/microproject/widgets/app_button.dart';


class ResultScreen extends StatelessWidget {
  final Quiz quiz;
  final Submission submission;
  final VoidCallback restart;

  const ResultScreen({
    super.key,
    required this.quiz,
    required this.submission,
    required this.restart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Your Score is ${submission.getScore()} out of ${quiz.questions.length} !",
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Column(
          children: [
            ...submission.answers.map((answer) => Column(
                  children: [
                    Text(
                      answer.question.title,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...answer.question.possibleAnswers
                            .map((possibleAnswer) => Column(
                                  children: [
                                    Text(
                                      possibleAnswer,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ))
                      ],
                    )
                  ],
                ))
          ],
        ),
        const SizedBox(height: 30),
        AppButton(
          "Restart the quiz",
          onTap: restart,
        )
      ],
    );
  }
}
