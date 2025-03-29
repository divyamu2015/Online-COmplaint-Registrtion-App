part of 'register_grievance_bloc.dart';

@freezed
class RegisterGrievanceState with _$RegisterGrievanceState {
  const factory RegisterGrievanceState.initial() = _Initial;
  const factory RegisterGrievanceState.loading() = _Loading;
  const factory RegisterGrievanceState.success({required ComplaintRegisterModel response}) = _Success;
  const factory RegisterGrievanceState.error({required String massage}) = _Error;
  
  
  
}
