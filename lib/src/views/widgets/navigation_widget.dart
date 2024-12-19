import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/src/views/screens/my_home_page.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget(
      {super.key,
      required this.currentQuestionIndex,
      required this.totalQuestions,
      required this.userAnswer,
      required this.onSubmit,
      required this.onNavigate});

  final int currentQuestionIndex;
  final int totalQuestions;
  final String? userAnswer;
  final void Function() onSubmit;
  final void Function(Direction) onNavigate;

  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        if (currentQuestionIndex > 0)
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => onNavigate(Direction.previous),
          ),
        const Spacer(),
        if (currentQuestionIndex == totalQuestions - 1)
          ElevatedButton(
            onPressed: onSubmit,
            child: const Text('Submit'),
          )
        else
          ElevatedButton(
            onPressed:
                userAnswer == null ? null : () => onNavigate(Direction.next),
            child: const Text('Next'),
          ),
      ],
    );
  }
}
