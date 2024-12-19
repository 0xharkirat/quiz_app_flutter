import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/src/models/data/questions.dart';
import 'package:quiz_app_flutter/src/models/question.dart';
import 'package:quiz_app_flutter/src/views/widgets/navigation_widget.dart';
import 'package:quiz_app_flutter/src/views/widgets/question_widget.dart';
import 'package:quiz_app_flutter/src/views/widgets/score_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.isDarkMode,
    required this.toggleBrightness,
  });

  final bool isDarkMode;
  final void Function() toggleBrightness;

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
                widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: widget.toggleBrightness,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: widget.isDarkMode
                ? [
                    const Color(0xFF402843), // Deep Black-Grey (Starting Color)
                    const Color(0xFF112f60)
                  ]
                : [
                    const Color(0xFFFFEBFC), // Starting color
                    const Color(0xFFADC6FF),
                  ]
            // Ending color
            ,
            center: Alignment.center,
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      SelectableText(
                          'Question ${_currentQuestionIndex + 1} / ${questions.length}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              )),
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
