import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/order_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/show_on_map_dialog.dart';


class OrderTopSection extends StatelessWidget {
  final Order? orderModel;
  final OrderProvider? order;
  final String? orderType;
  final bool onlyDigital;
  const OrderTopSection({Key? key, this.orderModel, this.order, this.orderType, this.onlyDigital = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeMedium),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context)
      ),
      child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [



        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${getTranslated('order_no', context)}#${orderModel!.id}',
                style: titilliumSemiBold.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeLarge),),

              Padding(
                padding: const EdgeInsets.only(left: 2,top: Dimensions.paddingSizeExtraSmall),
                child: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(orderModel!.createdAt!)),
                    style: robotoRegular.copyWith(color: ColorResources.getHint(context),
                        fontSize: Dimensions.fontSizeSmall)),
              ),
            ],
          ),

          orderType != 'POS' || !onlyDigital?
          GestureDetector(
            onTap: (){
              showDialog(context: context, builder: (_){
                return const ShowOnMapDialog();
              });
            },
            child: Row(
              children: [
                Text('${getTranslated('show_on_map', context)}',
                    style: robotoRegular.copyWith()),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                Container(decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: Image.asset(Images.showOnMap, width: Dimensions.iconSizeDefault),
                  ),)

              ],
            ),
          ):const SizedBox(),
        ]),


        const Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          child: Divider(),
        ),


        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                child: Image.asset(Images.paymentIcon,width: Dimensions.iconSizeSmall, ),
              ),
              Text(getTranslated(orderModel!.paymentMethod, context)!,
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
            ],
          ),

          Row(children: [
            CircleAvatar(radius: 6, backgroundColor:order!.paymentStatus =='paid'
                ? Colors.green: Theme.of(context).colorScheme.error),


            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Text(getTranslated(order!.paymentStatus, context)!,
                style: robotoRegular.copyWith(color: order!.paymentStatus =='paid'
                    ? Colors.green: Theme.of(context).colorScheme.error)),
          ],)
        ],),

        Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                child: Image.asset(Images.orderStatusIcon, width: Dimensions.iconSizeSmall ),
              ),
              Text(getTranslated('${orderModel!.orderStatus}', context)!,
                  style: titilliumRegular.copyWith(color: ColorResources.mainCardThreeColor(context))),
            ],
          ),
        ),




      ]),
    );
  }
}
