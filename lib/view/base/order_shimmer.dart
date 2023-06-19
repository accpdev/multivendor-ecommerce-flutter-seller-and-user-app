import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class OrderShimmer extends StatelessWidget {
  final bool isEnabled;
  const OrderShimmer({Key? key, required this.isEnabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 10, spreadRadius: 1)],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: isEnabled,
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(' ${getTranslated('order_no', context)} : #', style: titilliumBold.copyWith(color: ColorResources.colorLightBlack,fontSize: 14),),
                  Text('\$0.00', style: titilliumBold.copyWith(color: ColorResources.gainsBro,fontSize: 14)),
                ]
            ),
            Row(children: [
              Text('00:00', style: titilliumRegular.copyWith(color: ColorResources.gainsBro,fontSize: 10)),
              const SizedBox(width: 5),
              const Text('|', style: TextStyle(color: ColorResources.gainsBro),),
              const SizedBox(width: 5),
              Text('1 items : item',
                  style: titilliumRegular.copyWith(color: ColorResources.gainsBro,fontSize: 10)),
            ],),

            Container(height: 2, margin: const EdgeInsets.all(5), color: ColorResources.grey,),

            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: ColorResources.gainsBro,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Name', style: titilliumBold.copyWith(color: ColorResources.gainsBro,fontSize: 15))),
                const Expanded(child: SizedBox()),
                Text('${getTranslated('view_details', context)}', style: titilliumRegular.copyWith(color: ColorResources.gainsBro,fontSize: 12),),
                const Icon(Icons.arrow_forward_outlined, color: ColorResources.gainsBro,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
