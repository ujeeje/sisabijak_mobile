class ApiEndpoints {
  static const String baseUrl = "https://jefry-acmal-sisabijak.pws.cs.ui.ac.id";
  // Gunakan 10.0.2.2 jika melakukan pengetesan via Android Emulator ke localhost Django
  // static const String baseUrl = "http://10.0.2.2:8000";

  // Auth
  static const String login = "$baseUrl/login/";
  static const String register = "$baseUrl/register/";
  static const String logout = "$baseUrl/logout/";
  static const String accountProfile = "$baseUrl/account-profile/";

  // Catalog (api django rest framework)
  static const String catalogJson = "$baseUrl/catalog/json/";
  static const String catalogProducts = "$baseUrl/api/v1/catalog/products/";
  static String catalogProductDetail(String productId) => "$baseUrl/api/v1/catalog/products/$productId/";
  static String catalogReviews(String productId) => "$baseUrl/api/v1/catalog/products/$productId/reviews/";
  static String catalogReviewDetail(int reviewId) => "$baseUrl/api/v1/catalog/reviews/$reviewId/";

  // Merchant
  static const String merchantProducts = "$baseUrl/merchant/products/";

  // Orders
  static const String myOrders = "$baseUrl/orders/my-orders/";
  static const String merchantOrders = "$baseUrl/orders/merchant/";

  // Profile
  static const String profile = "$baseUrl/profile/";

  // Maps
  static const String maps = "$baseUrl/maps/";
}
