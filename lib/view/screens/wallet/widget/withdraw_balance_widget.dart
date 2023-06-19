import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_edit_dialog.dart';




class WithdrawBalanceWidget extends StatefulWidget {
  const WithdrawBalanceWidget({Key? key}) : super(key: key);

  @override
  State<WithdrawBalanceWidget> createState() => _WithdrawBalanceWidgetState();
}

class _WithdrawBalanceWidgetState extends State<WithdrawBalanceWidget> {
  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).getWithdrawMethods(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context, listen: false).darkTheme;

    return Column(
      children: [

        Container(
          padding: const EdgeInsets.fromLTRB(0, Dimensions.paddingSizeDefault,0, Dimensions.paddingSizeMedium),

          color: Theme.of(context).cardColor,
          alignment: Alignment.center,
          child:Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.width/2.3,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                  boxShadow: [BoxShadow(color: Colors.grey[darkMode ? 900 : 200]!,
                      spreadRadius: 0.5, blurRadius: 0.3)],
                ),

              ),

              Positioned(left: 0,
                child: Container(width: MediaQuery.of(context).size.width-70,
                  height: MediaQuery.of(context).size.width/2.2,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(.10),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(MediaQuery.of(context).size.width/2.5))
                  ),),
              ),

              Consumer<ProfileProvider>(
                  builder: (context, seller, child) {
                    return Container(
                      height: MediaQuery.of(context).size.width/2.3,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox (
                                  width: Dimensions.logoHeight,
                                  height: Dimensions.logoHeight,
                                  child: Image.asset(Images.cardWhite)),
                              Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(getTranslated('balance_withdraw', context)!,
                                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                          color: Colors.white)),
                                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                                  Text(PriceConverter.convertPrice(context, seller.userInfoModel!.wallet != null ?
                                  seller.userInfoModel!.wallet!.totalEarning ?? 0 : 0),
                                      style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white,
                                          fontSize: Dimensions.fontSizeWithdrawableAmount)),
                                ],
                              ),
                              const SizedBox(width: Dimensions.logoHeight,),
                            ],
                          ),
                          const SizedBox(height: Dimensions.paddingSizeLarge,),
                          InkWell(
                            onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context, builder: (_) => const CustomEditDialog()),
                            child: Container(height: 40,width: 250,
                              decoration: BoxDecoration(color: const Color(0xFFEEF6FF),
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                                InkWell(onTap: () => showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context, builder: (_) => const CustomEditDialog()),
                                  child: Text(getTranslated('send_withdraw_request', context)!,
                                      style:titilliumRegular.copyWith(color: Theme.of(context).primaryColor,
                                          fontSize: Dimensions.fontSizeLarge)),
                                ),

                              ],),
                            ),
                          ),

                        ],
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ],
    );
  }
}
