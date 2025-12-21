import '../../Model/NewsResponse.dart';

abstract class NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsSuccessState extends NewsStates {
  final List<News> newsList;
  final bool hasMore;

  NewsSuccessState({required this.newsList, this.hasMore = true});
}

class NewsErrorState extends NewsStates {
  final String errorMessage;

  NewsErrorState({required this.errorMessage});
}