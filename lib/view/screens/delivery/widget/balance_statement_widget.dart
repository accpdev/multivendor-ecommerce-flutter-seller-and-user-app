import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class BalanceStatementWidget extends StatelessWidget {
  final String? text;
  final String? icon;
  final Color? color;
  final double? amount;
  const BalanceStatementWidget({Key? key, this.text, this.icon, this.color, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null?
          SizedBox(width: Dimensions.iconSizeDefault,
              child: Image.asset(icon!)): const SizedBox(),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text(text!, style: robotoRegular.copyWith(color: ColorResources.getTextColor(context))),

          const Spacer(),
          Container(decoration: BoxDecoration(
              color: color!.withOpacity(.10),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeLarge)
          ),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeExtraSmall),
              child: Text(PriceConverter.convertPrice(context, amount),
                  style: robotoRegular.copyWith(color : color)),
            ),
          )


        ],
      ),
    );
  }
}
