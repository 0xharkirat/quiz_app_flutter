import 'package:flutter/material.dart';

class OptionWidget extends StatefulWidget {
  const OptionWidget({
    super.key,
    required this.text,
    required this.letter,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final String letter;
  final bool isSelected;
  final void Function() onTap;

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  bool _isHovring = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovring = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovring = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8), // Padding
        decoration: BoxDecoration(
          color: widget.isSelected
              ? Theme.of(context).colorScheme.inversePrimary
              : Theme.of(context).colorScheme.surface, // Background color
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Theme.of(context)
                  .colorScheme
                  .shadow
                  .withOpacity(0.2), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 2, // Blur radius
              offset: const Offset(0, 1), // Offset
            ),
          ],
          border: _isHovring
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 1)
              : null,
        ),
        child: ListTile(
          onTap: widget.onTap, // Handles the tap
          title: Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: widget.isSelected
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold // Text color
                ),
          ),
          leading: CircleAvatar(
            backgroundColor: widget.isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context)
                    .colorScheme
                    .inversePrimary, // Avatar background color
            child: Text(
              widget.letter,
              style: TextStyle(
                color: widget.isSelected
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context)
                        .colorScheme
                        .primary, // Avatar text color
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
