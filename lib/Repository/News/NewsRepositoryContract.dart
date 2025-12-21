import '../../Model/NewsResponse.dart';

abstract class NewsRepositoryContract {
  Future<NewsResponse> getNews({required String sourceId, int page});
}

abstract class NewsRemoteDataSource {
  Future<NewsResponse> getNews({required String sourceId, int page});
}