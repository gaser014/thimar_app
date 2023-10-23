import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppImage({
    Key? key,
    required this.path,
    this.width,
    this.height,
    required this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http'))
    {  return Image.network(
        path,
        fit: fit,
        width: width,
        height: height,
      );}
    if (path.endsWith('.svg')){
      return SvgPicture.asset(
        path,
        fit: fit,
        width: width,
        height: height,
      );}
    else{
      return Image.asset(
        path,
        fit: fit,
        width: width,
        height: height,
      );
    }
  }
}
