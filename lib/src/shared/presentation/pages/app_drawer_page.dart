import 'package:cleanarchitecture/main.dart';
import 'package:cleanarchitecture/src/core/helper/helper.dart';
import 'package:cleanarchitecture/src/core/translations/l10n.dart';
import 'package:cleanarchitecture/src/core/utils/injections.dart';
import 'package:cleanarchitecture/src/shared/data/data_sources/app_shared_prefs.dart';
import 'package:cleanarchitecture/src/shared/domain/entities/language_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AppDrawerPage extends StatefulWidget {
  const AppDrawerPage({super.key});

  @override
  State<AppDrawerPage> createState() => _AppDrawerPageState();
}

class _AppDrawerPageState extends State<AppDrawerPage> {
  LanguageEnum selectedLanguage = Helper.getLang();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kToolbarHeight),
          Text(
            S.of(context).language,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(color: Colors.black),
          ),

          // Arabic language
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Theme.of(context).iconTheme.color,
            ),
            child: RadioListTile(
              value: LanguageEnum.values[0],
              activeColor: selectedLanguage != LanguageEnum.ar
                  ? Theme.of(context).iconTheme.color
                  : Helper.isDarkTheme()
                  ? Colors.white
                  : Colors.blue,
              contentPadding: EdgeInsets.zero,
              title: Text(
                S.of(context).arabic,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              groupValue: selectedLanguage,
              onChanged: (value) {
                selectedLanguage = value!;
                setState(() {
                  MyApp.setLocale(context, selectedLanguage);
                });
              },
            ),
          ),

          // English language
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Theme.of(context).iconTheme.color,
            ),
            child: RadioListTile(
              value: LanguageEnum.values[1],
              activeColor: selectedLanguage != LanguageEnum.en
                  ? Theme.of(context).iconTheme.color
                  : Helper.isDarkTheme()
                  ? Colors.white
                  : Colors.blue,
              contentPadding: EdgeInsets.zero,
              title: Text(
                S.of(context).english,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              groupValue: selectedLanguage,
              onChanged: (value) {
                selectedLanguage = value!;
                setState(() {
                  MyApp.setLocale(context, selectedLanguage);
                });
              },
            ),
          ),
          // Theme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Helper.isDarkTheme()
                    ? S.of(context).dark_skin
                    : S.of(context).light_skin,
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.copyWith(color: Colors.black),
              ),
              Switch(
                activeColor: Colors.black,
                inactiveTrackColor: Colors.grey,
                value: Helper.isDarkTheme(),
                onChanged: (value) {
                  if (value) {
                    // Dark
                    sl<AppSharedPrefs>().setDarkTheme(true);
                  } else {
                    // Light
                    sl<AppSharedPrefs>().setDarkTheme(false);
                  }
                  Provider.of<AppNotifier>(
                    context,
                    listen: false,
                  ).updateThemeTitle(sl<AppSharedPrefs>().getIsDarkTheme());
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
