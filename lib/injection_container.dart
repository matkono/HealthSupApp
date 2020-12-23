import 'package:HealthSup/core/authentication/authentication.dart';
import 'package:HealthSup/core/settings/settings.dart';
import 'package:HealthSup/features/decision_tree/data/datasources/remote_datasource_impl.dart';
import 'package:HealthSup/features/decision_tree/data/repositories/decision_tree_repository_impl.dart';
import 'package:HealthSup/features/decision_tree/domain/repositories/decision_tree_repository.dart';
import 'package:HealthSup/features/decision_tree/domain/usecases/previous_question.dart';
import 'package:HealthSup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:HealthSup/features/login/data/datasources/local_datasource.dart';
import 'package:HealthSup/features/login/data/datasources/remote_datasource.dart';
import 'package:HealthSup/features/login/domain/repositories/repository.dart';
import 'package:HealthSup/features/login/presentation/bloc/login_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'features/decision_tree/data/datasources/local_datasource_impl.dart';
import 'features/decision_tree/domain/usecases/confirm_action.dart';
import 'features/decision_tree/domain/usecases/finish_appointment.dart';
import 'features/decision_tree/domain/usecases/get_current_node.dart';
import 'features/decision_tree/domain/usecases/send_answer.dart';
import 'features/decision_tree/domain/usecases/start_medical_appointment.dart';
import 'features/login/data/repositories/repository_impl.dart';
import 'features/login/domain/usecases/login_user.dart';

final sl = GetIt.instance;

Future<void> reset() async {
  sl.reset();
  await init();
}

Future<void> init() async {
  // Features
  _initDecisionTree();
  _initLogin();

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
      startMedicalAppointment: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => ConfirmAction(sl()));
  sl.registerLazySingleton(() => FinishAppointment(sl()));
  sl.registerLazySingleton(() => GetCurrentNode(sl()));
  sl.registerLazySingleton(() => PreviousQuestion(sl()));
  sl.registerLazySingleton(() => SendAnswer(sl()));
  sl.registerLazySingleton(() => StartMedicalAppointment(sl()));

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
