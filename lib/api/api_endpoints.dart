class ApiEndpoints {
  static const String baseUrl = 'http://depiapi.depi.co.ke/depiapi/api.php?method='; // Replace this with your API base URL
  // static const String baseUrl = 'http://192.168.43.105/depiapi/api.php?method='; // Replace this with your API base URL
  static const String signUpUrl = baseUrl+'signup';
  static const String loginUrl = baseUrl+'login';
  static const String addPropertyUrl = baseUrl+'create_post';
  static const String getPropertyUrl = baseUrl+'get_posts';
  static const String getPropertyByUserIdUrl = baseUrl+'get_posts_by_user_id';
  static const String getPropertyByCategoryNameUrl = baseUrl+'get_posts_by_category_name';
  static const String getPropertyBySearchKeyUrl = baseUrl+'search';
  static const String upload_url = 'http://depiapi.depi.co.ke/depiapi/uploads/';
}
