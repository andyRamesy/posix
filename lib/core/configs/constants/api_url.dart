class ApiUrl {
  //base URL and API version
  static const String baseUrl = 'http://192.168.1.154:3000/';
  static const String apiVersion = 'api/v1';

  //Auth endpoints
  static const String signup = 'auth/signup';
  static const String signin = 'auth/login';

  //Map URLs
  static const String tileLayerUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  //Friend invit
  static const String sendInvitation = 'friend-request/add-by-phon';
}