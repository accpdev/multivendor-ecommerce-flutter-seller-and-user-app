import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/repository/ratting_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/image_diaglog.dart';


class ReviewWidget extends StatelessWidget {
  final int? index;
  final Reviews? reviewModel;
  final bool? isDetails;
  const ReviewWidget({Key? key, required this.reviewModel, this.isDetails = false, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeExtraSmall),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!,
          spreadRadius: 0.5, blurRadius: 0.3)],
        ),

        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                    child: Container(
                      width: Dimensions.stockOutImageSize,
                      height: Dimensions.stockOutImageSize,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
                        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!,
                            spreadRadius: 0.5, blurRadius: 0.3)],

                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
                        child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).
                          baseUrls!.productThumbnailUrl}/${reviewModel!.product!.thumbnail}',)

                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(getTranslated(reviewModel!.product!.productType, context)!, style: robotoRegular.copyWith(color: Theme.of(context).primaryColor),),
                ],
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

            Flexible(flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    reviewModel!.customer != null?
                    Text('${reviewModel!.customer!.fName ?? ''}' '${reviewModel!.customer!.lName ?? ''}',
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                        maxLines: 1, overflow: TextOverflow.ellipsis):const SizedBox(),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                    Text(reviewModel!.product!.name ?? '',
                        style: robotoRegular.copyWith(color: ColorResources.titleColor(context)),
                        maxLines: 1, overflow: TextOverflow.ellipsis),



                    Row(children: [
                      Icon(Icons.star, color: Provider.of<ThemeProvider>(context).darkTheme ?
                          Colors.white : Colors.orange, size: Dimensions.iconSizeDefault),

                      Text('${reviewModel!.rating!.toDouble().toStringAsFixed(1)}/5'),

                      const Spacer(),


                      Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(reviewModel!.createdAt!)),)

                    ]),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                    Text(reviewModel!.comment ?? '',
                      style: robotoHintRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                      maxLines: isDetails! ? 100: 2, overflow: TextOverflow.ellipsis,),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                    (reviewModel!.attachment != null && reviewModel!.attachment!.isNotEmpty) ? Padding(
                      padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: reviewModel!.attachment!.length,
                          itemBuilder: (context, index) {
                            String imageUrl = '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.reviewImageUrl}/review/${reviewModel!.attachment![index]}';
                            return InkWell(
                              onTap: () => showDialog(context: context, builder: (ctx) =>
                                  ImageDialog(imageUrl:imageUrl), ),
                              child: Container(
                                margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholderImage, height: 40, width: 40, fit: BoxFit.cover,
                                    image: imageUrl,
                                    imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholderImage, height: 40, width: 40, fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ) : const SizedBox(),


                  ],),
              ),
            )

          ],),
      ),
    );

  }
}
