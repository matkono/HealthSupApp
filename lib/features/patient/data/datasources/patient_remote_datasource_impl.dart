import 'package:healthsup/core/error/exception.dart';
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
    print(cep);
    await viaCep.searchCEP(cep, 'json', '');

    if (viaCep.getResponse() == 200) {
      final cepInfo = CepInfoModel(
        cep: viaCep.getCEP(),
        logradouro: viaCep.getLogradouro(),
        bairro: viaCep.getBairro(),
        localidade: viaCep.getLocalidade(),
      );
      return cepInfo;
    } else {
      print('Código de Retorno: ' + viaCep.getResponse().toString());
      print('Erro: ' + viaCep.getBody());
      throw ZipCodeException();
    }
  }
}
