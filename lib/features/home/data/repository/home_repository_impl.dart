import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mary/features/home/data/exceptions/patient_exception.dart';
import 'package:mary/features/home/data/repository/home_repository.dart';

import '../models/models.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<bool> deletePatient(int id) async {
    bool isDelete = false;
    try {
      final userRef = FirebaseFirestore.instance
          .collection('patients')
          .doc(id.toString())
          .withConverter<Patient>(
            fromFirestore: (snapshots, _) =>
                Patient.fromJson(snapshots.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

      await userRef.delete().whenComplete(() => isDelete = true);
      return isDelete;
    } catch (e) {
      log(e.toString());
      throw PatientFailture(e.toString());
    }
  }

  @override
  Future<Patient?> getPatientById(String id) async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection('patients').doc("P$id");

      final patient = await userRef.get();

      return Patient.fromJson(patient.data()!);
    } catch (e) {
      log(e.toString());
      throw PatientFailture(e.toString());
    }
  }

  @override
  Future<List<Patient>> getPatients() async {
    final listPatients = <Patient>[];
    try {
      final userRef = FirebaseFirestore.instance.collection('patients').get();

      // ignore: avoid_function_literals_in_foreach_calls
      await userRef.then((value) => value.docs.forEach((element) {
            // log(element.data().toString());
            listPatients.add(Patient.fromJson(element.data()));
          }));
      log(listPatients.toString());
      return listPatients;
    } catch (e) {
      log(e.toString());
      throw PatientFailture(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getTips() async {
    final tips = <Map<String, dynamic>>[];
    try {
      final userRef =
          FirebaseFirestore.instance.collection('Recomendaciones').get();

      // ignore: avoid_function_literals_in_foreach_calls
      await userRef.then((value) => value.docs.forEach((element) {
            // log(element.data().toString());
            tips.add(element.data());
          }));
      log(tips.toString());
      tips.shuffle();
      return tips;
    } catch (e) {
      log(e.toString());
      throw PatientFailture(e.toString());
    }
  }

  @override
  Future<void> setPatient(Patient patient) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('patients');

      userRef.doc(patient.patientDTO.id).set({
        "patientDTO": patient.patientDTO.toJson(),
        "emergencyContact": patient.emergencyContact.toJson(),
        "history": patient.history.asMap().entries.map((e) => e.value).toList(),
        "medications": patient.medications
            .asMap()
            .entries
            .map((e) => e.value.toJson())
            .toList(),
        "testResults": patient.testResults
            .asMap()
            .entries
            .map((e) => e.value.toJson())
            .toList(),
        "medicalVisits": patient.medicalVisits
            .asMap()
            .entries
            .map((e) => e.value.toJson())
            .toList(),
        "reminders": patient.reminders
            .asMap()
            .entries
            .map((e) => {
                  "time": e.value.time,
                  "message": e.value.message,
                  "medication": e.value.medication.toJson()
                })
            .toList(),
      });
    } catch (e) {
      log(e.toString());
      throw PatientFailture(e.toString());
    }
  }

  Future<void> setPatientLogin({
    required String email,
    required String password,
    required int rol,
    required Patient patient,
  }) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('login');

      userRef.doc(email).set({
        "email": email,
        "password": password,
        "rol": rol,
        "patient": patient.patientDTO.id,
      });

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log(e.toString());
      throw PatientFailture(e.toString());
    }
  }

  Future<Map<String, dynamic>> getPatientLogin(String email) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('login');

      final user = await userRef.doc(email).get();

      return user.data() ?? {};
    } catch (e) {
      log(e.toString());
      throw PatientFailture(e.toString());
    }
  }

  @override
  Future<void> updatePatient(Patient patient) async {
    try {
      final userRef = FirebaseFirestore.instance
          .collection('patients')
          .doc(patient.patientDTO.id)
          .withConverter<Patient>(
            fromFirestore: (snapshots, _) =>
                Patient.fromJson(snapshots.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

      await userRef.update(patient.toJson());
    } catch (e) {
      log(e.toString());
      throw PatientFailture(e.toString());
    }
  }

  Future<void> fillPatients() async {
    final List<Patient> patients = genPatients();

    // ignore: avoid_function_literals_in_foreach_calls
    patients.forEach((element) async {
      await setPatient(element);
    });
  }
}

List<Patient> genPatients() {
  return List.generate(
      100,
      (index) => Patient(
            patientDTO: PatientDTO(
              id: 'P${index + 1}',
              firstName: 'John${index + 1}',
              lastName: 'Doe',
              dateOfBirth:
                  DateTime(1980 + index % 10, 1 + index % 12, 1 + index % 28)
                      .toString(),
              gender: index % 2 == 0 ? 'Male' : 'Female',
              address: '${index + 1} Main St',
              phoneNumber: '+1 (123) 456-7890',
              emailAddress: 'john${index + 1}.doe@example.com',
              healthInsurance: 'XYZ Insurance',
            ),
            emergencyContact: EmergencyContact(
              name: 'Jane Doe',
              relationship: 'Spouse',
              phoneNumber: '+1 (234) 567-8901',
            ),
            history: ['Asthma', 'Allergies'],
            medications: [
              Medication(
                name: 'Ventolin',
                dosage: '2 puffs',
                frequency: 'As needed for asthma symptoms',
              ),
              Medication(
                name: 'Zyrtec',
                dosage: '1 tablet',
                frequency: 'Once daily for allergies',
              ),
            ],
            testResults: [
              TestResult(type: 'Blood pressure', result: '120/80 mmHg'),
              TestResult(type: 'Cholesterol', result: '200 mg/dL'),
            ],
            medicalVisits: [
              MedicalVisit(
                date: DateTime(2022, 03, 15).toString(),
                diagnosis: 'Acute bronchitis',
                treatment: 'Prescribed antibiotics',
                physician: 'Dr. Smith',
              ),
              MedicalVisit(
                date: DateTime(2022, 01, 10).toString(),
                diagnosis: 'Seasonal allergies',
                treatment: 'Prescribed allergy medication',
                physician: 'Dr. Jones',
              ),
            ],
            reminders: [
              Reminder(
                state: false,
                time: DateTime(2023, 05, 01, 9, 0, 0),
                message: 'Take Ventolin',
                medication: Medication(
                  name: 'Ventolin',
                  dosage: '2 puffs',
                  frequency: 'As needed for asthma symptoms',
                ),
              ),
              Reminder(
                state: false,
                time: DateTime(2023, 05, 01, 12, 0, 0),
                message: 'Take Zyrtec',
                medication: Medication(
                  name: 'Zyrtec',
                  dosage: '1 tablet',
                  frequency: 'Once daily for allergies',
                ),
              ),
            ],
          ));
}
