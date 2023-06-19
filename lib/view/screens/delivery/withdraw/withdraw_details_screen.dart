import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/delivery_man_withdraw_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_loader.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/withdraw/withdraw_approve_deny_widget.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/withdraw/withdraw_card.dart';

class WithdrawDetailsScreen extends StatefulWidget {
  final Withdraws? withdraw;
  final int? index;
  const WithdrawDetailsScreen({Key? key, this.withdraw, this.index}) : super(key: key);

  @override
  State<WithdrawDetailsScreen> createState() => _WithdrawDetailsScreenState();
}

class _WithdrawDetailsScreenState extends State<WithdrawDetailsScreen> {
  @override
  void initState() {
    Provider.of<DeliveryManProvider>(context, listen: false).getDeliveryManWithdrawDetails(context, widget.withdraw!.id);
    super.initState();
  }
  final TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: getTranslated('withdraw_details', context),isBackButtonExist: true),
        body: Consumer<DeliveryManProvider>(
          builder: (context, deliveryManProvider, _) {
            return deliveryManProvider.details != null && deliveryManProvider.details!.deliveryMen != null?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                  child: WithdrawCardWidget(withdraw: widget.withdraw, isDetails: true),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeMedium),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1,spreadRadius: 1,offset: const Offset(1,2))]


                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                      Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeExtraSmall),topRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),
                            color: Theme.of(context).cardColor,
                            boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.05), blurRadius: 1, spreadRadius: 1, offset: const Offset(0,1))]
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: '${getTranslated('delivery_man_info', context)}', style: robotoRegular),
                              ],
                            ),
                          ),


                        ],),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),
                      InfoItem(icon: Images.personIcon, title: '${deliveryManProvider.details!.deliveryMen!.fName!} ${deliveryManProvider.details!.deliveryMen!.fName!}'),
                      InfoItem(icon: Images.callIcon, title: deliveryManProvider.details!.deliveryMen!.phone),
                      InfoItem(icon: Images.emailIcon, title: deliveryManProvider.details!.deliveryMen!.email),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),

                    ],),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeMedium),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.125), blurRadius: 1,spreadRadius: 1,offset: const Offset(1,2))]


                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

                      Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeExtraSmall),topRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),
                            color: Theme.of(context).cardColor,
                            boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.05), blurRadius: 1, spreadRadius: 1, offset: const Offset(0,1))]
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: '${getTranslated('bank_info', context)}', style: robotoRegular),


                              ],
                            ),
                          ),


                        ],),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),
                      InfoItem(icon: Images.personIcon, title: '${getTranslated('account_holder', context)} : ${deliveryManProvider.details!.deliveryMen!.holderName??getTranslated('no_data_found', context)}'),
                      InfoItem(icon: Images.creditCard, title: '${getTranslated('account_number', context)} ${deliveryManProvider.details!.deliveryMen!.accountNo??getTranslated('no_data_found', context)}',),
                      InfoItem(icon: Images.bank, title: '${getTranslated('bank_name', context)} : ${deliveryManProvider.details!.deliveryMen!.bankName??getTranslated('no_data_found', context)}' ),
                      InfoItem(icon: Images.branchIcon, title: '${getTranslated('branch_name', context)} : ${deliveryManProvider.details!.deliveryMen!.branch??getTranslated('no_data_found', context)}'),

                      const SizedBox(height: Dimensions.paddingSizeSmall,),

                    ],),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Row(children: [
                    Expanded(child: CustomButton(
                      btnTxt: getTranslated('deny', context),
                      backgroundColor: Theme.of(context).colorScheme.error.withOpacity(.125),
                      fontColor: Theme.of(context).colorScheme.error,
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ApproveAndDenyWidget(icon: Images.denyW,
                                note: noteController,
                                title : getTranslated('deny_this_withdraw_request', context),
                                onYesPressed: () {
                              deliveryManProvider.deliveryManWithdrawApprovedDenied(context, widget.withdraw!.id, noteController.text.trim(), 2, widget.index);
                            }

                            );
                          },
                        );
                      },
                    )),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(child: CustomButton(
                      btnTxt: getTranslated('approve', context),
                      backgroundColor: Colors.green[700],
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ApproveAndDenyWidget(icon: Images.approveW,
                                note: noteController,
                                isApprove: true,
                                title : getTranslated('approve_this_withdraw_request', context),
                                onYesPressed: () {
                                  deliveryManProvider.deliveryManWithdrawApprovedDenied(context, widget.withdraw!.id, noteController.text.trim(), 1, widget.index);
                                }

                            );
                          },
                        );
                      },
                    )),
                  ],),
                )


              ],
            ):
            const CustomLoader()
            ;
          }
        ));
  }
}

class InfoItem extends StatelessWidget {
  final String? icon;
  final String? title;
  const InfoItem({Key? key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingEye),
      child: Row(children: [
        SizedBox(width: Dimensions.iconSizeSmall, child: Image.asset(icon!, color: Theme.of(context).primaryColor,)),
        const SizedBox(width: Dimensions.paddingSizeDefault,),

        Expanded(
          child: Text(title??'', style: robotoRegular.copyWith(),maxLines: 1,
            overflow: TextOverflow.ellipsis,),
        )
      ],),
    );
  }
}
