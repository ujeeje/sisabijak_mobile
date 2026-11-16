class ApiEndpoints {
  static const String baseUrl = "https://jefry-acmal-sisabijak.pws.cs.ui.ac.id";
  // Gunakan 10.0.2.2 jika melakukan pengetesan via Android Emulator ke localhost Django
  // static const String baseUrl = "http://10.0.2.2:8000";

  // Auth
  static const String login = "$baseUrl/login/";
  static const String register = "$baseUrl/register/";
  static const String logout = "$baseUrl/logout/";
  static const String accountProfile = "$baseUrl/account-profile/";

  // Catalog
  static const String catalogJson = "$baseUrl/catalog/json/";

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
