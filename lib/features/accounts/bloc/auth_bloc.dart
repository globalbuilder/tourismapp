import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tourism_frontend/features/accounts/data/accounts_service.dart';

/// EVENTS
abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;
  const AuthLoginEvent({required this.username, required this.password});
  @override
  List<Object?> get props => [username, password];
}

class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String firstName;
  final String lastName;
  final String password1;
  final String password2;
  const AuthRegisterEvent({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password1,
    required this.password2,
  });
  @override
  List<Object?> get props => [username, firstName, lastName, password1, password2];
}

class AuthLogoutEvent extends AuthEvent {}

class AuthCheckTokensEvent extends AuthEvent {}

/// STATES
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

/// BLOC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AccountsService accountsService;
  AuthBloc({required this.accountsService}) : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthLogoutEvent>(_onLogout);
    on<AuthCheckTokensEvent>(_onCheckTokens);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await accountsService.login(
        username: event.username,
        password: event.password,
      );
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await accountsService.register(
        username: event.username,
        firstName: event.firstName,
        lastName: event.lastName,
        password1: event.password1,
        password2: event.password2,
      );
      // remain unauth after registration
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await accountsService.logout();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckTokens(AuthCheckTokensEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    if (accountsService.accessToken == null) {
      emit(AuthUnauthenticated());
    } else {
      // Possibly refresh or check if token is valid
      emit(AuthAuthenticated());
    }
  }
}
