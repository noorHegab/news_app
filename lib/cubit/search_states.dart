abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class NewsLoadingGetSearchState extends SearchStates {}

class NewsSuccessGetSearchState extends SearchStates {}

class NewsErrorGetSearchState extends SearchStates {
  final String error;

  NewsErrorGetSearchState(this.error);
}
