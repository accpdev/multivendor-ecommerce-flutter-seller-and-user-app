import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/review_model.dart';
import 'package:sixvalley_vendor_app/helper/date_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/base/image_diaglog.dart';
import 'package:sixvalley_vendor_app/view/base/rating_bar.dart';



class ProductReviewItem extends StatelessWidget {

  final ReviewModel reviewModel;
  const ProductReviewItem({Key? key, required this.reviewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = '${Provider.of<SplashProvider>(context, listen: false).configModel!.baseUrls!.customerImageUrl}';
    String review = '${Provider.of<SplashProvider>(context, listen: false).configModel!.baseUrls!.reviewImageUrl}';
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
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
                        if(reviewModel.customer != null)
                        Text("${reviewModel.customer!.fName!} ${reviewModel.customer!.lName!}",
                          style: robotoMedium.copyWith(),
                        ),
                        if(reviewModel.customer == null)
                          Text(getTranslated('customer_not_available', context)!,
                          style: robotoMedium.copyWith(),),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        Row(children: [
                            RatingBar(rating: reviewModel.rating),

                          Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
                            child: Text(reviewModel.rating.toString(),
                              style: robotoRegular.copyWith(color: Theme.of(context).hintColor))),
                          ],
                        ),
                      ])),
              Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(reviewModel.createdAt!)),)
            ],
          ),

          Padding(
              padding: const EdgeInsets.only(left: 2,top : Dimensions.paddingSizeExtraSmall, bottom: Dimensions.paddingSizeDefault),
              child: Text(reviewModel.comment??'',
                style: robotoRegular.copyWith(),
                textAlign: TextAlign.start,
              )),

          reviewModel.attachment!.isNotEmpty?
          SizedBox(height: Dimensions.productImageSize,
            child: ListView.builder(
                itemCount: reviewModel.attachment!.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: () => showDialog(context: context, builder: (ctx) =>
                        ImageDialog(imageUrl:'$review/review/${reviewModel.attachment![index]}')),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      child: Container(decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                          width: Dimensions.productImageSize,height: Dimensions.imageSize,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                            child: CustomImage(image: '$review/review/${reviewModel.attachment![index]}',
                              width: Dimensions.productImageSize,height: Dimensions.productImageSize,),
                          )),
                    ),
                  );
                }),):const SizedBox()

        ],
      ),
    );
  }
}
