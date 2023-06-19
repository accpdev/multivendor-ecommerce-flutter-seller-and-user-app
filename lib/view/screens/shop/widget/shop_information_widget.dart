import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_info_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/custom_loader.dart';



class ShopInformationWidget extends StatelessWidget {
  final ShopProvider? resProvider;
  const ShopInformationWidget({Key? key, this.resProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSize = 90;
    double reviewIconSize = 15;
    return resProvider!.shopModel != null?
    Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeMedium),
      child: Column(
        children: [
          Row(crossAxisAlignment :CrossAxisAlignment.start, children: [
            Column(
              children: [
                Container(
                  transform: Matrix4.translationValues(0, -55, 0),
                  width: imageSize, height: imageSize,
                  decoration: BoxDecoration(
                    boxShadow: ThemeShadow.getShadow(context),
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
                  ),

                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
                    child: CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).
                    baseUrls!.shopImageUrl}/${resProvider!.shopModel?.image}'),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),


              ],
            ),

            const SizedBox(width: Dimensions.paddingSizeMedium),


            Flexible(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(resProvider!.shopModel?.name ?? '',
                  style: robotoBold.copyWith(color: ColorResources.getTextColor(context),
                      fontSize: Dimensions.fontSizeDefault),),
                const SizedBox(height: Dimensions.paddingSizeMedium),

                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: Dimensions.iconSizeDefault,
                        child:Image.asset(Images.shopAddress)),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: Text(resProvider!.shopModel?.address ?? '',
                        style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context)), maxLines: 2,
                        overflow: TextOverflow.ellipsis,softWrap: false,),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeMedium),

                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: Dimensions.iconSizeDefault,
                        child:Image.asset(Images.shopPhone)),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: Text(resProvider!.shopModel?.contact ?? '',
                        style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context)), maxLines: 2,
                        overflow: TextOverflow.ellipsis,softWrap: false,),
                    ),
                  ],
                ),


              ],),),

          ],),

          const SizedBox(height: Dimensions.paddingSizeDefault),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [SizedBox(width: Dimensions.iconSizeSmall, height: Dimensions.iconSizeSmall,
                      child: Image.asset(Images.star)),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


                    Text(resProvider!.shopModel?.ratting?.toDouble().toStringAsFixed(1) ?? '',
                      style: robotoTitleRegular.copyWith(color: ColorResources.getTextColor(context),
                          fontSize: Dimensions.fontSizeExtraLarge),),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                  ],),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    child: SizedBox(width: reviewIconSize,child: Image.asset(Images.shopReview)),
                  ),
                  Row(children: [
                    Text(NumberFormat.compact().format(resProvider!.shopModel?.rattingCount),
                      style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context),
                          fontSize: Dimensions.fontSizeDefault),),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                    Text(getTranslated('reviews', context)!,
                      style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context),
                          fontSize: Dimensions.fontSizeDefault),),
                  ],)
                ],),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    child: SizedBox(width: reviewIconSize,
                        child: Image.asset(Images.shopProduct)),
                  ),
                  Row(children: [


                    Consumer<ProfileProvider>(
                        builder: (context, profile,_) {
                          return Text(NumberFormat.compact().format(profile.userInfoModel!.productCount),
                            style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context),
                                fontSize: Dimensions.fontSizeDefault),);
                        }
                    ),
                    const SizedBox(width: Dimensions.paddingSizeExtraSmall,),


                    Text(getTranslated('products', context)!,
                      style: robotoRegular.copyWith(color: ColorResources.getSubTitleColor(context),
                          fontSize: Dimensions.fontSizeDefault),)
                  ],)
                ],)


            ],),
          )
        ],
      ),
    ):const CustomLoader();
  }
}

