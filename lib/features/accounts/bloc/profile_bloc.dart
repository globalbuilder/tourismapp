import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourism_frontend/features/accounts/data/accounts_service.dart';
import 'package:tourism_frontend/features/accounts/models/user_model.dart';
import 'package:tourism_frontend/features/accounts/models/profile_model.dart';

/// EVENTS
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

// fetch user & profile
class FetchUserProfileEvent extends ProfileEvent {}

class UpdateUserEvent extends ProfileEvent {
  final String? firstName;
  final String? lastName;
  const UpdateUserEvent({this.firstName, this.lastName});
}

class UpdateProfileEvent extends ProfileEvent {
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? biography;
  final String? website;
  const UpdateProfileEvent({
    this.email,
    this.phoneNumber,
    this.address,
    this.biography,
    this.website,
  });
}

class ChangePasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword1;
  final String newPassword2;
  const ChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword1,
    required this.newPassword2,
  });
}

/// STATES
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final ProfileModel profile;
  const ProfileLoaded({required this.user, required this.profile});
  @override
  List<Object?> get props => [user, profile];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object?> get props => [message];
}

/// BLOC
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AccountsService accountsService;
  ProfileBloc({required this.accountsService}) : super(ProfileInitial()) {
    on<FetchUserProfileEvent>(_onFetchUserProfile);
    on<UpdateUserEvent>(_onUpdateUser);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<ChangePasswordEvent>(_onChangePassword);
  }

  Future<void> _onFetchUserProfile(FetchUserProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final user = await accountsService.getUser();
      final profile = await accountsService.getProfile();
      emit(ProfileLoaded(user: user, profile: profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateUser(UpdateUserEvent event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      emit(ProfileLoading());
      try {
        final user = await accountsService.updateUser(
          firstName: event.firstName,
          lastName: event.lastName,
        );
        final profile = accountsService.currentProfile ?? await accountsService.getProfile();
        emit(ProfileLoaded(user: user, profile: profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      emit(ProfileLoading());
      try {
        final updatedProfile = await accountsService.updateProfile(
          email: event.email,
          phoneNumber: event.phoneNumber,
          address: event.address,
          biography: event.biography,
          website: event.website,
        );
        final user = accountsService.currentUser ?? await accountsService.getUser();
        emit(ProfileLoaded(user: user, profile: updatedProfile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    }
  }

  Future<void> _onChangePassword(ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      emit(ProfileLoading());
      try {
        await accountsService.changePassword(
          oldPassword: event.oldPassword,
          newPassword1: event.newPassword1,
          newPassword2: event.newPassword2,
        );
        // After success, do nothing or refetch?
        final user = accountsService.currentUser ?? await accountsService.getUser();
        final profile = accountsService.currentProfile ?? await accountsService.getProfile();
        emit(ProfileLoaded(user: user, profile: profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    }
  }
}
