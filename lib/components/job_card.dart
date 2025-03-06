import 'package:final_project/components/job_tag.dart';
import 'package:final_project/models/job_model.dart';
import 'package:final_project/style/color_style.dart';
import 'package:final_project/style/typography.dart';
import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> jobTags = [job.jobLevel];

    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 6),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Mencegah overflow
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(job.companyLogo, width: 40, height: 40),
              Text("${job.salaryCurrency} ${job.annualSalaryMin}-${job.annualSalaryMax}",
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 6),
          Text(
            job.jobTitle,
            style: AppTextStyles.jobTittle
          ),
          SizedBox(height: 5),
          Text(
            "${job.companyName} - ${job.jobGeo}",
            style:AppTextStyles.jobText,
          ),
          SizedBox(height: 8),

          // Wrap digunakan agar tidak menyebabkan overflow
          Wrap(
            spacing: 8,
            children: jobTags.map((tag) => JobTag(text: tag)).toList(),
          ),
        ],
      ),
    );
  }
}
