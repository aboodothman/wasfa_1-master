import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainButton extends StatelessWidget {
  MainButton({
    required this.color,
    required this.title,
    required this.onTap,
    required this.style,
  });

  final Color? color;
  final String title;
  final VoidCallback? onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: GoogleFonts.raleway(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        height: 50,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black87),
          ],
          color: color
        ),
      ),
    );
  }
}
