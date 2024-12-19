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
    final double progress = score / totalQuestions;

    // Filter incorrect questions
    final incorrectQuestions = questions.asMap().entries.where((entry) {
      final index = entry.key;
      final question = entry.value;
      return userAnswers[index] != question.correctAnswer;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(
                    value: progress,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                    backgroundColor: Colors.grey,
                    strokeWidth: 12,
                  ),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetakeQuiz,
            child: const Text('Retake Quiz'),
          ),
          const SizedBox(height: 16),
          if (incorrectQuestions.isNotEmpty)
            const Text(
              'Review Incorrect Questions:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          const SizedBox(height: 8),
          for (var entry in incorrectQuestions)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Q: ${entry.value.question}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your Answer: ${userAnswers[entry.key] ?? "No Answer"}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
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
            ),
        ],
      ),
    );
  }
}
