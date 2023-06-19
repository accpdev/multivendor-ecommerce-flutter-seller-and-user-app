
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

import 'custom_button.dart';
class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final String? description;
  final Function onYesPressed;
  final bool isLogOut;
  final bool refund;
  final Color? color;
  final TextEditingController? note;
  const ConfirmationDialog({Key? key, required this.icon, this.title, this.description, required this.onYesPressed, this.isLogOut = false, this.refund = false, this.note, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(width: 500, child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Image.asset(icon, width: 50, height: 50),
          ),

          title != null ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              title!, textAlign: TextAlign.center,
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: color ?? Colors.red),
            ),
          ) : const SizedBox(),

          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Column(
              children: [
                Text(description??'', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center),
                refund?
                TextFormField(
                  controller: note,
                  decoration: InputDecoration(
                    hintText: getTranslated('note', context),
                  ),
                  textAlign: TextAlign.center,

                ):const SizedBox()
              ],
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

        Consumer<ShippingProvider>(builder: (context, shippingProvider, child) {
          return !shippingProvider.isLoading ? Row(children: [
            Expanded(child: InkWell(
              onTap: () => Navigator.pop(context),
              child: CustomButton(
                btnTxt: getTranslated('no',context),
                backgroundColor: ColorResources.getHint(context),
                isColor: true,
              ),
            )),
            const SizedBox(width: Dimensions.paddingSizeLarge),
            Expanded(child: CustomButton(
              btnTxt: getTranslated('yes',context),
              onTap: () =>  onYesPressed(),
            )),

          ]) : const Center(child: CircularProgressIndicator());
        }),
      ])),
    ));
  }
}