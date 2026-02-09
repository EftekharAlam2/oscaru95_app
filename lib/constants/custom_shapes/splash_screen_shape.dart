// import 'package:flutter/material.dart';

// // //Add this CustomPaint widget to the Widget Tree
// // CustomPaint(
// //     size: Size(WIDTH, (WIDTH*1.4223300970873787).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// //     painter: RPSCustomPainter(),
// // )

// //Copy this CustomPainter code to the Bottom of the File
// class RPSCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Path path_0 = Path();
//     path_0.moveTo(size.width * 0.4624345, size.height * 0.009038311);
//     path_0.cubicTo(
//         size.width * 0.2525898,
//         size.height * -0.04535700,
//         size.width * 0.04145073,
//         size.height * 0.1635432,
//         0,
//         size.height * 0.1635432);
//     path_0.lineTo(0, size.height);
//     path_0.lineTo(size.width, size.height);
//     path_0.lineTo(size.width, size.height * 0.009038328);
//     path_0.cubicTo(
//         size.width * 0.7720218,
//         size.height * 0.06167628,
//         size.width * 0.7215850,
//         size.height * 0.07621468,
//         size.width * 0.4624345,
//         size.height * 0.009038311);
//     path_0.close();

//     Paint paint0Fill = Paint()..style = PaintingStyle.fill;
//     paint0Fill.color = const Color(0xffFF6F43).withOpacity(0.05);
//     canvas.drawPath(path_0, paint0Fill);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
