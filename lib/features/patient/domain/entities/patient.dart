import 'package:equatable/equatable.dart';
import 'package:healthsup/features/registration/domain/entities/cep_info.dart';
import 'package:meta/meta.dart';

class Patient extends Equatable {
  final int id;
  final String name;
  final String registration;
  CepInfo address;

  Patient({
    @required this.id,
    @required this.name,
    @required this.registration,
    this.address,
  });

  @override
  List<Object> get props => [id, name, registration, address];
}
