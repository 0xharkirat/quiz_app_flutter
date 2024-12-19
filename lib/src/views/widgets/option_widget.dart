import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({super.key, required this.text, required this.letter, required this.isSelected, required this.onTap});

  final String text;
  final String letter;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(text),
      tileColor: isSelected ? Colors.deepPurple : Colors.grey,
      leading: CircleAvatar(
        backgroundColor: isSelected ? Colors.deepPurple : Colors.grey,
        child: Text(letter),
      ),
    );
  }
}
