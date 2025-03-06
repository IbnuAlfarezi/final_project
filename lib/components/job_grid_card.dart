import 'package:final_project/models/job_model.dart';
import 'package:final_project/style/typography.dart';
import 'package:flutter/material.dart';

class JobGridCard extends StatelessWidget {
  final Job job;

  const JobGridCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 127,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(job.companyLogo, width: 41, height: 41),
              Icon(Icons.bookmark_border, color: Colors.grey),
            ],
          ),
          SizedBox(height: 12),
          Text(job.jobTitle, style: AppTextStyles.jobTittle.copyWith(color: Colors.black)),
          SizedBox(height: 4),
          Text("${job.companyName} - ${job.jobGeo}}", style: AppTextStyles.jobText.copyWith(color: Colors.grey)),
          SizedBox(height: 4),
          Text("${job.salaryCurrency} ${job.annualSalaryMin}-${job.annualSalaryMax}", style: AppTextStyles.jobText.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}