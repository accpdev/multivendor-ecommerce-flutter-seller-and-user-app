import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_bottom_sheet.dart';
import 'package:sixvalley_vendor_app/view/screens/addProduct/add_product_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/chat/inbox_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/coupon/widget/coupon_list_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/dashboard/nav_bar_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/delivery_man_setup.dart';
import 'package:sixvalley_vendor_app/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:sixvalley_vendor_app/view/screens/more/html_view_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/product/product_list_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/profile/profile_view_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/review/product_review_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/settings/setting_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/shop_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/wallet/wallet_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/bank_info/bank_info_view.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomBottomSheet> activateMenu = [
      CustomBottomSheet(image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl}/'
          '${Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.image}',isProfile: true, title: getTranslated('profile', context),

          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreenView()))),

      CustomBottomSheet(image: Images.myShop, title: getTranslated('my_shop', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const ShopScreen()))),

      CustomBottomSheet(image: Images.addProduct, title: getTranslated('add_product', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const AddProductScreen()))),

      CustomBottomSheet(image: Images.productIconPp, title: getTranslated('products', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const ProductListMenuScreen()))),

      CustomBottomSheet(image: Images.reviewIcon, title: getTranslated('reviews', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const ProductReview()))),

      CustomBottomSheet(image: Images.couponIcon, title: getTranslated('coupons', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const CouponListScreen()))),

      if(Provider.of<SplashProvider>(context, listen: false).configModel!.shippingMethod == 'sellerwise_shipping')
      CustomBottomSheet(image: Images.deliveryManIcon, title: getTranslated('deliveryman', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const DeliveryManSetupScreen()))),


      if(Provider.of<SplashProvider>(context, listen: false).configModel!.posActive == 1)
      CustomBottomSheet(image: Images.pos, title: getTranslated('pos', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const NavBarScreen()))),


      CustomBottomSheet(image: Images.settings, title: getTranslated('settings', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const SettingsScreen()))),


      CustomBottomSheet(image: Images.wallet, title: getTranslated('wallet', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const WalletScreen()))),


      CustomBottomSheet(image: Images.message, title: getTranslated('message', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const InboxScreen()))),


      CustomBottomSheet(image: Images.bankingInfo, title: getTranslated('bank_info', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const BankInfoView()))),


      CustomBottomSheet(image: Images.termsAndCondition, title: getTranslated('terms_and_condition', context),

          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
              title: getTranslated('terms_and_condition', context),
              url: Provider.of<SplashProvider>(context, listen: false).configModel!.termsConditions)))),



      CustomBottomSheet(image: Images.aboutUs, title: getTranslated('about_us', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
            title: getTranslated('about_us', context),
            url: Provider.of<SplashProvider>(context, listen: false).configModel!.aboutUs,)))),


      CustomBottomSheet(image: Images.privacyPolicy, title: getTranslated('privacy_policy', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
              title: getTranslated('privacy_policy', context),
              url: Provider.of<SplashProvider>(context, listen: false).configModel!.privacyPolicy)))),


      if(Provider.of<SplashProvider>(context, listen: false).configModel!.refundPolicy!.status ==1)
      CustomBottomSheet(image: Images.refundPolicy, title: getTranslated('refund_policy', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
              title: getTranslated('refund_policy', context),
              url: Provider.of<SplashProvider>(context, listen: false).configModel!.refundPolicy!.content)))),


      if(Provider.of<SplashProvider>(context, listen: false).configModel!.returnPolicy!.status ==1)
      CustomBottomSheet(image: Images.returnPolicy, title: getTranslated('return_policy', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
            title: getTranslated('return_policy', context),
            url: Provider.of<SplashProvider>(context, listen: false).configModel!.returnPolicy!.content)))),


      if(Provider.of<SplashProvider>(context, listen: false).configModel!.cancellationPolicy!.status ==1)
      CustomBottomSheet(image: Images.cPolicy, title: getTranslated('cancellation_policy', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> HtmlViewScreen(
            title: getTranslated('cancellation_policy', context),
            url: Provider.of<SplashProvider>(context, listen: false).configModel!.returnPolicy!.content)))),


      CustomBottomSheet(image: Images.logOut, title: getTranslated('logout', context),
          onTap: ()=> showCupertinoModalPopup(context: context, builder: (_) => const SignOutConfirmationDialog())),

      CustomBottomSheet(image: Images.appInfo, title: 'v - ${AppConstants.appVersion}',
          onTap: (){}),
    ];


    return  Container(
      decoration: BoxDecoration(
        color: ColorResources.getHomeBg(context),
        borderRadius: const BorderRadius.only(
            topLeft:  Radius.circular(25),
            topRight: Radius.circular(25)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: Icon(Icons.keyboard_arrow_down_outlined,color: Theme.of(context).hintColor,
              size: Dimensions.iconSizeLarge,),
          ),

          const SizedBox(height: Dimensions.paddingSizeVeryTiny),
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: activateMenu,
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
