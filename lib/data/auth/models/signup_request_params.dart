class SignupRequestParams {
  final String phonNumber;
  final String username;
  final String password;

  SignupRequestParams({
    required this.username,
    required this.password,
    required this.phonNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phonNumber': phonNumber,
      'username': username,
      'password': password,
    };
  }
}
