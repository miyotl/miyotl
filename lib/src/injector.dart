import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client
  // injector.registerSingleton<Dio>(Dio());

  // Dependencies
  // injector.registerSingleton<NewsApiService>(NewsApiService(injector()));
  // injector.registerSingleton<ArticlesRepository>(ArticlesRepositoryImpl(injector()));

  // UseCases
  // injector.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(injector()));

  // Blocs
  // injector.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(injector()));
}
