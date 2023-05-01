import 'package:flutter/material.dart';

class WidthSpacing extends StatelessWidget {
  const WidthSpacing(this.amount, {super.key});
  final double amount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: amount);
  }
}

class HeightSpacing extends StatelessWidget {
  const HeightSpacing(this.amount, {super.key});
  final double amount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: amount);
  }
}