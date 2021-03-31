import 'package:healthsup/core/error/failure.dart';
import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment_list.dart';
import 'package:healthsup/features/disease/domain/entities/pagination.dart';
import 'package:healthsup/features/patient/domain/entities/patient.dart';
import 'package:dartz/dartz.dart';

abstract class PatientRepository {
  Future<Either<Failure, Patient>> getPatientList();
  Future<Either<Failure, Patient>> registerPatient(Patient patient);
  Future<Either<Failure, Patient>> searchPatient(String registration);
  Future<Either<Failure, MedicalAppointmentList>> searchMedicalAppointment(
      int patientID, Pagination pagination);
}
