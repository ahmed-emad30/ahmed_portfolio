import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:portfolio/core/api/api_request_helpers/api_consumer.dart';
import 'package:portfolio/core/api/api_request_helpers/dio_consumer.dart';
import 'package:portfolio/core/helpers/helper_functions/network_status.dart';
import 'package:portfolio/features/contact/data/data_source/contact_remote_data_source.dart';
import 'package:portfolio/features/contact/data/repository/contact_repository_imp.dart';
import 'package:portfolio/features/contact/domain/repository/contact_repository.dart';
import 'package:portfolio/features/contact/presentation/contact_screen/logic/contact_cubit.dart';
import 'package:portfolio/features/shared/data/data_source/shared_remote_data_source.dart';
import 'package:portfolio/features/shared/data/repository/shared_repository_imp.dart';
import 'package:portfolio/features/shared/domain/repository/shared_repository.dart';
import 'package:portfolio/features/shared/presentation/logic/portfolio_content_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    sl.registerLazySingleton<NetworkStatus>(
      () => NetworkStatusImp(sl<InternetConnection>()),
    );
    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer());
    sl.registerLazySingleton<Dio>(() => Dio());
    sl.registerLazySingleton<InternetConnection>(
      () => InternetConnection.createInstance(
        customCheckOptions: [
          InternetCheckOption(uri: Uri.parse('https://www.google.com/')),
        ],
      ),
    );

    sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

    sl.registerLazySingleton<SharedRemoteDataSource>(
      () => SharedRemoteDataSourceImp(sl<SupabaseClient>()),
    );
    sl.registerLazySingleton<SharedRepository>(
      () => SharedRepositoryImp(sl<SharedRemoteDataSource>()),
    );
    sl.registerFactory<PortfolioContentCubit>(
      () => PortfolioContentCubit(sl<SharedRepository>()),
    );

    sl.registerLazySingleton<ContactRemoteDataSource>(
      () => ContactRemoteDataSourceImp(sl<SupabaseClient>()),
    );
    sl.registerLazySingleton<ContactRepository>(
      () => ContactRepositoryImp(sl<ContactRemoteDataSource>()),
    );
    sl.registerFactory<ContactCubit>(
      () => ContactCubit(sl<ContactRepository>()),
    );
  }
}
