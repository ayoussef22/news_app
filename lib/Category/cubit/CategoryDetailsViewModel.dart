import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/API/ApiManger.dart';
import 'package:news_app/Category/cubit/States.dart';

class CategoryDetailsViewModel extends Cubit<SourceStates>{
  // todo: loading , Success , error

CategoryDetailsViewModel():super (SourceLoadingState());

void getSourceByCategoryId(String categoryId) async{
  try{
    emit(SourceLoadingState());
    var response=await ApiManger.getSources(categoryId);
    if(response.status=='error'){
      emit(SourceErrorState(errorMessage: response.message));
    }else{
      emit(SourceSuccessState(sourceList: response.sources));
    }
  }catch(e){
    emit(SourceErrorState(errorMessage: 'SomeThing Went Wrong'));
  }
}



}