enum AppRouteEnum { articlesPage, articleDetailPage, weViewPage, photoViewPage }

extension AppRouteExtenson on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.articlesPage:
        return '/articles_page';
      case AppRouteEnum.articleDetailPage:
        return '/article_details_page';
      case AppRouteEnum.weViewPage:
        return '/weView_page';
      case AppRouteEnum.photoViewPage:
        return '/photoView_page';
    }
  }
}
