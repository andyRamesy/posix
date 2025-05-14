class ApiUrl {
  static const String baseUrl = 'http://10.13.104.222:3000/';
  static const String apiVersion = 'api/v1';
  static const String signup = '$apiVersion/auth/signup';
  static const String signin = '$apiVersion/auth/login';
  static const String tileLayerUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
}