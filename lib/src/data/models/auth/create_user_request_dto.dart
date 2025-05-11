class CreateUserRequestDto {
  final String uid;
  final String email;

  CreateUserRequestDto({
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid, //토큰
      'email': email,
    };
  }
}
