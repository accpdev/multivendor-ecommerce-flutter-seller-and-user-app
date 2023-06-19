import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/refund_model.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'image_diaglog.dart';

class RefundAttachmentList extends StatelessWidget {
  final RefundModel? refundModel;
  const RefundAttachmentList({Key? key, this.refundModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingEye),
      child: SizedBox(height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: refundModel!.images!.length,
          itemBuilder: (BuildContext context, index){
            return refundModel!.images!.isNotEmpty?
            Padding(padding: const EdgeInsets.all(8.0), child: Stack(children: [
              InkWell(onTap: () => showDialog(context: context, builder: (ctx)  =>
                  ImageDialog(imageUrl:'${AppConstants.baseUrl}/storage/app/public/refund/'
                      '${refundModel!.images![index]}'), ),

                child: Container(width: Dimensions.imageSize, height: Dimensions.imageSize, decoration: const BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),),
                  child: ClipRRect(borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.paddingSizeExtraSmall)),
                    child: CustomImage(image: '${AppConstants.baseUrl}/storage/app/public/refund/'
                        '${refundModel!.images![index]}',fit: BoxFit.cover,width: Dimensions.imageSize,height: Dimensions.imageSize),
                  ) ,),
              ),
            ],
            ),
            ):const SizedBox();

          },),
      ),
    );
  }
}
