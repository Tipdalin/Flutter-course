import 'package:flutter/material.dart';
import 'package:w3_s2_practice/microproject/widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen(
      {super.key, required this.startQuiz, required this.quizTitle});

  final VoidCallback startQuiz;
  final String quizTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Image.asset('assets/img/quiz-logo.png', height: 500, width: 500,),
          const SizedBox(height: 10),
          Text(
            quizTitle,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            
          ),
          const SizedBox(height: 30),
          AppButton(icon: Icons.arrow_right_alt,'Start Quiz', onTap: startQuiz),
          
      ],
    );      
  }
}
