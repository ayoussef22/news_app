import 'package:news_app/Model/SourceResponse.dart';

abstract class SourceStates{ }

class SourceLoadingState extends SourceStates{ }

class SourceSuccessState extends SourceStates{
  List<Source>? sourceList;
  SourceSuccessState({required this.sourceList});
}

class SourceErrorState extends SourceStates{
  String? errorMessage;
  SourceErrorState({required this.errorMessage});
}