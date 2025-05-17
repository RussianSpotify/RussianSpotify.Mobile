import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/usecases/register_usecase.dart';
import 'package:russian_spotify_project/presentation/blocs/register/register_event.dart';
import 'package:russian_spotify_project/presentation/blocs/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;
  String _username = '';
  String _email = '';
  String _password = '';
  String _passwordConfirm = '';
  bool _isAuthor = false;

  String get email => _email;

  RegisterBloc(this._registerUseCase) : super(RegisterInitial()) {
    on<UpdateUsername>(_updateUsername);
    on<UpdateEmail>(_updateEmail);
    on<UpdatePassword>(_updatePassword);
    on<UpdatePasswordConfirm>(_updatePasswordConfirm);
    on<ToggleRole>(_toggleRole);
    on<PerformRegistration>(_performRegistration);
  }

  void _updateUsername(UpdateUsername event, Emitter<RegisterState> emit) {
    _username = event.username;
  }

  void _updateEmail(UpdateEmail event, Emitter<RegisterState> emit) {
    _email = event.email;
  }

  void _updatePassword(UpdatePassword event, Emitter<RegisterState> emit) {
    _password = event.password;
  }

  void _updatePasswordConfirm(
    UpdatePasswordConfirm event,
    Emitter<RegisterState> emit,
  ) {
    _passwordConfirm = event.passwordConfirm;
  }

  void _toggleRole(ToggleRole event, Emitter<RegisterState> emit) {
    _isAuthor = event.isAuthor;
  }

  Future<void> _performRegistration(
    PerformRegistration event,
    Emitter<RegisterState> emit,
  ) async {
    if (_password != _passwordConfirm) {
      emit(RegisterFailure("Passwords don't match"));
      return;
    }

    if (!_email.contains('@') || !_email.contains('.')) {
      emit(RegisterFailure("Invalid email address"));
      return;
    }

    emit(RegisterLoading());

    try {
      final success = await _registerUseCase.call(
        _username,
        _email,
        _password,
        _passwordConfirm,
        _isAuthor ? 'Автор' : 'Пользователь',
      );

      if (success) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure("Registration failed. Please try again."));
      }
    } catch (e) {
      emit(RegisterFailure("An error occurred: $e"));
    }
  }
}
