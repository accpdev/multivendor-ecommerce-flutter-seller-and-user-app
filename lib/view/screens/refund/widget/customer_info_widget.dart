import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';

class CustomerInfoWidget extends StatelessWidget {
  final RefundModel? refundModel;
  const CustomerInfoWidget({Key? key, this.refundModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeMedium),
      decoration: BoxDecoration(color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!,
            spreadRadius: 0.5, blurRadius: 0.3)],),


      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(getTranslated('customer_information', context)!,
            style: robotoMedium.copyWith(color: ColorResources.getTextColor(context))),
        const SizedBox(height: Dimensions.paddingSizeMedium),

        Row(children: [ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CustomImage(width: 50, height: 50,
              image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${refundModel!.customer!.image}')),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${refundModel!.customer!.fName ?? ''} ${refundModel!.customer!.lName ?? ''}',
                style: robotoMedium.copyWith(color: ColorResources.getTextColor(context),
                    fontSize: Dimensions.fontSizeDefault)),

            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

            Text('${refundModel!.customer!.phone}',
                style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeDefault)),

            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

            Text(refundModel!.customer!.email ?? '',
                style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                    fontSize: Dimensions.fontSizeDefault)),

          ],
          ))
        ],
        )
      ]),);
  }
}
