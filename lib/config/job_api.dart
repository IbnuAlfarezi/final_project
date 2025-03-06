import 'dart:convert';
import 'package:final_project/models/job_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JobApi extends ChangeNotifier {
  List<Job> _jobs = [];
  bool _isLoading = false;

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;

  final Map<String, String> _categoryUrls = {
    "All": "https://jobicy.com/api/v2/remote-jobs?count=10&geo=apac",
    "Data Science": "https://jobicy.com/api/v2/remote-jobs?count=10&geo=apac&industry=data-science",
    "Design": "https://jobicy.com/api/v2/remote-jobs?count=10&geo=apac&industry=design-multimedia",
    "Engineering": "https://jobicy.com/api/v2/remote-jobs?count=10&geo=apac&industry=engineering",
    "Dev Ops":"https://jobicy.com/api/v2/remote-jobs?count=10&geo=apac&industry=admin",
    "Business": "https://jobicy.com/api/v2/remote-jobs?count=10&geo=apac&industry=business",
  };

  String _selectedCategory = "All";

  String get selectedCategory => _selectedCategory;

  Future<void> fetchJobsByCategory(String category) async {
    _isLoading = true;
    notifyListeners();

    _selectedCategory = category;
    final url = Uri.parse(_categoryUrls[category] ?? _categoryUrls["All"]!);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jobList = jsonResponse["jobs"];
        _jobs = jobList.map((job) => Job.fromJson(job)).toList();
      } else {
        _jobs = [];
      }
    } catch (e) {
      _jobs = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Map<String, String> get categoryUrls => _categoryUrls;

}
