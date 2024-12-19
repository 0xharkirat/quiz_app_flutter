import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/src/models/question.dart';
import 'package:quiz_app_flutter/src/views/widgets/option_widget.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({super.key, required this.question, required this.userAnswer, required this.onAnswer});

  final Question question;
  final String? userAnswer;
  final void Function(String) onAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          question.question,
          
        ),
        if (question.type == 'true_false')...[
          OptionWidget(text: "True", letter: "T", isSelected: userAnswer == "true", onTap: () => onAnswer("true")),
          OptionWidget(text: "False", letter: "F", isSelected: userAnswer == "false", onTap: () => onAnswer("false")),
        ] else ...[
          for (var i = 0; i < question.options!.length; i++)
            OptionWidget(
              text: question.options![i],
              letter: String.fromCharCode(65 + i),
              isSelected: userAnswer == question.options![i],
              onTap: () => onAnswer(question.options![i]),
            ),
        ],
      ],
    );
  }
}
