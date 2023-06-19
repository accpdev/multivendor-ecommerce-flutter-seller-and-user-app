import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_review_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';



class DeliveryManReviewItem extends StatelessWidget {
  final DeliveryManReview reviewModel;
  const DeliveryManReviewItem({Key? key, required this.reviewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = '${Provider.of<SplashProvider>(context, listen: false).configModel!.baseUrls!.customerImageUrl}';
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall),
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.07), blurRadius: 1,spreadRadius: 1)]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if(reviewModel.customer != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraLarge)),
                    child: SizedBox(
                      width: Dimensions.productImageSize,
                      height: Dimensions.productImageSize,
                      child: CustomImage(image:"$baseUrl/${reviewModel.customer!.image}"),
                    ),
                  ),
                const SizedBox(width: Dimensions.paddingSizeSmall,),

                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reviewModel.customer != null?
                            Text("${reviewModel.customer!.fName!} ${reviewModel.customer!.lName!}",
                              style: robotoMedium.copyWith(),
                            ):Text(getTranslated('customer_not_available', context)!,
                            style: robotoMedium.copyWith(),),


                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                          Row(children: [
                            SizedBox(width: Dimensions.iconSizeSmall,
                                child: Image.asset(Images.ratting)),

                            Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                                child: Text(reviewModel.rating.toString(),
                                    style: robotoRegular.copyWith(color: Theme.of(context).hintColor))),
                          ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall, bottom: Dimensions.paddingSizeExtraSmall),
                            child: Row(children: [
                              Text('${getTranslated('order_id', context)}# '),
                              Text(reviewModel.orderId.toString(),style: robotoBold,),
                            ],),
                          )

                        ])),
                Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(reviewModel.createdAt!)),)
              ],
            ),

            Padding(
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall,top : Dimensions.paddingSizeExtraSmall),
                child: Text(reviewModel.comment!,
                  style: robotoRegular.copyWith(),
                  textAlign: TextAlign.start,
                )),
          ],
        ),
      ),
    );
  }
}
