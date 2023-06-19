 import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/screens/auth/auth_screen.dart';

class SuccessfullyRegisteredScreen extends StatelessWidget {
  const SuccessfullyRegisteredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('shop_application_submission', context)),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(width: 50,child: Image.asset(Images.successIcon)),
        ),
        Text(getTranslated('shop_register_message1', context)!,style: robotoMedium,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(getTranslated('send', context)!,style: robotoMedium),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                child: Text(getTranslated('successfully', context)!,style: robotoMedium.copyWith(color: Colors.green)),
              ),
              Text(getTranslated('to_admin', context)!,style: robotoMedium),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge),
          child: Text(getTranslated('shop_register_message2', context)!),
        ),
      ]),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(),
      height: 70,child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: CustomButton(btnTxt: getTranslated('login', context), onTap: (){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (BuildContext context) => const AuthScreen()), (route) => false);
        },),
      ),),
    );
  }
}
