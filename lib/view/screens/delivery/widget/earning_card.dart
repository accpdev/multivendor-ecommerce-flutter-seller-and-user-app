import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_earning_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_divider.dart';


class EarningCardWidget extends StatelessWidget {
  final Earning earning;
  final int? index;
  const EarningCardWidget({Key? key, required this.earning, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.09),blurRadius: 5, spreadRadius: 1, offset: const Offset(1,2))]
          ),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,children: [

            Padding(
              padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeMedium, horizontal: Dimensions.paddingSizeMedium),
              child: Row(mainAxisAlignment : MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('${getTranslated('order_no', context)}# ',
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
                      Text('${earning.id}',
                        style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
                    ],
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(.125),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall, vertical: Dimensions.paddingEye),
                      child: Text(PriceConverter.convertPrice(context, earning.deliverymanCharge),
                        style: robotoMedium.copyWith(color: Colors.green),),
                    ),),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeMedium),
              child: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(earning.updatedAt!)),
                  style: titilliumRegular.copyWith(color: Theme.of(context).hintColor)),
            ),


            Container(decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(Dimensions.paddingSizeSmall),
                    bottomRight: Radius.circular(Dimensions.paddingSizeSmall))
            ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeMedium),
                child: Column(children: [

                  Row( mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.iconSizeSmall, width: Dimensions.iconSizeSmall,

                        child: Image.asset(Images.orderPendingIcon),),
                      Padding(padding: const EdgeInsets.all(8.0),
                        child: Text(getTranslated(earning.orderStatus, context)!,
                            style: robotoRegular.copyWith(color: ColorResources.getPrimary(context))),
                      ),


                    ],
                  ),

                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                ],),
              ),)
          ],),),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeMedium),
          child: CustomDivider(height: .5,),
        )

      ],
    );
  }
}

