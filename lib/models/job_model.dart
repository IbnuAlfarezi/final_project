class Job {
  int id;
  String jobSlug;
  String url;
  String jobTitle;
  String companyName;
  String companyLogo;
  List<String> jobIndustry;
  List<String> jobType;
  String jobGeo;
  String jobLevel;
  String jobExcerpt;
  String jobDescription;
  String pubDate;
  int annualSalaryMin;
  int annualSalaryMax;
  String salaryCurrency;

  Job({
    required this.id,
    required this.url,
    required this.jobSlug,
    required this.jobTitle,
    required this.companyName,
    required this.companyLogo,
    required this.jobIndustry,
    required this.jobType,
    required this.jobGeo,
    required this.jobLevel,
    required this.jobExcerpt,
    required this.jobDescription,
    required this.pubDate,
    required this.annualSalaryMin,
    required this.annualSalaryMax,
    required this.salaryCurrency,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      url : json['url'],
      jobSlug: json['jobSlug'],
      jobTitle: json['jobTitle'],
      companyName: json['companyName'],
      companyLogo: json['companyLogo'],
      jobIndustry: List<String>.from(json['jobIndustry'] ?? []),
      jobType: List<String>.from(json['jobType'] ?? []),
      jobGeo: json['jobGeo'],
      jobLevel: json['jobLevel'],
      jobExcerpt: json['jobExcerpt'],
      jobDescription: json['jobDescription'],
      pubDate: json['pubDate'],
      annualSalaryMin: json['annualSalaryMin'] ?? 0,
      annualSalaryMax: json['annualSalaryMax'] ?? 0,
      salaryCurrency: json['salaryCurrency'] ?? "USD",
    );
  }
}
