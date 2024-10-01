import 'package:news_app/Model/SourceResponse.dart';
import 'package:news_app/Repository/Source/SourceRepositoryContract.dart';

class SourceRepositoryImpl implements SourceRepositoryContract{
  SourceRemoteDataSource remoteDataSource;
  SourceRepositoryImpl(this.remoteDataSource);
  @override
  Future<SourceResponse?> getSourceByCategoryId(String categoryId) {
   return remoteDataSource.getSourceByCategoryId(categoryId);
  }

}