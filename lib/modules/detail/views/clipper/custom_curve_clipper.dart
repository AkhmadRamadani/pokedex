import 'package:flutter/material.dart';

class CustomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 120);
    path.quadraticBezierTo(
      size.width / 2, // Control point x (center)
      size.height, // Control point y (higher to make it pointier)
      size.width, // End point x (right edge)
      size.height - 120, // End point y (bottom minus curve height)
    );
    path.lineTo(size.width, 0); // Move to the top-right corner
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip unless the widget size changes
  }
}
