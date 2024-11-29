import 'package:flutter/material.dart';
import 'package:w3_s2_practice/microproject/model/quiz.dart';

class QuestionScreen extends StatelessWidget {
  final List<Question> question;
  final void Function(String selected) onTap;
  final int questionIndex;

  const QuestionScreen({
    super.key,
    required List<Question> questions,
    required this.question,
    required this.onTap, required this.questionIndex,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
        question[questionIndex].title,
        style: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 30),
      Column(children: [
        ...question[questionIndex].possibleAnswers.map((answer) => SizedBox(
          width: 200,
          child:  Padding(padding: const EdgeInsets.all(20),
          child: ElevatedButton(onPressed: () => onTap(answer), 
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        child: Text(
          answer,
          style: const TextStyle(
            color: Colors.blue
        )),
        ),
        )),
        )
      ]),
      ],
      );
    
  }
}
