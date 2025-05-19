import 'package:get_it/get_it.dart';
import 'package:russian_spotify_project/data/repositories/albums_repository_impl.dart';
import 'package:russian_spotify_project/data/repositories/auth_repository_impl.dart';
import 'package:russian_spotify_project/data/repositories/payment_history_repository_impl.dart';
import 'package:russian_spotify_project/data/repositories/playlist_repository_impl.dart';
import 'package:russian_spotify_project/data/repositories/settings_repository_impl.dart';
import 'package:russian_spotify_project/data/repositories/song_repository_impl.dart';
import 'package:russian_spotify_project/data/repositories/subscription_repository_impl.dart';
import 'package:russian_spotify_project/data/repositories/user_repository_impl.dart';
import 'package:russian_spotify_project/data/services/graphql_service.dart';
import 'package:russian_spotify_project/domain/interfaces/album_repository.dart';
import 'package:russian_spotify_project/domain/interfaces/auth_repository.dart';
import 'package:russian_spotify_project/domain/interfaces/payment_history_repository.dart';
import 'package:russian_spotify_project/domain/interfaces/playlist_repository.dart';
import 'package:russian_spotify_project/domain/interfaces/settings_repository.dart';
import 'package:russian_spotify_project/domain/interfaces/song_repository.dart';
import 'package:russian_spotify_project/domain/interfaces/subscription_repository.dart';
import 'package:russian_spotify_project/domain/interfaces/user_repository.dart';
import 'package:russian_spotify_project/domain/usecases/confirm_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/get_albums_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/get_favorite_songs_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/get_payment_history_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/get_playlist_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/get_settings_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/get_subscription_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/get_user_info_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/login_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/make_subscription_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/register_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/reset_password_usecase.dart';
import 'package:russian_spotify_project/domain/usecases/search_songs_usecase.dart';
import 'package:russian_spotify_project/presentation/blocs/about/about_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/auth/auth_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/home/home_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/payment_history/payment_history_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/playlist/playlist_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/search/search_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/settings/settings_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/subscription/subscription_bloc.dart';
import 'package:russian_spotify_project/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:russian_spotify_project/presentation/widgets/music_player/music_player_bloc.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<GraphQlService>(() => GraphQlService());

  // Settings
  locator.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(),
  );
  locator.registerLazySingleton<GetSettingsUseCase>(
        () => GetSettingsUseCase(locator<SettingsRepository>()),
  );
  locator.registerFactory<SettingsBloc>(
        () => SettingsBloc(locator<GetSettingsUseCase>()),
  );

  // About
  locator.registerFactory<AboutBloc>(() => AboutBloc());

  // Subscription
  locator.registerLazySingleton<SubscriptionRepository>(
        () => SubscriptionRepositoryImpl(locator<GraphQlService>()),
  );
  locator.registerLazySingleton<MakeSubscriptionUseCase>(
        () => MakeSubscriptionUseCase(locator<SubscriptionRepository>()),
  );
  locator.registerLazySingleton<GetSubscriptionsUseCase>(
        () => GetSubscriptionsUseCase(locator<SubscriptionRepository>()),
  );
  locator.registerFactory<SubscriptionBloc>(
        () =>
        SubscriptionBloc(
          locator<GetSubscriptionsUseCase>(),
          locator<MakeSubscriptionUseCase>(),
        ),
  );

  // Payment History
  locator.registerLazySingleton<PaymentHistoryRepository>(
        () => PaymentHistoryRepositoryImpl(),
  );
  locator.registerLazySingleton<GetPaymentHistoryUseCase>(
        () => GetPaymentHistoryUseCase(locator<PaymentHistoryRepository>()),
  );
  locator.registerFactory<PaymentHistoryBloc>(
        () => PaymentHistoryBloc(locator<GetPaymentHistoryUseCase>()),
  );

  // Auth
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  locator.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<ConfirmUseCase>(
        () => ConfirmUseCase(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<ResetPasswordUseCase>(
        () => ResetPasswordUseCase(locator<AuthRepository>()),
  );
  locator.registerFactory<AuthBloc>(
        () =>
        AuthBloc(
          loginUseCase: locator<LoginUseCase>(),
          registerUseCase: locator<RegisterUseCase>(),
          resetPasswordUseCase: locator<ResetPasswordUseCase>(),
          confirmUseCase: locator<ConfirmUseCase>(),
        ),
  );

  // Playlist
  locator.registerLazySingleton<PlaylistRepository>(
        () => PlaylistRepositoryImpl(locator<GraphQlService>()),
  );
  locator.registerLazySingleton<GetPlaylistUseCase>(
        () => GetPlaylistUseCase(locator<PlaylistRepository>()),
  );
  locator.registerFactory<PlaylistBloc>(
        () => PlaylistBloc(locator<GetPlaylistUseCase>()),
  );

  // User Profile
  locator.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(locator<GraphQlService>()),
  );
  locator.registerLazySingleton<SongRepository>(
        () => SongRepositoryImpl(locator<GraphQlService>()),
  );
  locator.registerLazySingleton<GetFavoriteSongsUseCase>(
        () => GetFavoriteSongsUseCase(locator<SongRepository>()),
  );
  locator.registerFactory<GetUserInfoUseCase>(
        () => GetUserInfoUseCase(locator<UserRepository>()),
  );
  locator.registerFactory<UserProfileBloc>(
        () =>
        UserProfileBloc(
          locator<GetFavoriteSongsUseCase>(),
          locator<GetUserInfoUseCase>(),
        ),
  );

  // Home
  locator.registerFactory<AlbumsRepository>(() => AlbumsRepositoryImpl());
  locator.registerFactory<GetAlbumsUseCase>(
        () => GetAlbumsUseCaseImpl(locator<AlbumsRepository>()),
  );
  locator.registerFactory<HomeBloc>(
        () => HomeBloc(locator<GetAlbumsUseCase>()),
  );

  // Search
  locator.registerFactory<SearchSongsUseCase>(
        () => SearchSongsUseCaseImpl(locator<SongRepository>()),
  );
  locator.registerFactory<SearchBloc>(
        () => SearchBloc(locator<SearchSongsUseCase>()),
  );

  // Audio Player
  locator.registerFactory<AudioPlayerBloc>(() => AudioPlayerBloc());
}
