// 초기 고정 세팅 값
enum AppRouteEnum { articlesPage, articleDetailPage, weViewPage, photoViewPage }

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.articlesPage:
        return '/articles_page';
      case AppRouteEnum.articleDetailPage:
        return '/article_details_page';
      case AppRouteEnum.weViewPage:
        return '/web_view_page';
      case AppRouteEnum.photoViewPage:
        return '/photo_view_page';
    }
  }
}
