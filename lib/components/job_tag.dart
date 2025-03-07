import 'package:final_project/style/color_style.dart';
import 'package:final_project/style/typography.dart';
import 'package:flutter/material.dart';

class JobTag extends StatelessWidget {
  final String text;

  const JobTag({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: AppColors.mainColor, 
        borderRadius: BorderRadius.circular(5), 
      ),
      child: Text(
        text,
        style: AppTextStyles.jobTittle
      ),
    );
  }
}
