class SigninRequestParams {
  final String phonNumber;
  final String password;

  SigninRequestParams({required this.phonNumber, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'phonNumber': phonNumber,
      'password': password,
    };
  } 
}