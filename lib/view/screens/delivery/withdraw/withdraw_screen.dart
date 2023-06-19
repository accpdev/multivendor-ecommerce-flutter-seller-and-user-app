import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/delivery_man_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/screens/delivery/withdraw/withdraw_list.dart';



class DeliveryManWithdrawScreen extends StatefulWidget {
  const DeliveryManWithdrawScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryManWithdrawScreen> createState() => _DeliveryManWithdrawScreenState();
}

class _DeliveryManWithdrawScreenState extends State<DeliveryManWithdrawScreen> {

  @override
  void initState() {
    Provider.of<DeliveryManProvider>(context, listen: false).getDeliveryManWithdrawList(1, 'all');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('withdraw_list', context),isBackButtonExist: true,),
      body: RefreshIndicator(
        onRefresh: () async{
        },
        child: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                    child: SizedBox(
                      height: 40,
                      child: ListView(

                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          WithdrawTypeButton(text: getTranslated('all', context), index: 0),
                          const SizedBox(width: 5),
                          WithdrawTypeButton(text: getTranslated('pending', context), index: 1),
                          const SizedBox(width: 5),
                          WithdrawTypeButton(text: getTranslated('accepted', context), index: 2),
                          const SizedBox(width: 5),
                          WithdrawTypeButton(text: getTranslated('denied', context), index: 3),
                          const SizedBox(width: 5),



                        ],
                      ),
                    ),
                  ),

                  const WithdrawListView(),
                ],
              ),
            )
          ],
        ),),
    );
  }
}


class WithdrawTypeButton extends StatelessWidget {
  final String? text;
  final int index;
  const WithdrawTypeButton({Key? key, required this.text, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Provider.of<DeliveryManProvider>(context, listen: false).setIndex(context, index);
        },
        child: Consumer<DeliveryManProvider>(builder: (context, order, child) {
          return Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: order.withdrawTypeIndex == index ? Theme.of(context).primaryColor : ColorResources.getButtonHintColor(context),
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeLarge),
            ),
            child: Text(text!, style: order.withdrawTypeIndex == index ? titilliumBold.copyWith(color: order.withdrawTypeIndex == index
                ? ColorResources.getWhite(context) : ColorResources.getTextColor(context)):
            robotoRegular.copyWith(color: order.withdrawTypeIndex == index
                ? ColorResources.getWhite(context) : ColorResources.getTextColor(context))),
          );
        },
        ),
      ),
    );
  }
}