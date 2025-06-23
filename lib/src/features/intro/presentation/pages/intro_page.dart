import 'package:cleanarchitecture/src/core/helper/helper.dart';
import 'package:cleanarchitecture/src/core/router/app_route_enum.dart';
import 'package:cleanarchitecture/src/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      if (!mounted) return;
      // 이전 모든 경로 스택 제거
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteEnum.articlesPage.name,
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Image.asset(
            Helper.getImgPath('logo.png'),
            color: Helper.isDarkTheme() ? AppColors.white : null,
            width: 300.w,
            height: 300.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
