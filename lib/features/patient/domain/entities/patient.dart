import 'package:equatable/equatable.dart';
import 'package:healthsup/features/patient/domain/entities/cep_info.dart';
import 'package:meta/meta.dart';

class Patient extends Equatable {
  final int id;
  final String name;
  final String registration;
  CepInfo addressInfo;

  Patient({
    @required this.id,
    @required this.name,
    @required this.registration,
    @required this.addressInfo,
  });

  @override
  List<Object> get props => [id, name, registration, addressInfo];
}
