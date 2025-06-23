import 'package:cleanarchitecture/src/shared/presentation/pages/app_drawer_page.dart';
import 'package:flutter/material.dart';

class BackgroundPage extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool withDrawer;
  final Function()? drawerCallBack;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool topSafeArea;
  final bool bottomSafeArea;
  final PreferredSizeWidget? appBar;
  const BackgroundPage({
    super.key,
    required this.child,
    this.backgroundColor,
    this.withDrawer = false,
    this.drawerCallBack,
    this.scaffoldKey,
    this.topSafeArea = true,
    this.bottomSafeArea = true,
    this.appBar,
  });

  @override
  State<BackgroundPage> createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isCallFromDrawer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      key: widget.scaffoldKey,
      backgroundColor:
          widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      onDrawerChanged: (isOpened) {
        if (!isOpened) {
          if (!isCallFromDrawer) {
            if (widget.drawerCallBack != null) {
              widget.drawerCallBack!();
            }
          }
        }
      },
      drawer: widget.withDrawer
          ? Drawer(
              backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
              child: AppDrawerPage(),
            )
          : null,

      body: SafeArea(
        top: widget.topSafeArea,
        bottom: widget.bottomSafeArea,
        child: widget.child,
      ),
    );
  }
}
