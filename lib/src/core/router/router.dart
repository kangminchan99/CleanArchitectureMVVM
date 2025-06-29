import 'package:cleanarchitecture/src/features/articles/domain/models/article_model.dart';
import 'package:cleanarchitecture/src/features/articles/presentation/pages/article_details_page.dart';
import 'package:cleanarchitecture/src/features/articles/presentation/pages/articles_page.dart';
import 'package:cleanarchitecture/src/shared/presentation/pages/photo_view_page.dart';
import 'package:cleanarchitecture/src/shared/presentation/pages/web_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static String currentRoute = '';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? '';

    switch (settings.name) {
      case '/articles_page':
        return CupertinoPageRoute(
          builder: (_) => const ArticlesPage(),
          settings: RouteSettings(name: settings.name),
        );

      // Ny Times Article Details page
      case '/article_details_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            assert(
              settings.arguments != null,
              "nyTimesArticleModel is required",
            );
            return ArticleDetailsPage(
              model: settings.arguments as ArticleModel,
            );
          },
        );

      // Web view page
      case '/web_view_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => WebViewPage(link: settings.arguments as String),
        );

      // Photo view page
      case '/photo_view_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            Map<String, dynamic>? args =
                settings.arguments as Map<String, dynamic>?;
            assert(args != null, "You should pass 'path' and 'fromNet'");
            return PhotoViewPage(path: args!['path'], fromNet: args['fromNet']);
          },
        );

      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
