import 'package:mary/features/home/data/models/patient_model.dart';

abstract class HomeRepository {
  Future<List<Patient>> getPatients();
  Future<void> setPatient(Patient patient);
  Future<void> updatePatient(Patient patient);
  Future<Patient?> getPatientById(int id);
  Future<bool> deletePatient(int id);
}
