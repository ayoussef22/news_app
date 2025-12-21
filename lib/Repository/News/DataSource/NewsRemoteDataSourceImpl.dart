import '../../../API/ApiManger.dart';
import '../../../Model/NewsResponse.dart';
import '../NewsRepositoryContract.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final ApiManger apiManger;

  NewsRemoteDataSourceImpl(this.apiManger);

  @override
  Future<NewsResponse> getNews({required String sourceId, int page = 1}) {
    return ApiManger.getNewsFromSourcesId(sourceId: sourceId, page: page);
  }
}

NewsRemoteDataSource injectNewsRemoteDataSource() {
  return NewsRemoteDataSourceImpl(ApiManger());
}