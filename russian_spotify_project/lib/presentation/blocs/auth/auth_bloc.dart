import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/usecases/confirm_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/login_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/register_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/reset_password_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final ConfirmUseCase _confirmUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required ConfirmUseCase confirmUseCase,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _confirmUseCase = confirmUseCase,
        super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<Registered>(_onRegistered);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<ConfirmEmail>(_onConfirmEmail);
    on<ConfirmNewPassword>(_onConfirmNewPassword);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    // Проверяем, сохранены ли данные пользователя (например, токен)
    emit(Unauthenticated());
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(AuthError('Please enter both email and password.'));
      return;
    }

    emit(AuthLoading());

    try {
      final isLoggedIn = await _loginUseCase.call(event.email, event.password);
      if (isLoggedIn) {
        emit(Authenticated(event.email));
      } else {
        emit(AuthError('Invalid email or password.'));
      }
    } catch (e) {
      emit(AuthError('An error occurred while logging in.'));
    }
  }

  Future<void> _onRegistered(Registered event, Emitter<AuthState> emit) async {
    if (event.password != event.confirmPassword) {
      emit(AuthError("Passwords don't match"));
      return;
    }

    if (!event.email.contains('@') || !event.email.contains('.')) {
      emit(AuthError("Invalid email address"));
      return;
    }

    emit(AuthLoading());

    try {
      final success = await _registerUseCase.call(
        event.username,
        event.email,
        event.password,
        event.confirmPassword,
        event.isAuthor ? 'Автор' : 'Пользователь',
      );

      if (success) {
        emit(Authenticated(event.email));
      } else {
        emit(AuthError("Registration failed. Please try again."));
      }
    } catch (e) {
      emit(AuthError("An error occurred: $e"));
    }
  }

  Future<void> _onResetPasswordRequested(
      ResetPasswordRequested event,
      Emitter<AuthState> emit,
      ) async {
    if (event.email.isEmpty) {
      emit(AuthError('Please enter your email.'));
      return;
    }

    emit(AuthLoading());

    try {
      final success = await _resetPasswordUseCase.resetPassword(event.email);

      if (success) {
        emit(AuthInitial());
      } else {
        emit(AuthError("Failed to reset password. Please try again."));
      }
    } catch (e) {
      emit(AuthError("An error occurred: $e"));
    }
  }

  Future<void> _onConfirmEmail(
      ConfirmEmail event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      final success = await _confirmUseCase.confirmEmail(
        event.email,
        event.confirmationCode,
      );

      if (success) {
        emit(Authenticated(event.email));
      } else {
        emit(AuthError("Email confirmation failed. Please try again."));
      }
    } catch (e) {
      emit(AuthError("An error occurred: $e"));
    }
  }

  Future<void> _onConfirmNewPassword(
      ConfirmNewPassword event,
      Emitter<AuthState> emit,
      ) async {
    if (event.newPassword != event.confirmPassword) {
      emit(AuthError("Passwords don't match"));
      return;
    }

    emit(AuthLoading());

    try {
      final success = await _confirmUseCase.confirmNewPassword(
        event.email,
        event.newPassword,
        event.confirmPassword,
        event.confirmationCode,
      );

      if (success) {
        emit(Authenticated(event.email));
      } else {
        emit(AuthError("Password confirmation failed. Please try again."));
      }
    } catch (e) {
      emit(AuthError("An error occurred: $e"));
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) {
    // Очищаем данные пользователя (например, токен)
    emit(Unauthenticated());
  }
}