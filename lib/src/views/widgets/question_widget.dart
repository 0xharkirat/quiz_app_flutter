import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/src/models/question.dart';
import 'package:quiz_app_flutter/src/views/widgets/option_widget.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {super.key,
      required this.question,
      required this.userAnswer,
      required this.onAnswer});

  final Question question;
  final String? userAnswer;
  final void Function(String) onAnswer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 96,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 24.0),
                child: SelectableText(
                  question.question,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              // Options Container
              Column(
                mainAxisAlignment: MainAxisAlignment.center, // justify-center
                children: [
                  if (question.type == "multiple_choice")
                    Column(
                      children: question.options!
                          .asMap()
                          .entries
                          .map(
                            (entry) => OptionWidget(
                              text: entry.value,
                              letter: String.fromCharCode(
                                  65 + entry.key), // A, B, C, ...
                              isSelected: userAnswer == entry.value,
                              onTap: () => onAnswer(entry.value),
                            ),
                          )
                          .toList(),
                    )
                  else if (question.type == "true_false")
                    Column(
                      children: [
                        OptionWidget(
                          text: "True",
                          letter: "T",
                          isSelected: userAnswer == "true",
                          onTap: () => onAnswer("true"),
                        ),
                        // gap-y-6
                        OptionWidget(
                          text: "False",
                          letter: "F",
                          isSelected: userAnswer == "false",
                          onTap: () => onAnswer("false"),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
