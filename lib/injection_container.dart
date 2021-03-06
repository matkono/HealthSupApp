import 'package:healthsup/core/authentication/authentication.dart';
import 'package:healthsup/core/settings/settings.dart';
import 'package:healthsup/features/decision_tree/data/datasources/remote_datasource_impl.dart';
import 'package:healthsup/features/decision_tree/data/repositories/decision_tree_repository_impl.dart';
import 'package:healthsup/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:healthsup/features/decision_tree/domain/usecases/previous_question.dart';
import 'package:healthsup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:healthsup/features/login/data/datasources/local_datasource.dart';
import 'package:healthsup/features/login/data/datasources/remote_datasource.dart';
import 'package:healthsup/features/login/domain/repositories/repository.dart';
import 'package:healthsup/features/login/presentation/bloc/login_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:healthsup/features/patient/data/repositories/patient_repository_impl.dart';
import 'package:healthsup/features/patient/domain/repositories/patient_repository.dart';
import 'package:healthsup/features/patient/domain/usecases/list_patient.dart';
import 'package:healthsup/features/patient/domain/usecases/register_patient.dart';
import 'package:healthsup/features/patient/domain/usecases/search_patient.dart';
import 'package:healthsup/features/patient/domain/usecases/via_cep.dart';
import 'package:healthsup/features/patient/presentation/bloc/patient_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'features/decision_tree/data/datasources/local_datasource_impl.dart';
import 'features/decision_tree/domain/usecases/confirm_action.dart';
import 'features/decision_tree/domain/usecases/finish_appointment.dart';
import 'features/decision_tree/domain/usecases/get_current_node.dart';
import 'features/decision_tree/domain/usecases/send_answer.dart';
import 'features/decision_tree/domain/usecases/start_new_disease.dart';
import 'features/disease/data/datasources/disease_remote_datasource.dart';
import 'features/disease/data/repositories/disease_repository_impl.dart';
import 'features/disease/domain/repositories/disease_repository.dart';
import 'features/disease/domain/usecases/get_disease_list.dart';
import 'features/disease/presentation/bloc/disease_bloc.dart';
import 'features/login/data/repositories/repository_impl.dart';
import 'features/login/domain/usecases/login_user.dart';
import 'features/patient/data/datasources/patient_remote_datasource_impl.dart';

final sl = GetIt.instance;

Future<void> reset() async {
  sl.reset();
  await init();
}

Future<void> init() async {
  // Features
  _initDecisionTree();
  _initLogin();
  _initPatient();
  _initDisease();

  //Core
  sl.registerLazySingleton(() => Settings());
  sl.registerLazySingleton(() => AuthenticationSettings());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}

void _initDecisionTree() {
  // Bloc
  sl.registerFactory(
    () => DecisionTreeBloc(
      confirmAction: sl(),
      finishAppointment: sl(),
      getCurrentNode: sl(),
      previousQuestion: sl(),
      sendAnswer: sl(),
      startNewDisease: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => ConfirmAction(sl()));
  sl.registerLazySingleton(() => FinishAppointment(sl()));
  sl.registerLazySingleton(() => GetCurrentNode(sl()));
  sl.registerLazySingleton(() => PreviousQuestion(sl()));
  sl.registerLazySingleton(() => SendAnswer(sl()));
  sl.registerLazySingleton(() => StartNewDisease(sl()));

  // Repository
  sl.registerLazySingleton<DecisionTreeRepository>(
    () => DecisionTreeRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<DecisionTreeRemoteDataSource>(
    () => DecisionTreeRemoteDataSourceImpl(
      settings: sl(),
      authenticationSettings: sl(),
    ),
  );
  sl.registerLazySingleton<DecisionTreeLocalDataSource>(
    () => DecisionTreeLocalDataSourceImpl(),
  );
}

void _initLogin() {
  // Bloc
  sl.registerFactory(
    () => LoginBloc(
      loginUser: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      loginRemoteDataSource: sl(),
      loginLocalDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      settings: sl(),
      authenticationSettings: sl(),
    ),
  );
  sl.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(),
  );
}

void _initPatient() {
  // Bloc
  sl.registerFactory(
    () => PatientBloc(
      listPatient: sl(),
      registerPatient: sl(),
      searchPatient: sl(),
      viaCep: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => ListPatient(sl()));
  sl.registerLazySingleton(() => RegisterPatient(sl()));
  sl.registerLazySingleton(() => SearchPatient(sl()));
  sl.registerLazySingleton(() => ViaCep(sl()));

  // Repository
  sl.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(
      patientRemoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<PatientRemoteDataSource>(
    () => PatientRemoteDataSourceImpl(),
  );
}

void _initDisease() {
  // Bloc
  sl.registerFactory(
    () => DiseaseBloc(
      getDiseaseList: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetDiseaseList(sl()));

  // Repository
  sl.registerLazySingleton<DiseaseRepository>(
    () => DiseaseRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<DiseaseRemoteDataSource>(
    () => DiseaseRemoteDataSourceImpl(
      settings: sl(),
      authenticationSettings: sl(),
    ),
  );
}
