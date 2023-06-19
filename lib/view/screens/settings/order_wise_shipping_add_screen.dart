import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/response/shipping_model.dart';
import 'package:sixvalley_vendor_app/helper/price_converter.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/shipping_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';
import 'package:sixvalley_vendor_app/view/screens/settings/order_wise_shipping_list_screen.dart';


class OrderWiseShippingAddScreen extends StatefulWidget {
  final ShippingModel? shipping;
  const OrderWiseShippingAddScreen({Key? key, this.shipping}) : super(key: key);
  @override
  OrderWiseShippingAddScreenState createState() => OrderWiseShippingAddScreenState();
}

class OrderWiseShippingAddScreenState extends State<OrderWiseShippingAddScreen> {

  TextEditingController? _titleController ;
  TextEditingController? _durationController ;
  TextEditingController? _costController ;

  final FocusNode _resNameNode = FocusNode();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  GlobalKey<FormState>? _formKeyLogin;
  ShippingModel? shipping;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _durationController = TextEditingController();
    _costController = TextEditingController();
    shipping = ShippingModel();
  }

  @override
  void dispose() {
    _titleController!.dispose();
    _durationController!.dispose();
    _costController!.dispose();
    super.dispose();
  }
  void callback(bool route, String error ){
    if(route){
      if(widget.shipping==null){
        showCustomSnackBar(getTranslated('shipping_method_added_successfully', context)!, context, isError: false);
        Navigator.of(context).pop();
      }else{
        showCustomSnackBar(getTranslated('shipping_method_update_successfully', context)!, context, isError: false);
        Navigator.of(context).pop();
      }

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const OrderWiseShippingScreen()));

    }else{
      showCustomSnackBar(error,context);
    }

}

  @override
  Widget build(BuildContext context) {
    if(widget.shipping!=null) {
      _titleController!.text = widget.shipping!.title!;
      _durationController!.text = widget.shipping!.duration!;
      _costController!.text = PriceConverter.convertAmount(widget.shipping!.cost!, context).toString();
    }
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Form(
            key: _formKeyLogin,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [

                const SizedBox(height: Dimensions.paddingSizeSmall),
                Text(getTranslated('shipping_method_title', context)!,
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: ColorResources.getHintColor(context),)),

                const SizedBox(height: Dimensions.paddingSizeSmall),


                CustomTextField(
                  border: true,
                  hintText: getTranslated('enter_shipping_method_title', context),
                  focusNode: _resNameNode,
                  nextNode: _addressNode,
                  controller: _titleController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),


                Text(getTranslated('duration', context)!,
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: ColorResources.getHintColor(context),)),

                const SizedBox(height: Dimensions.paddingSizeSmall),
                CustomTextField(
                  border: true,
                  hintText: 'Ex: 4-6 days',
                  focusNode: _addressNode,
                  controller: _durationController,
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 22),
                Text(getTranslated('cost', context)!,
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: ColorResources.getHintColor(context),)),

                const SizedBox(height: Dimensions.paddingSizeSmall),
                CustomTextField(
                  border: true,
                  hintText: 'Ex: \$100',
                  controller: _costController,
                  focusNode: _phoneNode,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                  isAmount: true,
                ),

                // for login button
                const SizedBox(height: 50),

                Consumer<ShippingProvider>(builder: (context, shipProvider, child) {
                  return !shipProvider.isLoading ? CustomButton(
                    fontColor: Colors.white,
                    btnTxt: widget.shipping == null?
                    getTranslated('save', context):getTranslated('update', context),
                    onTap: ()  {
                      String title = _titleController!.text.trim();
                      String cost = _costController!.text.trim();
                      String duration = _durationController!.text.trim();

                      if(title.isEmpty){
                        showCustomSnackBar(getTranslated('enter_title', context),context);
                      }else if(cost.isEmpty){
                        showCustomSnackBar(getTranslated('enter_cost', context),context);
                      }else if(duration.isEmpty){
                        showCustomSnackBar(getTranslated('enter_duration', context),context);
                      } else{
                        shipping!.title = title;
                        shipping!.cost = PriceConverter.systemCurrencyToDefaultCurrency(double.parse(cost), context);
                        shipping!.duration = duration;
                        if (kDebugMode) {
                          print('-------${shipping!.cost}');
                        }
                        if(widget.shipping == null){
                          Provider.of<ShippingProvider>(context,listen: false).addShippingMethod(shipping, callback);
                        }
                        else if(widget.shipping != null){
                          Provider.of<ShippingProvider>(context,listen: false).updateShippingMethod(shipping!.title,shipping!.duration,shipping!.cost,widget.shipping!.id, callback);

                        }
                      }
                    },
                  ) : const Center(child: CircularProgressIndicator());
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
