import 'package:news_app/API/ApiManger.dart';
import 'package:news_app/Model/SourceResponse.dart';
import 'package:news_app/Repository/Source/SourceRepositoryContract.dart';

class SourceRemoteDataSourceImpl implements SourceRemoteDataSource{
  ApiManger apiManger;
  SourceRemoteDataSourceImpl(this.apiManger);
  @override
  Future<SourceResponse> getSourceByCategoryId(String categoryId) async {
    var response= await apiManger.getSources(categoryId);
    return response;
  }

}

SourceRemoteDataSource injectSourceRemoteDataSource(){
  return SourceRemoteDataSourceImpl(injectApiManager());
}

ApiManger injectApiManager(){
  return ApiManger();
}