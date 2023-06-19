import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/home/widget/order_type_button_head.dart';

class OngoingOrderWidget extends StatelessWidget {
  final Function? callback;
  const OngoingOrderWidget({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order, child) {
        return Container(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(color: ColorResources.getPrimary(context).withOpacity(.05),
                  spreadRadius: -3, blurRadius: 12, offset: Offset.fromDirection(0,6))],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeMedium),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(width: Dimensions.iconSizeLarge,height: Dimensions.iconSizeLarge ,
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                      child: Image.asset(Images.monthlyEarning)),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),

                  Text(getTranslated('business_analytics', context)!, style: robotoBold.copyWith(
                      color: ColorResources.getTextColor(context),
                      fontSize: Dimensions.fontSizeDefault),),

                  const Expanded(child: SizedBox(width: Dimensions.paddingSizeExtraLarge,)),
                  Container(
                    height: 50,width: 120,
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(width: .7,color: Theme.of(context).hintColor.withOpacity(.3)),
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),

                    ),
                    child: DropdownButton<String>(
                      value: order.analyticsIndex == 0 ? 'overall' : order.analyticsIndex == 1 ?  'today' : 'this_month',
                      items: <String>['overall', 'today', 'this_month' ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(getTranslated(value, context)!, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        order.setAnalyticsFilterName(context,value, true);
                       order.setAnalyticsFilterType(value == 'overall' ? 0 : value == 'today'? 1:2, true);

                      },
                      isExpanded: true,
                      underline: const SizedBox(),
                    ),
                  ),

                ],),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Padding(
              padding: const EdgeInsets.fromLTRB( Dimensions.paddingSizeDefault,
                   Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeDefault,Dimensions.paddingSeven),
              child: Text(getTranslated('on_going_orders', context)!,
                style: robotoBold.copyWith(color: Theme.of(context).primaryColor),),
            ),

            order.orderModel != null ?
            Consumer<OrderProvider>(
              builder: (context, orderProvider, child) => Padding(
                padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,0, Dimensions.paddingSizeSmall,Dimensions.fontSizeSmall),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: (1 / .65),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    OrderTypeButtonHead(
                      color: ColorResources.mainCardOneColor(context),
                      text: getTranslated('pending', context), index: 1,
                      subText: getTranslated('orders', context),
                      numberOfOrder: orderProvider.businessAnalyticsFilterData?.pending, callback: callback,
                    ),


                    OrderTypeButtonHead(
                      color: ColorResources.mainCardTwoColor(context),
                      text: getTranslated('processing', context), index: 2,
                      numberOfOrder: orderProvider.businessAnalyticsFilterData?.processing, callback: callback,
                      subText: getTranslated('orders', context),

                    ),


                    OrderTypeButtonHead(
                      color: ColorResources.mainCardThreeColor(context),
                      text: getTranslated('confirmed', context), index: 7,
                      subText: getTranslated('orders', context),
                      numberOfOrder: orderProvider.businessAnalyticsFilterData?.confirmed, callback: callback,
                    ),


                    OrderTypeButtonHead(
                      color: ColorResources.mainCardFourColor(context),
                      text: getTranslated('out_for_delivery', context), index: 8,
                      subText: '',
                      numberOfOrder: orderProvider.businessAnalyticsFilterData?.outForDelivery, callback: callback,
                    ),
                  ],
                ),
              ),
            ) : SizedBox(height: 150,
                child: Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)))),
            const SizedBox(height: Dimensions.paddingSizeSmall),
          ],),);
      }
    );
  }
}
