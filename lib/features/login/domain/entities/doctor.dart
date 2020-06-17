import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Doctor extends Equatable {
  final String name;
  final String crm;
  final String phone;
  final String email;
  final bool isActive;

  Doctor({
    this.name,
    @required this.crm,
    this.phone,
    @required this.email,
    @required this.isActive,
  });

  @override
  List<Object> get props => [name, crm, phone, email, isActive];
}