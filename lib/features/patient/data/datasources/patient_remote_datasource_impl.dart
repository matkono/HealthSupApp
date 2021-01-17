import 'package:healthsup/features/patient/data/models/cep_info_model.dart';
import 'package:healthsup/features/patient/data/models/patient_model.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:via_cep/via_cep.dart';

abstract class PatientRemoteDataSource {
  Future<PatientModel> listPatient();
  Future<PatientModel> registerPatient(Patient patient);
  Future<PatientModel> searchPatient(String registration);
  Future<CepInfoModel> viaCep(String cep);
}

class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  @override
  Future<PatientModel> listPatient() {
    throw UnimplementedError();
  }

  @override
  Future<PatientModel> registerPatient(Patient patient) {
    throw UnimplementedError();
  }

  @override
  Future<PatientModel> searchPatient(String registration) {
    throw UnimplementedError();
  }

  @override
  Future<CepInfoModel> viaCep(String cep) async {
    var viaCep = new via_cep();
    var result = await viaCep.searchCEP(cep, 'json', '');

    return CepInfoModel.fromJson(result);
  }
}
