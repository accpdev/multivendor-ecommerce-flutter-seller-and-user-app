import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';

class DeliveryManContactInformation extends StatelessWidget {
  final String? orderType;
  final Order? orderModel;
  final bool? onlyDigital;
  const DeliveryManContactInformation({Key? key, this.orderModel, this.orderType, this.onlyDigital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeMedium),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: ThemeShadow.getShadow(context)

          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(getTranslated('deliveryman_information', context)!,
                style: robotoMedium.copyWith(color: ColorResources.titleColor(context),
                  fontSize: Dimensions.fontSizeLarge,)),
            const SizedBox(height: Dimensions.paddingSizeDefault),


            Row(children: [ClipRRect(borderRadius: BorderRadius.circular(50),
                child: CustomImage( height: 50,width: 50, fit: BoxFit.cover,
                    image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.deliveryManImageUrl}/${orderModel!.deliveryMan!.image}')),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${orderModel!.deliveryMan!.fName ?? ''} ''${orderModel!.deliveryMan!.lName ?? ''}',
                    style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)),

                const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                Text('${orderModel!.deliveryMan!.phone}',
                    style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)),


                const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                Text(orderModel!.deliveryMan!.email ?? '',
                    style: titilliumRegular.copyWith(color: ColorResources.titleColor(context),
                        fontSize: Dimensions.fontSizeDefault)),

              ],))
            ],
            )
          ]),
        ),
      ],
    );
  }
}
