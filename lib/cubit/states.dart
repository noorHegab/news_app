abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsLoadingGetSourcesState extends NewsStates {}

class NewsSuccessGetSourcesState extends NewsStates {}

class NewsErrorGetSourcesState extends NewsStates {
  final String error;

  NewsErrorGetSourcesState(this.error);
}

class NewsLoadingGetArticlesState extends NewsStates {}

class NewsSuccessGetArticlesState extends NewsStates {}

class NewsErrorGetArticlesState extends NewsStates {
  final String error;

  NewsErrorGetArticlesState(this.error);
}
