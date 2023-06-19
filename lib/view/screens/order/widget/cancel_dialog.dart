
import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/dashboard/dashboard_screen.dart';

class CancelDialog extends StatelessWidget {
  const CancelDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorResources.getBottomSheetColor(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        const SizedBox(height: 20),
        CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.error, size: 50),
        ),

        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Text(getTranslated('are_you_sure', context)!, style: titilliumBold.copyWith(color: Theme.of(context).primaryColor, fontSize: 18), textAlign: TextAlign.center),
        ),

        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Text(getTranslated('you_want_to_cancel', context)!,
              style: titilliumSemiBold.copyWith(color: ColorResources.getGreyBunkerColor(context)), textAlign: TextAlign.center),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        Row(children: [

          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              alignment: Alignment.center,
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text(getTranslated('no', context)!, style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
            ),
          )),

          Expanded(child: InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const DashboardScreen()), (route) => false);
              },
            child: Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: ColorResources.getPrimary(context), borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text(getTranslated('yes', context)!, style: titilliumBold.copyWith(color: ColorResources.getBottomSheetColor(context))),
            ),
          )),

        ]),
      ]),
    );
  }
}
