import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/login/login_event.dart';
import 'package:russian_spotify_project/presentation/blocs/login/login_state.dart';
import '../../../domain/usecases/login_usecase.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  String _email = '';
  String _password = '';

  LoginBloc(this._loginUseCase) : super(LoginInitial()) {
    on<InitializeLogin>(_initialize);
    on<UpdateEmail>(_updateEmail);
    on<UpdatePassword>(_updatePassword);
    on<PerformLogin>(_performLogin);
  }

  void _initialize(InitializeLogin event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }

  void _updateEmail(UpdateEmail event, Emitter<LoginState> emit) {
    _email = event.email;
  }

  void _updatePassword(UpdatePassword event, Emitter<LoginState> emit) {
    _password = event.password;
  }

  Future<void> _performLogin(
    PerformLogin event,
    Emitter<LoginState> emit,
  ) async {
    if (_email.isEmpty || _password.isEmpty) {
      emit(LoginFailure('Please enter both email and password.'));
      return;
    }

    emit(LoginLoading());

    try {
      final isLoggedIn = await _loginUseCase.call(_email, _password);
      if (isLoggedIn) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('Invalid email or password.'));
      }
    } catch (e) {
      emit(LoginFailure('An error occurred while logging in.'));
    }
  }
}
