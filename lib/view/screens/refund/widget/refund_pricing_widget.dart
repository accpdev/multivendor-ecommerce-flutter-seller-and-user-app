import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/refund_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_divider.dart';
import 'package:sixvalley_vendor_app/view/screens/refund/widget/refund_details.dart';

class RefundPricingWidget extends StatelessWidget {
  const RefundPricingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( bottom: Dimensions.paddingSizeSmall),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        child: Consumer<RefundProvider>(
            builder: (context, refund,_) {
              return Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall),
                child: refund.refundDetailsModel != null?
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                  ProductCalculationItem(title: 'product_price',price: refund.refundDetailsModel!.productPrice,isQ: true, isPositive: true,),

                  const SizedBox(height: Dimensions.paddingSizeSmall,),

                  ProductCalculationItem(title: 'product_discount',price: refund.refundDetailsModel!.productTotalDiscount, isNegative: true,),

                  const SizedBox(height: Dimensions.paddingSizeSmall,),
                  ProductCalculationItem(title: 'coupon_discount',price: refund.refundDetailsModel!.couponDiscount, isNegative: true,),


                  const SizedBox(height: Dimensions.paddingSizeSmall,),
                  ProductCalculationItem(title: 'product_tax',price: refund.refundDetailsModel!.productTotalTax, isPositive: true,),

                  const SizedBox(height: Dimensions.paddingSizeSmall,),
                  ProductCalculationItem(title: 'subtotal',price: refund.refundDetailsModel!.subtotal),

                  const SizedBox(height: Dimensions.paddingSizeSmall,),
                  const CustomDivider(),
                  const SizedBox(height: Dimensions.paddingSizeSmall,),

                  Row(children: [
                    Text('${getTranslated('total_refund_amount', context)}',
                      style: robotoMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeDefault),),
                    const Spacer(),
                    Text(PriceConverter.convertPrice(context,
                        refund.refundDetailsModel!.refundAmount),
                      style: robotoMedium.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),),
                  ],),


                ]):const SizedBox(),);}),
      ),
    );
  }
}
