import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/src/models/question.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.onRetakeQuiz,
    required this.userAnswers,
    required this.questions,
  });

  final int score;
  final int totalQuestions;
  final void Function() onRetakeQuiz;
  final List<String?> userAnswers;
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    final incorrectQuestions = questions.asMap().entries.where((entry) {
      final index = entry.key;
      final question = entry.value;
      return userAnswers[index] != question.correctAnswer;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Heading
          Text(
            'Your Score',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary, // Primary color
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Circular Progress Bar
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                    value: score / questions.length,
                    strokeWidth: 15,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary), // Primary color
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .tertiary
                        .withOpacity(0.8), // Tertiary container
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Wrong: ${totalQuestions - score}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      'Right: $score',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Retake Quiz Button
          ElevatedButton(
            onPressed: onRetakeQuiz,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor:
                  Theme.of(context).colorScheme.onPrimary, // Primary color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Retake Quiz',
            ),
          ),
          const SizedBox(height: 16),

          // Incorrect Questions Section
          if (incorrectQuestions.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Incorrect Answers:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                for (var entry in incorrectQuestions)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary, // Light background for incorrect answers
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .shadow
                              .withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Q: ${entry.value.question}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your Answer: ${userAnswers[entry.key] ?? "No Answer"}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.error),
                        ),
                        Text(
                          'Correct Answer: ${entry.value.correctAnswer}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
