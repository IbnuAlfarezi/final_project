import 'package:final_project/components/bottom_bar.dart';
import 'package:final_project/components/job_card.dart';
import 'package:final_project/components/job_grid_card.dart';
import 'package:final_project/config/job_api.dart';
import 'package:final_project/models/job_model.dart';
import 'package:final_project/style/color_style.dart';
import 'package:final_project/style/typography.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Job> popularJobs = [];
  bool isPopularLoading = true;
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  User? user;

  @override
  void initState() {
    super.initState();
    fetchPopularJobs();
    getCurrentUser();
  }

  void getCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      user = auth.currentUser;
    });
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
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Hello,", style: AppTextStyles.home),
                          SizedBox(width: 10),
                          Text( user?.displayName ?? "User", style: AppTextStyles.home.copyWith(fontWeight: FontWeight.w600, color: Colors.black)),
                        ],
                      ),
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
                SizedBox(height: 22),
                Consumer<JobApi>(
                  builder: (context, viewModel, child) {
                    List<Job> filteredJobs = viewModel.jobs.where((job) {
                      return job.jobTitle.toLowerCase().contains(searchQuery.toLowerCase()) ||
                            job.jobLevel.toLowerCase().contains(searchQuery.toLowerCase());
                    }).toList();
                    
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
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
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed('/detail', arguments: {'jobId': job.id});
                                          },
                                          child: JobCard(job: job),
                                        );
                                      },
                                    ),
                        ),
                        SizedBox(height: 12),
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
                                  child: Text(category, 
                                  style: AppTextStyles.jobTittle.copyWith(color: viewModel.selectedCategory == category? Colors.white : Colors.white)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 22),
                        viewModel.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : filteredJobs.isEmpty
                                ? Center(child: Text("No jobs found"))
                                : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 0.85,
                                      ),
                                      itemCount: filteredJobs.length,
                                      itemBuilder: (context, index) {
                                        final job = filteredJobs[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed('/detail', arguments: {'jobId': job.id});
                                          },
                                          child: JobGridCard(job: job),
                                        );
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
          bottomNavigationBar: BottomBar(),
        ),
      ),
    );
  }
}