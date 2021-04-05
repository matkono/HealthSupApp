import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UpdatePass extends Equatable {
  final String email;
  final String password;
  final String newPassword;
  final String confirmNewPassword;

  UpdatePass({
    @required this.email,
    @required this.password,
    @required this.newPassword,
    @required this.confirmNewPassword,
  });

  @override
  List<Object> get props => [email, password, newPassword, confirmNewPassword];
}
