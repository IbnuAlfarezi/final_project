import 'package:final_project/components/job_card.dart';
import 'package:final_project/components/job_grid_card.dart';
import 'package:final_project/config/job_api.dart';
import 'package:final_project/models/job_model.dart';
import 'package:final_project/style/color_style.dart';
import 'package:final_project/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Job> popularJobs = [];
  bool isPopularLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPopularJobs();
  }

  Future<void> fetchPopularJobs() async {
    final jobApi = JobApi();
    await jobApi.fetchJobsByCategory("All");
    setState(() {
      popularJobs = jobApi.jobs;
      isPopularLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JobApi()..fetchJobsByCategory("All"),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Hello,", style: AppTextStyles.home),
                          
                          Text("Nama", style: AppTextStyles.home.copyWith(fontWeight: FontWeight.w600, color: Colors.black)),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          Text("Find Your Great Job", style: AppTextStyles.homeTittle),
                          Spacer(),
                          CircleAvatar(),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36),
                Consumer<JobApi>(
                  builder: (context, viewModel, child) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search a Job",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 22),
                        Text("Most Popular", style: AppTextStyles.homeTittle.copyWith(color: Colors.black)),
                        SizedBox(height: 12),
                        SizedBox(
                          height: 190,
                          child: isPopularLoading
                              ? Center(child: CircularProgressIndicator())
                              : popularJobs.isEmpty
                                  ? Center(child: Text("No jobs found"))
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: popularJobs.length,
                                      itemBuilder: (context, index) {
                                        final job = popularJobs[index];
                                        return JobCard(job: job);
                                      },
                                    ),
                        ),

                        // Caregory
                        SizedBox(height: 22),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: viewModel.categoryUrls.keys.map((category) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewModel.fetchJobsByCategory(category);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: viewModel.selectedCategory == category ? AppColors.mainColor : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(category, style: TextStyle(color: Colors.white)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 17),
                        viewModel.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : viewModel.jobs.isEmpty
                                ? Center(child: Text("No jobs found"))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // 2 cards per row
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 0.9,
                                      ),
                                      itemCount: viewModel.jobs.length,
                                      itemBuilder: (context, index) {
                                        final job = viewModel.jobs[index];
                                        return JobGridCard(job: job);
                                      },
                                    ),
                                  ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}