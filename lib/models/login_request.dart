class LoginRequest {
  final String nis;
  final String password;

  LoginRequest({required this.nis, required this.password});

  Map<String, dynamic> toJson() => {
        'nis': nis,
        'password': password,
      };
}
