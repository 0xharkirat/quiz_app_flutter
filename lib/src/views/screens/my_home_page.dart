import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/src/models/data/questions.dart';
import 'package:quiz_app_flutter/src/models/question.dart';
import 'package:quiz_app_flutter/src/views/widgets/navigation_widget.dart';
import 'package:quiz_app_flutter/src/views/widgets/question_widget.dart';
import 'package:quiz_app_flutter/src/views/widgets/score_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentQuestionIndex = 0;
  Question? _currentQuestion = Question.fromJson(questions[0]);

  final _userAnswers = List<String?>.filled(questions.length, null);

  int _score = 0;
  bool _showWarning = true; // show warning only once

  int _consecutiveIncorrectAnswers = 0;

  bool _showCustomAlert = false;

  bool _isQuizSubmitted = false;

  void _handleRetakeQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _currentQuestion = Question.fromJson(questions[0]);
      _userAnswers.fillRange(0, questions.length, null);
      _score = 0;
      _consecutiveIncorrectAnswers = 0;
      _showCustomAlert = false;
      _isQuizSubmitted = false;
    });
  }

  void _handleAnswer(String answer) {
    final isCorrect = _currentQuestion!.correctAnswer == answer;

    if (isCorrect) {
      _consecutiveIncorrectAnswers = 0;
      if (_userAnswers[_currentQuestionIndex] !=
          _currentQuestion!.correctAnswer) {
        _score += 1;
      }
    } else {
      _consecutiveIncorrectAnswers += 1;
      if (_userAnswers[_currentQuestionIndex] ==
          _currentQuestion!.correctAnswer) {
        _score -= 1;
      }
    }

    _userAnswers[_currentQuestionIndex] = answer;

    setState(() {});
  }

  void _handleNavigation(Direction direction) {
    if (_showWarning && _consecutiveIncorrectAnswers >= 2) {
      _showCustomAlert = true;
      _showWarning = false;
    }

    if (direction == Direction.next &&
        _currentQuestionIndex < questions.length - 1) {
      _currentQuestionIndex += 1;
      _currentQuestion = Question.fromJson(questions[_currentQuestionIndex]);
    } else if (direction == Direction.previous && _currentQuestionIndex > 0) {
      _currentQuestionIndex -= 1;
      _currentQuestion = Question.fromJson(questions[_currentQuestionIndex]);
    }

    setState(() {});
  }

  void _handleSubmitQuiz() {
    if (_showWarning && _consecutiveIncorrectAnswers >= 2) {
      setState(() {
        _showCustomAlert = true;
        _showWarning = false;
      });
      return;
    }

    setState(() {
      _isQuizSubmitted = true;
    });
  }

  void _closeAlert() {
    setState(() {
      _showCustomAlert = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (_isQuizSubmitted)
                ScoreWidget(
                    score: _score,
                    totalQuestions: questions.length,
                    onRetakeQuiz: _handleRetakeQuiz,
                    userAnswers: _userAnswers,
                    questions: List.generate(questions.length,
                        (i) => Question.fromJson(questions[i])))
              else ...[
                Text(
                  'Question ${_currentQuestionIndex + 1} / ${questions.length}',
                ),
                const SizedBox(height: 16),
                QuestionWidget(
                  question: _currentQuestion!,
                  userAnswer: _userAnswers[_currentQuestionIndex],
                  onAnswer: _handleAnswer,
                ),
                const SizedBox(height: 16),
                NavigationWidget(
                  userAnswer: _userAnswers[_currentQuestionIndex],
                  currentQuestionIndex: _currentQuestionIndex,
                  totalQuestions: questions.length,
                  onSubmit: _handleSubmitQuiz,
                  onNavigate: _handleNavigation,
                ),
               
              ]
            ],
          ),
        ),
      ),
    );
  }
}

enum Direction {
  next,
  previous,
}
