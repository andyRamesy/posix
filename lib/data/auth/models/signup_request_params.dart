class SignupRequestParams {
  final String username;
  final String password;

  SignupRequestParams({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }
}
