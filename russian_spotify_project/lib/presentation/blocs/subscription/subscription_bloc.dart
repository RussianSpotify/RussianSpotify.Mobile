import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:russian_spotify_project/domain/usecases/get_subscription_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/make_subscription_usecase.dart';
import 'package:russian_spotify_project/presentation/blocs/subscription/subscription_event.dart';
import 'package:russian_spotify_project/presentation/blocs/subscription/subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final GetSubscriptionsUseCase _getSubscriptionsUseCase;
  final MakeSubscriptionUseCase _makeSubscriptionUseCase;

  SubscriptionBloc(this._getSubscriptionsUseCase, this._makeSubscriptionUseCase)
    : super(SubscriptionInitial()) {
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
      final subscriptions = await _getSubscriptionsUseCase.call("1");
      emit(
        SubscriptionLoaded(
          subscriptions: subscriptions,
          selectedLength: 1, // По умолчанию выбираем первую опцию
        ),
      );
    } catch (e) {
      emit(SubscriptionFailure("Failed to load subscription options: $e"));
    }
  }

  void _selectLength(SelectLength event, Emitter<SubscriptionState> emit) {
    if (state is SubscriptionLoaded) {
      final currentState = state as SubscriptionLoaded;
      emit(
        SubscriptionLoaded(
          subscriptions: currentState.subscriptions,
          selectedLength: event.length,
        ),
      );
    }
  }

  Future<void> _performSubscription(
    PerformSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());

    try {
      final currentState = state as SubscriptionLoaded;
      final success = await _makeSubscriptionUseCase(
        currentState.selectedLength,
      );

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
