import 'package:final_project/style/color_style.dart';
import 'package:flutter/material.dart';

class JobTag extends StatelessWidget {
  final String text;

  const JobTag({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(color: AppColors.mainColor)),
    );
  }
}
