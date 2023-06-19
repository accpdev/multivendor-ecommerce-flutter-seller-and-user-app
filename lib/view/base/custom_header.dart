import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class CustomHeader extends StatelessWidget {
  final String headerImage;
  final String? title;
  const CustomHeader({Key? key, required this.title, required this.headerImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( color: Theme.of(context).primaryColor.withOpacity(0.06), child: Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Row( mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(headerImage, height: 30),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text(title!, style: robotoMedium.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,
            color: Theme.of(context).primaryColor,
          ),),
        ],
      ),
    ),);
  }
}
