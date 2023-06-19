import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/cart_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_field_with_title.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';


class ExtraDiscountAndCouponDialog extends StatelessWidget {
  const ExtraDiscountAndCouponDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Consumer<CartProvider>(
        builder: (context, cartController, _) {
          return Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:CrossAxisAlignment.start,children: [



              Consumer<CartProvider>(
              builder: (context,cartController,_) {
                return Container(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, 0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(getTranslated('discount_type', context)!,
                      style: robotoRegular.copyWith(),),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        border: Border.all(width: .7,color: Theme.of(context).hintColor.withOpacity(.3)),
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),

                      ),
                      child: DropdownButton<String>(
                        value: cartController.discountTypeIndex == 0 ?'amount'  :  'percent',
                        items: <String>['amount','percent'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(getTranslated(value, context)!),
                          );
                        }).toList(),
                        onChanged: (value) {
                          cartController.setSelectedDiscountType(value);
                          cartController.setDiscountTypeIndex(value == 'amount' ? 0 : 1, true);

                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                  ]),
                );
              }
            ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              CustomFieldWithTitle(
              customTextField: CustomTextField(hintText: getTranslated('discount_hint', context),
                controller: cartController.extraDiscountController,
                textInputType: TextInputType.number,
                border: true,
                maxSize: cartController.discountTypeIndex == 1? 2 : null,

              ),
              title: cartController.discountTypeIndex == 1?
              getTranslated('discount_percentage', context):
                getTranslated('discount_amount', context),
              requiredField: true,
            ),

              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Row(children: [
                  Expanded(child: CustomButton(btnTxt: getTranslated('cancel', context),
                      backgroundColor: Theme.of(context).hintColor,
                      onTap: ()=>Navigator.pop(context))),
                  const SizedBox(width: Dimensions.paddingSizeDefault),
                  Expanded(child: CustomButton(btnTxt: getTranslated('apply', context),
                  onTap: (){
                    cartController.applyCouponCodeAndExtraDiscount(context);
                    Navigator.pop(context);
                  },)),
                ],),
              )
          ],),);
        }
      ),
    );
  }
}
