import 'package:cleanarchitecture/src/core/helper/helper.dart';
import 'package:cleanarchitecture/src/core/router/router.dart';
import 'package:cleanarchitecture/src/core/styles/app_theme.dart';
import 'package:cleanarchitecture/src/core/translations/l10n.dart';
import 'package:cleanarchitecture/src/core/utils/injections.dart';
import 'package:cleanarchitecture/src/features/intro/presentation/pages/intro_page.dart';
import 'package:cleanarchitecture/src/shared/data/data_sources/app_shared_prefs.dart';
import 'package:cleanarchitecture/src/shared/domain/entities/language_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await initInjections();

  runApp(
    DevicePreview(
      builder: (context) {
        return const MyApp();
      },
      enabled: false,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, LanguageEnum newLocale) {
    _MyAppState state = context.findAncestorStateOfType()!;
    state.updateLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Locale locale = const Locale('en');
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();

  void updateLocale(LanguageEnum newLocale) {
    setState(() {
      locale = Locale(newLocale.name);
    });
    sl<AppSharedPrefs>().setLang(newLocale);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    if (mounted) {
      LanguageEnum newLocale = Helper.getLang();
      setState(() {
        locale = Locale(newLocale.local);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppNotifier(),
      child: Consumer<AppNotifier>(
        builder: (context, value, child) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'CleanArchitecture MVVM',
                scaffoldMessengerKey: snackBarKey,
                onGenerateRoute: AppRouter.generateRoute,
                debugShowCheckedModeBanner: false,
                locale: locale,
                builder: DevicePreview.appBuilder,
                theme: Helper.isDarkTheme() ? darkAppTheme : appTheme,
                localizationsDelegates: [
                  S.delegate,

                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                navigatorKey: navigatorKey,
                supportedLocales: const [Locale("ar"), Locale("en")],
                home: const IntroPage(),
              );
            },
          );
        },
      ),
    );
  }
}

// App notifier for Lang, Theme, ...
class AppNotifier extends ChangeNotifier {
  late bool darkTheme;

  AppNotifier() {
    _initialise();
  }

  Future _initialise() async {
    darkTheme = Helper.isDarkTheme();

    notifyListeners();
  }

  void updateThemeTitle(bool newDarkTheme) {
    darkTheme = newDarkTheme;
    if (Helper.isDarkTheme()) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
