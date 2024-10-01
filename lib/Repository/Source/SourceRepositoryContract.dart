import 'package:news_app/Model/SourceResponse.dart';

abstract class SourceRepositoryContract{
  Future<SourceResponse?>getSourceByCategoryId(String categoryId);
}

abstract class SourceRemoteDataSource{
  Future<SourceResponse>getSourceByCategoryId(String categoryId);
}