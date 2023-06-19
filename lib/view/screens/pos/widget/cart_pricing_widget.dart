import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';


class PricingWidget extends StatelessWidget {
  final String? title;
  final String? amount;
  final bool isTotal;
  final bool isCoupon;
  final Function? onTap;
  const PricingWidget({Key? key, this.title, this.amount, this.isTotal = false, this.isCoupon = false, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
          Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeExtraSmall),
      child: Row(children: [

        Text(title!, style: robotoRegular.copyWith(color: isTotal? ColorResources.getTextColor(context):
        Theme.of(context).hintColor,fontWeight: isTotal? FontWeight.w700: FontWeight.w500,
            fontSize: isTotal? Dimensions.fontSizeLarge: Dimensions.fontSizeDefault),),
        const Spacer(),
        isCoupon?
        InkWell(
          onTap: onTap as void Function()?,
            child: const Icon(Icons.edit, size: Dimensions.iconSizeDefault,)):const SizedBox(),

        Text(amount!, style: robotoRegular.copyWith(color: isTotal? ColorResources.getTextColor(context):
        Theme.of(context).hintColor,fontWeight: isTotal? FontWeight.w700: FontWeight.w500,
            fontSize: isTotal? Dimensions.fontSizeLarge: Dimensions.fontSizeDefault),),

      ],),
    );
  }
}