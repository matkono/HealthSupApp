import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Patient extends Equatable {
  final int id;
  final String name;
  final String registration;
  final String endereco;

  Patient({
    @required this.id,
    @required this.name,
    @required this.registration,
    @required this.endereco,
  });

  @override
  List<Object> get props => [id, name, registration, endereco];
}