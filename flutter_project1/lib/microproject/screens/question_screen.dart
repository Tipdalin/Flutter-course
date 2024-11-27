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
      children: [Text(
        question[questionIndex].title,
        style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 30),
      Column(children: [
       
          
        
      ],)
      ],
      
    );
  }
}
