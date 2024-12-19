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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                backgroundColor:
                    Theme.of(context).colorScheme.onTertiaryContainer,
                foregroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer),
            onPressed: () => onNavigate(Direction.previous),
            child: const Text('Previous'),
          ),
        const Spacer(),
        if (currentQuestionIndex == totalQuestions - 1)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              disabledMouseCursor: SystemMouseCursors.forbidden,
            ),
            onPressed: userAnswer == null ? null : onSubmit,
            child: const Text('Submit'),
          )
        else
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              disabledMouseCursor: SystemMouseCursors.forbidden,
            ),
            onPressed:
                userAnswer == null ? null : () => onNavigate(Direction.next),
            child: const Text('Next'),
          ),
      ],
    );
  }
}
