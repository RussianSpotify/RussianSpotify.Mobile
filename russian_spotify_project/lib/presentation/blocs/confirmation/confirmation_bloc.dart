import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/confirmation/confirmation_event.dart';
import 'package:russian_spotify_project/presentation/blocs/confirmation/confirmation_state.dart';
import '../../../domain/usecases/confirm_usecase.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final ConfirmUseCase _confirmUseCase;

  ConfirmationBloc(this._confirmUseCase) : super(ConfirmationInitial()) {
    on<InitializeFromContext>(_initializeFromContext);
    on<UpdateConfirmationCode>(_updateConfirmationCode);
    on<HandleConfirmClick>(_handleConfirmClick);
  }

  void _initializeFromContext(
    InitializeFromContext event,
    Emitter<ConfirmationState> emit,
  ) {
    final route = ModalRoute.of(event.context);
    if (route == null || route.settings.arguments is! Map<String, String>) {
      emit(ConfirmationError('Некорректные аргументы при переходе.'));
      return;
    }

    final arguments = route.settings.arguments as Map<String, String>;
    final email = arguments['email'];
    final newPassword = arguments['newPassword'];
    final confirmPassword = arguments['confirmPassword'];
    final operation = arguments['operation'];

    if (email == null || operation == null) {
      emit(ConfirmationError('Необходимые аргументы отсутствуют.'));
      return;
    }

    emit(
      ConfirmationLoaded(
        email: email,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        operation: operation,
        confirmationCode: '',
      ),
    );
  }

  void _updateConfirmationCode(
    UpdateConfirmationCode event,
    Emitter<ConfirmationState> emit,
  ) {
    if (state is ConfirmationLoaded) {
      final currentState = state as ConfirmationLoaded;
      emit(
        ConfirmationLoaded(
          email: currentState.email,
          newPassword: currentState.newPassword,
          confirmPassword: currentState.confirmPassword,
          operation: currentState.operation,
          confirmationCode: event.code,
        ),
      );
    }
  }

  Future<void> _handleConfirmClick(
    HandleConfirmClick event,
    Emitter<ConfirmationState> emit,
  ) async {
    if (state is! ConfirmationLoaded) {
      emit(ConfirmationError('Невозможно выполнить операцию.'));
      return;
    }

    emit(ConfirmationLoading());

    try {
      final currentState = state as ConfirmationLoaded;

      bool success = false;

      if (currentState.operation == 'confirmEmail') {
        success = await _confirmUseCase.confirmEmail(
          currentState.email,
          currentState.confirmationCode,
        );
      } else if (currentState.operation == 'resetPassword') {
        if (currentState.newPassword == null ||
            currentState.confirmPassword == null) {
          emit(ConfirmationError('Пароли не указаны.'));
          return;
        }

        success = await _confirmUseCase.confirmNewPassword(
          currentState.email,
          currentState.newPassword!,
          currentState.confirmPassword!,
          currentState.confirmationCode,
        );
      }

      if (success) {
        emit(ConfirmationSuccess());
      } else {
        emit(ConfirmationError('Что-то пошло не так. Попробуйте снова.'));
      }
    } catch (e) {
      emit(ConfirmationError('Ошибка: $e'));
    }
  }
}
