class FileData {
  final String photoUrl;
  final String titleDealUrl;
  final String surveyorSearchUrl;
  final String propertyMapUrl;
  final List paid_users;

  FileData({
    required this.photoUrl,
    required this.titleDealUrl,
    required this.surveyorSearchUrl,
    required this.propertyMapUrl,
    required this.paid_users,
  });

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      photoUrl: json['photo_url'].toString(),
      titleDealUrl: json['title_deal_url'].toString(),
      surveyorSearchUrl: json['surveyor_search_url'].toString(),
      propertyMapUrl: json['property_map_url'].toString(),
      paid_users: json['paid_users'] != null ? List.from(json['paid_users']) : [], // Handle null case
    );
  }

}