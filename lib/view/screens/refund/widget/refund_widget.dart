import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/refund_details_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/refund_attachment_list.dart';

class RefundWidget extends StatelessWidget {
  final RefundModel? refundModel;
  final bool isDetails;
  const RefundWidget({Key? key, required this.refundModel, this.isDetails = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDetails? null:() => Navigator.push(context, MaterialPageRoute(builder: (_) => RefundDetailsScreen(
          refundModel: refundModel, orderDetailsId: refundModel!.orderDetailsId,
          variation: refundModel!.orderDetails!.variant))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeMedium),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            boxShadow: [BoxShadow(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor.withOpacity(0):
            Theme.of(context).hintColor.withOpacity(.25), blurRadius: 2, spreadRadius: 2, offset: const Offset(1,2))]
          ),

          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeMedium, vertical: Dimensions.paddingSizeSmall),
              decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.paddingSizeSmall),
                  topLeft: Radius.circular(Dimensions.paddingSizeSmall),
                  bottomRight: Radius.circular(Dimensions.paddingSizeVeryTiny),
                  bottomLeft: Radius.circular(Dimensions.paddingSizeVeryTiny),
              )
            ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.05),
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                    ),
                    child: Row(
                      children: [
                        Text('${getTranslated('order_no', context)}# ',
                          style: robotoRegular.copyWith(color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeLarge),),

                        Text(' ${refundModel!.orderId.toString()}',
                          style: robotoMedium.copyWith(color: ColorResources.getTextColor(context),
                              fontSize: Dimensions.fontSizeLarge),),
                      ],
                    ),
                  ),

                  refundModel!.product != null?
                  Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                    decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                  ),
                    child: Text(PriceConverter.convertPrice(context, refundModel!.product?.unitPrice),
                      style: robotoMedium.copyWith(color: Colors.white,
                          fontSize: Dimensions.fontSizeLarge)),
                  ):const SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeMedium,bottom: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeMedium),
              child: Text('${getTranslated('requested_on', context)} : ${DateConverter.localDateToIsoStringAMPM(DateTime.parse(refundModel!.createdAt!))}',
                  style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOrder, vertical: Dimensions.paddingSizeSmall),

              child: refundModel != null ?
              Row(children: [
                refundModel!.product != null?
                Container(
                  width: Dimensions.stockOutImageSize, height: Dimensions.stockOutImageSize,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall),),
                    child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.productThumbnailUrl}/'
                        '${refundModel!.product!.thumbnail}',)

                  ) ,
                ):const SizedBox(),
                const SizedBox(width: Dimensions.paddingSizeSmall),

                Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                  refundModel!.product != null?
                  Text(refundModel!.product!.name.toString(),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)):const SizedBox(),
                  refundModel!.product != null?
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,):const SizedBox(),

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
                    Text(refundModel!.order != null? getTranslated(refundModel!.order!.paymentMethod, context)!:'',
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).hintColor)),
                  ],),
                ],),),
              ],
              ):const SizedBox(),
            ),

            Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall,Dimensions.paddingSizeDefault),
              child: isDetails?
              Column(mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,children: [
                Text('${getTranslated('reason', context)}: ',
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),

                Text( refundModel!.refundReason!,overflow: TextOverflow.ellipsis,
                    maxLines: isDetails? 50 : 1,
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
              ],):
              Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                Text('${getTranslated('reason', context)}: ',
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),

                Expanded(
                  child: Text( refundModel!.refundReason!,overflow: TextOverflow.ellipsis,
                      maxLines: isDetails? 50 : 1,
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                ),
              ],),
            ),

            refundModel!.images != null && refundModel!.images!.isNotEmpty && isDetails?
            RefundAttachmentList(refundModel: refundModel) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
