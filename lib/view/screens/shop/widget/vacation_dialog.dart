
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/shop_info_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:sixvalley_vendor_app/view/screens/shop/widget/vacation_calender.dart';


class VacationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final TextEditingController vacationNote;
  final Function onYesPressed;


  final TextEditingController? note;
  const VacationDialog({Key? key, required this.icon, this.title, required this.vacationNote, required this.onYesPressed, this.note,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
        insetPadding: const EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Consumer<ShopProvider>(
          builder: (context, shop,_) {
            return SizedBox(width: 500, child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Column(mainAxisSize: MainAxisSize.min, children: [


                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeSmall),
                    child: Row(
                      children: [
                        Text(getTranslated('please_select_vacation_date_range', context)!),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: ()=> showDialog(context: context, builder: (_)=> const VacationCalender()),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeDefault),
                        decoration: BoxDecoration(
                            color:  Theme.of(context).primaryColor.withOpacity(.08),
                            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(shop.startDate),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Icon(Icons.arrow_forward_rounded,size: Dimensions.iconSizeDefault,

                                  color:  Theme.of(context).primaryColor),
                            ),
                            Text(shop.endDate),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getTranslated('vacation_note', context)!),
                      const SizedBox(height: Dimensions.paddingSizeSmall,),
                      CustomTextField(border: true,
                        hintText: 'note',
                        maxLine: 2,
                        controller: vacationNote,
                      ),
                    ],
                  ),

                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  Row(children: [
                    Expanded(child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: CustomButton(
                        btnTxt: getTranslated('no',context),
                        backgroundColor: ColorResources.getHint(context),
                        isColor: true,
                      ),
                    )),
                    const SizedBox(width: Dimensions.paddingSizeLarge),
                    Expanded(child: CustomButton(
                      btnTxt: getTranslated('yes',context),
                      onTap: () =>  onYesPressed(),
                    )),

                  ])
                ])),
            );
          }
        ));
  }
}