import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/entities/subscription_option_entity.dart';
import 'package:russian_spotify_project/domain/usecases/get_subscription_options_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/make_subscription_usecase.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final GetSubscriptionOptionsUseCase _getSubscriptionOptionsUseCase;
  final MakeSubscriptionUseCase _makeSubscriptionUseCase;

  List<SubscriptionOption> _subscriptionOptions = [];
  int _selectedLength = 1;

  SubscriptionBloc(
    this._getSubscriptionOptionsUseCase,
    this._makeSubscriptionUseCase,
  ) : super(SubscriptionInitial()) {
    on<LoadSubscriptionOptions>(_loadSubscriptionOptions);
    on<SelectLength>(_selectLength);
    on<PerformSubscription>(_performSubscription);
  }

  Future<void> _loadSubscriptionOptions(
    LoadSubscriptionOptions event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());

    try {
      _subscriptionOptions = await _getSubscriptionOptionsUseCase.call();
      emit(
        SubscriptionLoaded(
          subscriptionOptions: _subscriptionOptions,
          selectedLength: _selectedLength,
        ),
      );
    } catch (e) {
      emit(SubscriptionFailure("Failed to load subscription options: $e"));
    }
  }

  void _selectLength(SelectLength event, Emitter<SubscriptionState> emit) {
    _selectedLength = event.length;

    emit(
      SubscriptionLoaded(
        subscriptionOptions: _subscriptionOptions,
        selectedLength: _selectedLength,
      ),
    );
  }

  Future<void> _performSubscription(
    PerformSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());

    try {
      final success = await _makeSubscriptionUseCase(_selectedLength);

      if (success) {
        emit(SubscriptionSuccess());
      } else {
        emit(SubscriptionFailure("Failed to subscribe. Please try again."));
      }
    } catch (e) {
      emit(SubscriptionFailure("An error occurred: $e"));
    }
  }
}
