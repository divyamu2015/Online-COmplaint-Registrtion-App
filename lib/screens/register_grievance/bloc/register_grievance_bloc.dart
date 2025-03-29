import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:online_complaint_registration/screens/register_grievance/register_grievance_control/register_grievance_service.dart';

import '../register_grievance_model/register_grievance_model.dart';

part 'register_grievance_event.dart';
part 'register_grievance_state.dart';
part 'register_grievance_bloc.freezed.dart';

class RegisterGrievanceBloc
    extends Bloc<RegisterGrievanceEvent, RegisterGrievanceState> {
  RegisterGrievanceBloc() : super(const _Initial()) {
    on<RegisterGrievanceEvent>((event, emit) async {
      if (event is _Complaintregister) {
        emit(const RegisterGrievanceState.loading());
        try {
          final response = await complaintregister(
              //id: event.id,
              name: event.name,
              phone: event.phone,
              email: event.email,
              address: event.address,
              city: event.city,
              latitude: event.latitude,
              longitude: event.longitude,
              photo: event.photo,
              description: event.description,
              date: event.date,
              //statusCode: event.statusCode,
             // createdAt: event.createdAt,
              aadhaarPhoto: event.aadhaarPhoto,
              category: event.category,
              userId: event.userId
             // assignedOfficer: event.assignedOfficer
              );
          emit(RegisterGrievanceState.success(response: response));
        } catch (e) {
          emit(RegisterGrievanceState.error(massage: e.toString()));
        }
      }
    });
  }
}
