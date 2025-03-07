import 'package:final_project/components/job_tag.dart';
import 'package:final_project/components/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:final_project/config/job_api.dart';
import 'package:final_project/models/job_model.dart';
import 'package:final_project/style/color_style.dart';
import 'package:final_project/style/typography.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Job? job;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJobDetails();
  }

  Future<void> fetchJobDetails() async {
    final arguments = Get.arguments as Map<String, dynamic>?;
    final int? jobId = arguments?['jobId'];

    if (jobId != null) {
      final jobApi = Provider.of<JobApi>(context, listen: false);
      await jobApi.fetchJobsByCategory("All"); // Pastikan data terbaru diambil
      setState(() {
        job = jobApi.jobs.firstWhereOrNull((j) => j.id == jobId);
        isLoading = false;
      });
    }
  }

  void showApplyPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("You have successfully applied for this job!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Detail", style: AppTextStyles.home),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : job == null
              ? Center(child: Text("Job Not Found"))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(job!.companyLogo, fit: BoxFit.cover, width: double.infinity, height: 278),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    child: Image.network(job!.companyLogo, width: 74,height: 74)),
                                  SizedBox(width: 10),
                                  Expanded( 
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job!.jobTitle,
                                          style: AppTextStyles.homeTittle,
                                          overflow: TextOverflow.ellipsis, 
                                          maxLines: 1, 
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${job!.companyName} - ${job!.jobGeo}",
                                          style: AppTextStyles.home,
                                          overflow: TextOverflow.ellipsis, 
                                          maxLines: 1,
                                        ),
                                        SizedBox(height: 9),
                                        Row(
                                          children: [
                                            JobTag(text: job!.jobType.join(", ")),
                                            SizedBox(width: 5),
                                            JobTag(text: job!.jobLevel),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            
                            SizedBox(height: 20),
                            ToggleTabBar(job: job!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: job == null
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  showApplyPopup();
                },
                child: Text("Apply Now", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
    );
  }
}
