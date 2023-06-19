import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/localization_provider.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class OrderTypeButtonHead extends StatelessWidget {
  final String? text;
  final String? subText;
  final Color? color;
  final int index;
  final Function? callback;
  final int? numberOfOrder;
  const OrderTypeButtonHead({Key? key, required this.text,this.subText,this.color ,required this.index, required this.callback, required this.numberOfOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<OrderProvider>(context, listen: false).setIndex(context, index);
        callback!();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),),
        color: color,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Container(alignment: Alignment.center,
                child: Center(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(numberOfOrder.toString(),
                          style: robotoBold.copyWith(color: ColorResources.getWhite(context),
                              fontSize: Dimensions.fontSizeHeaderLarge)),

                      Row(children: [
                          Text(text!, style: robotoRegular.copyWith(color: ColorResources.getWhite(context),
                              fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                          Text(subText!, style: robotoRegular.copyWith(color: ColorResources.getWhite(context))),
                        ],
                      ),



                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Provider.of<LocalizationProvider>(context,listen: false).isLtr?const SizedBox.shrink():const Spacer(),
                Container(width: MediaQuery.of(context).size.width/4,
                  height:MediaQuery.of(context).size.width/4,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(.10),
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(100))
                  ),),
                Provider.of<LocalizationProvider>(context,listen: false).isLtr?const Spacer():const SizedBox.shrink(),
              ],
            )


          ],
        ),
      ),
    );
  }
}
