import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/shop_info_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/confirmation_dialog.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_dialog.dart';
import 'package:sixvalley_vendor_app/view/base/custom_loader.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/shop_update_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/widget/shop_banner_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/widget/shop_information_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/widget/vacation_dialog.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  ShopScreenState createState() => ShopScreenState();
}

class ShopScreenState extends State<ShopScreen> {
  String sellerId = '0';
  TextEditingController vacationNote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<ShopProvider>(context, listen: false).selectedIndex;
    sellerId = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.id.toString();
    Provider.of<ShopProvider>(context, listen: false).getShopInfo();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title : getTranslated('my_shop', context)),
        body: Consumer<ShopProvider>(
            builder: (context, shopInfo, child) {

              return shopInfo.shopModel != null?
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: ThemeShadow.getShadow(context),
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
                        ),
                        child: Column(mainAxisSize: MainAxisSize.min,children: [
                          ShopBannerWidget(resProvider: shopInfo),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                          ShopInformationWidget(resProvider: shopInfo),



                        ],),
                      ),

                      shopInfo.shopModel != null?
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: ShopSettingWidget(title: 'temporary_close', mode: shopInfo.shopModel?.temporaryClose != null ?
                        shopInfo.shopModel!.temporaryClose == 1: false,
                          onTap: (value){
                          showAnimatedDialog(context, ConfirmationDialog(
                              icon: Images.logo,
                              title: getTranslated('temporary_close_message', context),
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            onYesPressed: (){
                                shopInfo.shopTemporaryClose(context, shopInfo.shopModel!.temporaryClose == 1? 0 : 1);
                            },
                          ),
                            isFlip: true
                          );
                        },),
                      ): const SizedBox(),

                      shopInfo.shopModel != null?
                      Padding(
                        padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                        child: ShopSettingWidget(title: 'vacation', mode: shopInfo.shopModel!.vacationStatus == 1,
                          onTap: (value){
                            if (kDebugMode) {
                              print('--->$value');
                            }
                            showAnimatedDialog(context, ConfirmationDialog(
                              icon: Images.logo,
                              title: getTranslated('vacation_message', context),
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              onYesPressed: (){
                                shopInfo.shopVacation(context,shopInfo.shopModel!.vacationStartDate, shopInfo.shopModel!.vacationEndDate, vacationNote.text, shopInfo.shopModel!.vacationStatus == 1? 0 : 1);
                              },
                            ),
                                isFlip: true
                            );
                          },),
                      ): const SizedBox(),

                      shopInfo.shopModel != null && shopInfo.shopModel!.vacationStatus == 1?
                      ShopSettingWidget(title: 'vacation_date_range', mode: shopInfo.shopModel!.vacationStatus == 1,
                        dateSelection: true,
                        onTap: (value){},
                        onPress: (){
                          showAnimatedDialog(context, VacationDialog(
                            icon: Images.logo,
                            title: getTranslated('vacation_message', context),
                            vacationNote: vacationNote,
                            onYesPressed: (){
                              shopInfo.shopVacation(context, shopInfo.startDate, shopInfo.endDate,vacationNote.text, 1);
                            },
                          ),
                              isFlip: true
                          );
                        },
                      ):const SizedBox(),


                      const SizedBox(height: Dimensions.paddingSizeDefault),

                      if(shopInfo.shopModel != null)
                      ShopBannerWidget(resProvider: shopInfo, fromBottom: true,),

                    ],
                  ),
                ),
              ):const CustomLoader();
            }),
      
      bottomNavigationBar: Container(height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: ThemeShadow.getShadow(context)
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CustomButton(btnTxt: getTranslated('edit_shop_info', context),
            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ShopUpdateScreen()))),
        ),
      ),

    );
  }
}

class ShopSettingWidget extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool? mode;
  final Function(bool value)? onTap;
  final Function? onPress;
  final bool dateSelection;
  const ShopSettingWidget({Key? key, this.title, this.icon, this.mode, this.onTap, this.dateSelection = false, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopProvider>(
      builder: (context, shop,_) {
        return Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
            boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(.25), spreadRadius: 1, blurRadius: 5)]
          ),
          child:
          Row(children: [
            Expanded(child: Text(getTranslated(title, context)!)),
            dateSelection?
            InkWell(onTap: onPress as void Function()?,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor, width: .25),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((shop.shopModel != null && shop.shopModel!.vacationStartDate != null) ? shop.shopModel!.vacationStartDate!:'start_date'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                        child: Icon(Icons.arrow_forward_rounded,size: Dimensions.iconSizeDefault,

                            color:  Theme.of(context).primaryColor),
                      ),
                      Text((shop.shopModel != null && shop.shopModel!.vacationEndDate != null)? shop.shopModel!.vacationEndDate! : 'end_date'),
                    ],
                  ),
                ),
              ),
            ):
            FlutterSwitch(
              value: mode!,
              width: 50,
              height: 27,
              toggleSize: 20,
              padding: 2,
              onToggle: onTap!)

          ],),
        );
      }
    );
  }
}
