import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Category/cubit/States.dart';
import 'package:news_app/Repository/Source/SourceRepositoryContract.dart';

class CategoryDetailsViewModel extends Cubit<SourceStates>{
  // todo: loading , Success , error

  SourceRepositoryContract repositoryContract;


CategoryDetailsViewModel(this.repositoryContract):super (SourceLoadingState());

void getSourceByCategoryId(String categoryId) async{
  try{
    emit(SourceLoadingState());
    var response=await repositoryContract.getSourceByCategoryId(categoryId);
    if(response?.status=='error'){
      emit(SourceErrorState(errorMessage: response?.message));
    }else{
      emit(SourceSuccessState(sourceList: response?.sources));
    }
  }catch(e){
    emit(SourceErrorState(errorMessage: 'SomeThing Went Wrong'));
  }
}



}