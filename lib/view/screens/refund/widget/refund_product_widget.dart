import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/refund_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';

class RefundProductWidget extends StatelessWidget {
  final RefundModel? refundModel;
  final String? variation;
  const RefundProductWidget({Key? key, this.refundModel, this.variation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Stack(
          children: [
            Container(width: Dimensions.imageSize, height: Dimensions.imageSize,
              decoration: const BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
                  child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productThumbnailUrl}/'
                      '${refundModel!.product!.thumbnail}',width: Dimensions.imageSize, height: Dimensions.imageSize, fit: BoxFit.cover,)
              ) ,),
          ],
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),


        Consumer<RefundProvider>(
            builder: (context, refund, _) {
              return refund.refundDetailsModel != null ?
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(refundModel!.product!.name.toString(),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context),
                        fontSize: Dimensions.fontSizeDefault),),

                  Row( mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.iconSizeSmall, width: Dimensions.iconSizeSmall,

                        child: Image.asset(Images.orderPendingIcon),),
                      Padding(padding: const EdgeInsets.all(8.0),
                        child: Text(getTranslated(refundModel!.status, context)!,
                            style: robotoRegular.copyWith(color: ColorResources.getPrimary(context))),
                      ),
                    ],
                  ),

                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                  Row(children: [
                    SizedBox(height: Dimensions.iconSizeDefault, width: Dimensions.iconSizeDefault,
                      child: Image.asset(refundModel!.paymentInfo == 'cash_on_delivery'? Images.cashPaymentIcon:
                      refundModel!.paymentInfo == 'pay_by_wallet'? Images.payByWalletIcon : Images.digitalPaymentIcon),),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text( (refundModel!.paymentInfo == 'pay_by_wallet' || refundModel!.paymentInfo == 'cash_on_delivery')?
                    getTranslated(refundModel!.paymentInfo, context)!: getTranslated('digital_payment', context)!,
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
                  ],),

                  (variation != null && variation!.isNotEmpty) ?
                  Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                    child: Text(variation!,
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).disabledColor,)),
                  ) : const SizedBox(),

                ],),):const SizedBox();
            }),]),
    );
  }
}
