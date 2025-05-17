class ApiUrl {
  static const String baseUrl = 'http://192.168.1.154:3000/';
  static const String apiVersion = 'api/v1';
  static const String signup = '$apiVersion/auth/signup';
  static const String signin = '$apiVersion/auth/login';
  static const String tileLayerUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
}