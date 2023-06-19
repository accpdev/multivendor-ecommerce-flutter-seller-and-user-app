import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class OrderChangeLogWidget extends StatelessWidget {
  final int? orderId;
  const OrderChangeLogWidget({Key? key, this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<DeliveryManProvider>(context, listen: false).getDeliveryManOrderHistoryLogList(context, orderId);

    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall))),
      child: Consumer<DeliveryManProvider>(
        builder: (context, changelog,_) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
              boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!,
                  spreadRadius: 0.5, blurRadius: 0.3)],),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
                  vertical: Dimensions.paddingSizeSmall),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                Text('${getTranslated('history_of_order_no', context)} : $orderId',
                    style: titilliumBold.copyWith(color: ColorResources.getTextColor(context))),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: changelog.changeLogList.length,
                      itemBuilder: (context,index) {

                        return Row(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Expanded(flex: 2, child:Column(crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center, children: [
                                Container(
                                  width: 30,height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeLarge),
                                    color: Theme.of(context).primaryColor,),
                                  child: Icon(Icons.info_outline,size: Dimensions.iconSizeDefault,
                                    color: Theme.of(context).cardColor,),
                                ),

                                index == changelog.changeLogList.length-1? const SizedBox():
                                Container(height : 60,width: 2, color: Theme.of(context).primaryColor,),

                              ],)),


                            Expanded(flex:6,
                              child: Container(margin: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall,
                                  right: Dimensions.paddingSizeExtraSmall),

                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                                  Text(getTranslated(changelog.changeLogList[index].status, context)!,
                                      style: robotoMedium.copyWith(color: ColorResources.getTextColor(context))),



                                  Text(changelog.changeLogList[index].userType ?? '',
                                      style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

                                  Text(DateConverter.isoStringToDateTimeString(changelog.changeLogList[index].createdAt!),
                                      style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

                                ]),
                              ),
                            ),
                          ],
                        );
                      }
                  ),
                ),
              ],
              ),
            ),
          );
        }
      ),
    );
  }
}
