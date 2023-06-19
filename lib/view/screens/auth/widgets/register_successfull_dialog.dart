import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/auth/auth_screen.dart';

class RegisterSuccessfulWidget extends StatelessWidget {
  const RegisterSuccessfulWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall))),
        child: SizedBox(height: 250,width: 270,child: Stack(children: [

          Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(bottom : Dimensions.paddingSizeDefault),
                child: SizedBox(width: 50,child: Image.asset(Images.successIcon)),
              ),
              Text(getTranslated('shop_register_message1', context)!,style: robotoRegular,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(getTranslated('been_sent', context)!,style: robotoRegular),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(getTranslated('successfully', context)!,style: robotoMedium.copyWith(color: Colors.green[600])),
                    ),
                    Text(getTranslated('to_admin', context)!,style: robotoRegular),
                  ],
                ),
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal : 20),
                child: Text(getTranslated('shop_register_message2', context)!,style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center,),
              ),
            ]),

          Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const AuthScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: SizedBox(width: 18,child: Image.asset(Images.cross)),
            ),
          ),
        ),

      ],
    )));
  }
}
