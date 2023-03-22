import 'package:flutter/material.dart';

class LabelHeading extends StatelessWidget {
  final String label;
  const LabelHeading({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: SizedBox(
          height: 24,
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}
