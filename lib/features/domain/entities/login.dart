import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:mobilecache/features/data/models/doctor_model.dart';

class Login extends Equatable {
  final DoctorModel doctor;
  final bool success;
  final String error;

  Login({
    @required this.doctor,
    @required this.success,
    @required this.error,
  });

  @override
  List<Object> get props => [doctor, success, error];
}
