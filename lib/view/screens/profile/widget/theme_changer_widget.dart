import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/bank_info/bank_info_view.dart';
import 'package:sixvalley_vendor_app/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/settings/order_wise_shipping_list_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/settings/setting_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/shipping/category_wise_shipping.dart';
import 'package:sixvalley_vendor_app/view/screens/shipping/widget/product_wise_shipping.dart';

class ThemeChanger extends StatelessWidget {
  const ThemeChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context),),
        height : Dimensions.profileCardHeight,
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
          child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [SizedBox(width: Dimensions.iconSizeDefault, height: Dimensions.iconSizeDefault,
                child: Image.asset(Images.dark)),
              const SizedBox(width: Dimensions.paddingSizeSmall,),

              Text(!Provider.of<ThemeProvider>(context).darkTheme?
              '${getTranslated('dark_theme', context)}':'${getTranslated('light_theme', context)}',
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
              const Expanded(child: SizedBox()),

              FlutterSwitch(width: 50.0, height: 28.0, toggleSize: 20.0,
                value: !Provider.of<ThemeProvider>(context).darkTheme,
                borderRadius: 20.0,
                activeColor: Theme.of(context).primaryColor.withOpacity(.5),
                padding: 3.0,
                activeIcon: Image.asset(Images.darkMode, width: 30,height: 30, fit: BoxFit.scaleDown),
                inactiveIcon: Image.asset(Images.lightMode, width: 30,height: 30,fit: BoxFit.scaleDown,),
                onToggle:(bool isActive) =>Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
              ),
            ],),
        ),
      ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

        Provider.of<SplashProvider>(context, listen: false).configModel!.shippingMethod == 'sellerwise_shipping'?
        SectionItemWidget(icon: Images.box, title: 'shipping_method',
          onTap: (){
          if(Provider.of<ShippingProvider>(context, listen: false).selectedShippingType == "category_wise"){
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CategoryWiseShippingScreen()));
          }else if(Provider.of<ShippingProvider>(context, listen: false).selectedShippingType == "order_wise"){
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OrderWiseShippingScreen()));
          }else{
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProductWiseShipping()));
          }},):const SizedBox(),


        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

        SectionItemWidget(icon: Images.editProfile, title: 'settings',
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>const SettingsScreen()));
          },),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

        SectionItemWidget(icon: Images.bankCard, title: 'bank_info',
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> const BankInfoView()));
          },),

        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

        SectionItemWidget(icon: Images.delete, title: 'delete_account',
            onTap: () => showAnimatedDialog(context, const SignOutConfirmationDialog(isDelete: true), isFlip: true),),


      ],
    );
  }
}

class SectionItemWidget extends StatelessWidget {
  final String? icon;
  final String? title;
  final Function? onTap;
  const SectionItemWidget({Key? key, this.onTap, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context)),
        height: Dimensions.profileCardHeight,
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Row(children: [SizedBox(width: Dimensions.iconSizeDefault, height: Dimensions.iconSizeDefault,
              child: Image.asset(icon!)),
            const SizedBox(width: Dimensions.paddingSizeSmall,),

            Expanded(child: Text(getTranslated(title, context)!,
                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),),


            SizedBox(width: Dimensions.iconSizeDefault,
                child: Icon(Icons.arrow_forward_ios,color: Theme.of(context).primaryColor,size: Dimensions.iconSizeDefault,))
          ],),
        ),
      ),
    );
  }
}
