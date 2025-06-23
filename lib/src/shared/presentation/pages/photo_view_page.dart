import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarchitecture/src/shared/presentation/pages/background_page.dart';
import 'package:cleanarchitecture/src/shared/presentation/widgets/arrow_back_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  final String path;
  final bool fromNet;
  const PhotoViewPage({super.key, required this.path, required this.fromNet});

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      bottomSafeArea: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25.h),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: ArrowBackButtonWidget(),
            ),
          ),
          SizedBox(height: 25.h),
          Expanded(child: _buildPhotoView()),
        ],
      ),
    );
  }

  Widget _buildPhotoView() {
    if (widget.fromNet) {
      return Hero(
        tag: widget.path,
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget.path),
        ),
      );
    } else {
      return Hero(
        tag: widget.path,
        child: PhotoView(imageProvider: AssetImage(widget.path)),
      );
    }
  }
}
