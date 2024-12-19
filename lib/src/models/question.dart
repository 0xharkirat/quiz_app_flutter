class Question {

  final int id;
  final String question;
  final String type;
  final List<String>? options;
  final String correctAnswer;

  Question({
    required this.id,
    required this.question,
    required this.type,
    this.options,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      type: json['type'],
      options: json['options'] != null ? List<String>.from(json['options']) : null,
      correctAnswer: json['correctAnswer'],
    );
  }

}