import 'package:flutter/cupertino.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String placeholder;
  const CustomImage({Key? key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = Images.placeholderImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      height: height,
      width: width, fit: BoxFit.cover,
      placeholder: Images.placeholderImage, image: image,
      imageErrorBuilder: (c, o, s) => Image.asset(
        Images.placeholderImage, height: height,
        width: width, fit: BoxFit.cover,
      ),
    );
  }
}
