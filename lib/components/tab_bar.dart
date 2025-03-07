import 'package:flutter/material.dart';
import 'package:final_project/models/job_model.dart';

class ToggleTabBar extends StatefulWidget {
  final Job job; // Tambahkan parameter job

  const ToggleTabBar({Key? key, required this.job}) : super(key: key);

  @override
  _ToggleTabBarState createState() => _ToggleTabBarState();
}

class _ToggleTabBarState extends State<ToggleTabBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Switcher
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildTabButton("Description", 0),
              _buildTabButton("Company", 1),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Isi Konten Berdasarkan Tab
        IndexedStack(
          index: _selectedIndex,
          children: [
            _buildDescriptionContent(widget.job), // Ambil deskripsi dari job
            _buildCompanyContent(widget.job),
          ],
        ),
      ],
    );
  }

  // Widget untuk Tab Button
  Widget _buildTabButton(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black26, blurRadius: 3, offset: Offset(0, 2))]
                : [],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Konten Deskripsi
  Widget _buildDescriptionContent(Job job) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Requirements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...[
            job.jobType.join(", "), // Gabungkan jobType menjadi satu string
            job.jobLevel, 
            job.jobGeo,
          ].map((req) => _buildRequirementItem(req)).toList(),
          const SizedBox(height: 8),
          Text("Job Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(
            job.jobDescription, // Ambil deskripsi dari job
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          
        
        ],
      ),
    );
  }

  // Konten Company
  Widget _buildCompanyContent(Job job) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About Company", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            job.jobExcerpt, // Ambil deskripsi perusahaan dari job
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Text("Company Link", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            job.url, // Jika ada informasi tentang budaya perusahaan
            style: TextStyle(fontSize: 14, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  // Widget untuk Item Requirement
  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
