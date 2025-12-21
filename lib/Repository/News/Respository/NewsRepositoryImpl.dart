import '../../../Model/NewsResponse.dart';
import '../DataSource/NewsRemoteDataSourceImpl.dart';
import '../NewsRepositoryContract.dart';

class NewsRepositoryImpl implements NewsRepositoryContract {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<NewsResponse> getNews({required String sourceId, int page = 1}) {
    return remoteDataSource.getNews(sourceId: sourceId, page: page);
  }
}

NewsRepositoryContract injectNewsRepository() {
  return NewsRepositoryImpl(injectNewsRemoteDataSource());
}