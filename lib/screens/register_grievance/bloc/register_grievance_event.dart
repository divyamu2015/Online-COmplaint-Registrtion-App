part of 'register_grievance_bloc.dart';

@freezed
class RegisterGrievanceEvent with _$RegisterGrievanceEvent {
  const factory RegisterGrievanceEvent.started() = _Started;
  const factory RegisterGrievanceEvent.complaintregister({
   // required int id,
    required String name,
    required String phone,
    required String email,
    required String address,
    required String city,
    required String latitude,
    required String longitude,
    required String photo,
    required String description,
    required String  date,
   // required String statusCode,
  //  required DateTime createdAt,
    required String aadhaarPhoto,
    required int category,
    required int userId,
   // required dynamic assignedOfficer,
  }) = _Complaintregister;
}
