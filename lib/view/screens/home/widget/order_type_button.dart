import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class OrderTypeButton extends StatelessWidget {
  final String? text;
  final String? icon;
  final int index;
  final Color? color;
  final Function? callback;
  final int? numberOfOrder;
  final bool showBorder;
  const OrderTypeButton({Key? key, required this.text,this.icon ,required this.index, required this.callback, required this.numberOfOrder, this.color, this.showBorder = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<OrderProvider>(context, listen: false).setIndex(context,index);
        callback!();},

      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeSmall,
                  horizontal: Dimensions.paddingSizeDefault),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null?
                  SizedBox(width: Dimensions.iconSizeLarge,
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
                      child: Text(numberOfOrder.toString(),
                          style: robotoRegular.copyWith(color : color)),
                    ),
                  )


                ],
              ),
            ),
          ),
          showBorder?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeExtraLarge),
            child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(.2)),
          ):const SizedBox(),
        ],
      ),
    );
  }
}
