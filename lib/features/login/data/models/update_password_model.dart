import 'package:healthsup/features/login/domain/entities/update_pass.dart';
import 'package:meta/meta.dart';

class UpdatePasswordModel extends UpdatePass {
  UpdatePasswordModel({
    @required String email,
    @required String password,
    @required String newPassword,
    @required String confirmNewPassword,
  }) : super(
          email: email,
          password: password,
          newPassword: newPassword,
          confirmNewPassword: confirmNewPassword,
        );

  factory UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordModel(
      email: json['email'],
      password: json['password'],
      newPassword: json['newPassword'],
      confirmNewPassword: json['confirmNewPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }
}
