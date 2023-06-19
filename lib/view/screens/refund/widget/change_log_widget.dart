import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/refund_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class ChangeLogWidget extends StatelessWidget {
  final RefundProvider? refundReq;
  const ChangeLogWidget({Key? key, this.refundReq}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!,
            spreadRadius: 0.5, blurRadius: 0.3)],),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeSmall),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(getTranslated('refund_status_change_log', context)!,
              style: titilliumBold.copyWith(color: ColorResources.getTextColor(context))),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: refundReq!.refundDetailsModel!.refundRequest![0].refundStatus!.length,
                itemBuilder: (context,index) {
                  return Row(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Expanded(flex: 1, child:Column(crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center, children: [
                          Container(
                            width: 40,height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.paddingSizeLarge),
                              color: Theme.of(context).primaryColor,),
                            child: Icon(Icons.info_outline,color: Theme.of(context).cardColor,),
                          ),

                          index == refundReq!.refundDetailsModel!.refundRequest![0].refundStatus!.length-1? const SizedBox():
                          Container(height : 60,width: 2, color: Theme.of(context).primaryColor,),

                        ],)),


                      Expanded(flex:6,
                        child: Container(margin: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall,
                            right: Dimensions.paddingSizeExtraSmall),

                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                            Text('${getTranslated('status', context)} : '
                                '${refundReq!.refundDetailsModel!.refundRequest![0].refundStatus![index].status ?? ''}',
                                style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context),
                                    fontSize: Dimensions.fontSizeDefault)),



                            Text('${getTranslated('updated_by', context)} : '
                                '${refundReq!.refundDetailsModel!.refundRequest![0].refundStatus![index].changeBy ?? ''}',
                                style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context),
                                    fontSize: Dimensions.fontSizeDefault)),

                            Text('${getTranslated('reason', context)} : '
                                '${refundReq!.refundDetailsModel!.refundRequest![0].refundStatus![index].message ?? ''}',
                                maxLines : 4,
                                style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context),
                                    fontSize: Dimensions.fontSizeDefault)),

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
}
