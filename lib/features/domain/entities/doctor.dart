import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Doctor extends Equatable {
  final String name;
  final String crm;
  final String phone;
  final String email;
  final String status;

  Doctor({
    this.name,
    this.crm,
    this.phone,
    @required this.email,
    this.status,
  });

  @override
  List<Object> get props => [name, crm, phone, email, status];
}