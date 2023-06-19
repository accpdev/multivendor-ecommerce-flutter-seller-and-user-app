import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/splash_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_pass_textfeild.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:sixvalley_vendor_app/view/screens/forgetPassword/widget/code_picker_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/more/html_view_screen.dart';



class InfoFieldVIew extends StatefulWidget {
  
  final bool isShopInfo;
  const InfoFieldVIew({Key? key, this.isShopInfo = false}) : super(key: key);

  @override
  State<InfoFieldVIew> createState() => _InfoFieldVIewState();
}

class _InfoFieldVIewState extends State<InfoFieldVIew> {
  String? _countryDialCode = "+880";
  String currency = '',  country = '', selectedTimeZone = '';
  @override
  void initState() {
    super.initState();
   _countryDialCode = CountryCode.fromCountryCode(Provider.of<SplashProvider>(context, listen: false).configModel!.countryCode!).dialCode;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (authContext, authProvider, _) {
        return SingleChildScrollView(
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              if(!widget.isShopInfo) Column(children: [


                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Align(alignment: Alignment.center, child:
                  DottedBorder(
                    color: Theme.of(context).hintColor,
                    dashPattern: const [10,5],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(Dimensions.paddingSizeSmall),
                    child: Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                        child: authProvider.sellerProfileImage != null ?  Image.file(File(authProvider.sellerProfileImage!.path),
                          width: 150, height: 150, fit: BoxFit.cover,
                        ) :SizedBox(height: 150,
                          width: 150,
                          child: Image.asset(Images.cameraPlaceholder,scale: 3),
                        ),
                      ),
                      Positioned(
                        bottom: 0, right: 0, top: 0, left: 0,
                        child: InkWell(
                          onTap: () => authProvider.pickImage(true,false, false),
                          child: Container(

                            decoration: BoxDecoration(
                              color: Theme.of(context).hintColor.withOpacity(.08),
                              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                            ),

                          ),
                        ),
                      ),
                    ]),
                  )),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeMedium, bottom: Dimensions.paddingSizeExtraLarge),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getTranslated('profile_image', context)!, style: robotoRegular),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Text('(1:1)', style: robotoRegular.copyWith(color: Theme.of(context).colorScheme.error),),
                    ],
                  ),
                ),


                Container(
                    margin: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeSmall),
                    child: CustomTextField(
                      border: true,
                      hintText: getTranslated('first_name', context),
                      focusNode: authProvider.firstNameNode,
                      nextNode: authProvider.lastNameNode,
                      textInputType: TextInputType.name,
                      controller: authProvider.firstNameController,
                      textInputAction: TextInputAction.next,
                    )),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Container(
                    margin: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeSmall),
                    child: CustomTextField(
                      border: true,
                      hintText: getTranslated('last_name', context),
                      focusNode: authProvider.lastNameNode,
                      nextNode: authProvider.emailNode,
                      textInputType: TextInputType.name,
                      controller: authProvider.lastNameController,
                      textInputAction: TextInputAction.next,
                    )),
                const SizedBox(height: Dimensions.paddingSizeSmall),



                Container(
                    margin: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeSmall),
                    child: CustomTextField(
                      border: true,
                      hintText: getTranslated('email_address', context),
                      focusNode: authProvider.emailNode,
                      nextNode: authProvider.phoneNode,
                      textInputType: TextInputType.emailAddress,
                      controller: authProvider.emailController,
                      textInputAction: TextInputAction.next,
                    )),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                Container(
                  margin: const EdgeInsets.only(left: Dimensions.paddingSizeDefault,
                      right: Dimensions.paddingSizeDefault),
                  child: Row(children: [
                    CodePickerWidget(
                      onChanged: (CountryCode countryCode) {
                        _countryDialCode = countryCode.dialCode;
                        authProvider.setCountryDialCode(_countryDialCode);
                      },
                      initialSelection: _countryDialCode,
                      favorite: [authProvider.countryDialCode!],
                      showDropDownButton: true,
                      padding: EdgeInsets.zero,
                      showFlagMain: true,
                      textStyle: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),

                    ),



                    Expanded(child: CustomTextField(
                      hintText: getTranslated('ENTER_MOBILE_NUMBER', context),
                      controller: authProvider.phoneController,
                      focusNode: authProvider.phoneNode,
                      nextNode: authProvider.passwordNode,
                      isPhoneNumber: true,
                      border: true,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,

                    )),
                  ]),
                ),
                const SizedBox(height: Dimensions.paddingSizeMedium),


                Container(margin: const EdgeInsets.only(left: Dimensions.paddingSizeLarge,
                    right: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeDefault),
                    child: CustomPasswordTextField(
                      border: true,
                      hintTxt: getTranslated('password', context),
                      textInputAction: TextInputAction.next,
                      focusNode: authProvider.passwordNode,
                      nextNode: authProvider.confirmPasswordNode,
                      controller: authProvider.passwordController,
                    )),



                Container(margin: const EdgeInsets.only(left: Dimensions.paddingSizeLarge,
                    right: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeDefault),
                    child: CustomPasswordTextField(
                      border: true,
                      hintTxt: getTranslated('confirm_password', context),
                      textInputAction: TextInputAction.done,
                      focusNode: authProvider.confirmPasswordNode,
                      controller: authProvider.confirmPasswordController,
                    )),
                const SizedBox(height: Dimensions.paddingSizeSmall),


              ],),



              if(widget.isShopInfo)Column(children: [
                Container(margin: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeSmall),
                    child: CustomTextField(
                      border: true,
                      hintText: getTranslated('shop_name', context),
                      focusNode: authProvider.shopNameNode,
                      nextNode: authProvider.shopAddressNode,
                      textInputType: TextInputType.name,
                      controller: authProvider.shopNameController,
                      textInputAction: TextInputAction.next,
                    )),
                const SizedBox(height: Dimensions.paddingSizeSmall),


                Container(margin: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeSmall),
                    child: CustomTextField(
                      border: true,
                      maxLine: 3,
                      hintText: getTranslated('shop_address', context),
                      focusNode: authProvider.shopAddressNode,
                      textInputType: TextInputType.name,
                      controller: authProvider.shopAddressController,
                      textInputAction: TextInputAction.done,
                    )),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge,
                      right: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeDefault),
                  child: Row(
                    children: [

                      Text('${getTranslated('business_or_shop_logo', context)}',
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Align(alignment: Alignment.center, child: DottedBorder(
                  dashPattern: const [10,5],
                  color: Theme.of(context).hintColor,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(Dimensions.paddingSizeSmall),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      child: authProvider.shopLogo != null ?  Image.file(File(authProvider.shopLogo!.path),
                        width: 150, height: 150, fit: BoxFit.cover,
                      ) :SizedBox(height: 150, width: 150,
                          child: Image.asset(Images.cameraPlaceholder, scale: 3)),
                    ),
                    Positioned(
                      bottom: 0, right: 0, top: 0, left: 0,
                      child: InkWell(
                        onTap: () => authProvider.pickImage(false,true, false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).hintColor.withOpacity(.08),
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),

                          ),

                        ),
                      ),
                    ),
                  ]),
                )),

                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeDefault),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getTranslated('image_size', context)!, style: robotoRegular),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Text('(1:1)', style: robotoRegular.copyWith(color: Theme.of(context).colorScheme.error),),
                    ],
                  ),
                ),

                const SizedBox(height: Dimensions.paddingSizeDefault),
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge,
                    right: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeDefault),
                  child: Row(children: [
                      Text('${getTranslated('business_or_shop_banner', context)}',
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Align(alignment: Alignment.center, child: DottedBorder(
                  dashPattern: const [10,5],
                  color: Theme.of(context).hintColor,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(Dimensions.paddingSizeSmall),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      child: authProvider.shopBanner != null ?  Image.file(File(authProvider.shopBanner!.path),
                        width: MediaQuery.of(context).size.width - 40, height: 120, fit: BoxFit.cover,
                      ) :SizedBox(height: 120,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Image.asset(Images.cameraPlaceholder, scale: 3, ),
                      ),
                    ),
                    Positioned(
                      bottom: 0, right: 0, top: 0, left: 0,
                      child: InkWell(
                        onTap: () => authProvider.pickImage(false,false, false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).hintColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),

                          ),

                        ),
                      ),
                    ),
                  ]),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeDefault),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getTranslated('image_size', context)!, style: robotoRegular),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Text('(3:1)', style: robotoRegular.copyWith(color: Theme.of(context).colorScheme.error),),
                    ],
                  ),
                ),



                const SizedBox(height: Dimensions.paddingSizeDefault),
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge,
                      right: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeDefault),
                  child: Row(children: [
                    Text('${getTranslated('store_secondary_banner', context)}',
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  ],
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                Align(alignment: Alignment.center, child: DottedBorder(
                  dashPattern: const [10,5],
                  color: Theme.of(context).hintColor,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(Dimensions.paddingSizeSmall),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      child: authProvider.secondaryBanner != null ?  Image.file(File(authProvider.secondaryBanner!.path),
                        width: MediaQuery.of(context).size.width - 40, height: 120, fit: BoxFit.cover,
                      ) :SizedBox(height: 120,
                        width: MediaQuery.of(context).size.width - 40,
                        child: Image.asset(Images.cameraPlaceholder, scale: 3, ),
                      ),
                    ),
                    Positioned(
                      bottom: 0, right: 0, top: 0, left: 0,
                      child: InkWell(
                        onTap: () => authProvider.pickImage(false,false, false, secondary: true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).hintColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),

                          ),

                        ),
                      ),
                    ),
                  ]),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeDefault),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getTranslated('image_size', context)!, style: robotoRegular),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                      Text('(3:1)', style: robotoRegular.copyWith(color: Theme.of(context).colorScheme.error),),
                    ],
                  ),
                ),




                Container(
                  margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Row(children: [
                      Consumer<AuthProvider>(
                          builder: (context, authProvider, child) => Checkbox(
                              checkColor: ColorResources.white,
                              activeColor: Theme.of(context).primaryColor,
                              value: authProvider.isTermsAndCondition,
                              onChanged: authProvider.updateTermsAndCondition)),

                      InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => HtmlViewScreen(
                          title: getTranslated('terms_and_condition', context),
                          url: Provider.of<SplashProvider>(context, listen: false).configModel!.termsConditions)));
                        },
                          child: Row(children: [
                            Text(getTranslated('i_agree_to_your', context)!),
                            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                            Text(getTranslated('terms_and_condition', context)!,style: robotoMedium),
                          ])),


                    ],),

                    ],
                  ),
                ),

              ],)


            ],
          ),
        );
      }
    );
  }
}
