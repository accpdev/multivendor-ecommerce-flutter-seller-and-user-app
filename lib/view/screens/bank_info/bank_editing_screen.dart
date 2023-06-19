
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/data/model/body/seller_body.dart';
import 'package:sixvalley_vendor_app/data/model/response/seller_info.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/provider/bank_info_provider.dart';
import 'package:sixvalley_vendor_app/provider/profile_provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_app_bar.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_text_feild.dart';

class BankEditingScreen extends StatefulWidget {

  final SellerModel? sellerModel;
  const BankEditingScreen({Key? key, required this.sellerModel}) : super(key: key);
  @override
  BankEditingScreenState createState() => BankEditingScreenState();
}

class BankEditingScreenState extends State<BankEditingScreen> {

  TextEditingController? _bankNameController ;
  TextEditingController? _branchController ;
  TextEditingController? _holderNameController ;
  TextEditingController? _accountController ;

  final FocusNode _bankNameNode = FocusNode();
  final FocusNode _branchNode = FocusNode();
  final FocusNode _holderNameNode = FocusNode();
  final FocusNode _accountNode = FocusNode();
  GlobalKey<FormState>? _formKeyLogin;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  _updateUserAccount() async {
    String bankName = _bankNameController!.text.trim();
    String branchName = _branchController!.text.trim();
    String holderName = _holderNameController!.text.trim();
    String account = _accountController!.text.trim();

    if(Provider.of<BankInfoProvider>(context, listen: false).bankInfo!.bankName == _bankNameController!.text
        && Provider.of<BankInfoProvider>(context, listen: false).bankInfo!.branch == _branchController!.text
        && Provider.of<BankInfoProvider>(context, listen: false).bankInfo!.holderName == _holderNameController!.text
        && Provider.of<BankInfoProvider>(context, listen: false).bankInfo!.accountNo == _accountController!.text
    ) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('change_something', context)!),
          backgroundColor: ColorResources.red));
    }else if (bankName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('enter_bank_name', context)!),
          backgroundColor: ColorResources.red));
    }else if (branchName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('enter_branch_name', context)!),
          backgroundColor: ColorResources.red));
    }else if (holderName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('enter_holder_name', context)!),
          backgroundColor: ColorResources.red));
    }else if (account.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated('enter_account_no', context)!),
          backgroundColor: ColorResources.red));
    }else {
      SellerModel updateUserInfoModel = Provider.of<BankInfoProvider>(context, listen: false).bankInfo!;
      updateUserInfoModel.bankName = _bankNameController?.text ?? "";
      updateUserInfoModel.branch = _branchController?.text ?? "";
      updateUserInfoModel.holderName = _holderNameController?.text ?? '';
      updateUserInfoModel.accountNo = _accountController?.text ?? '';

      SellerModel userInfo = Provider.of<ProfileProvider>(context, listen: false).userInfoModel!;
      SellerBody sellerBody = SellerBody(
        sMethod: '_put', fName: userInfo.fName, lName: userInfo.lName, image: userInfo.image,
        bankName: _bankNameController?.text ?? "", branch: _branchController?.text ?? "", accountNo: _accountController?.text ?? '',
        holderName: _holderNameController?.text ?? '',
      );

      await Provider.of<BankInfoProvider>(context, listen: false).updateUserInfo(context,
        updateUserInfoModel, sellerBody, Provider.of<AuthProvider>(context, listen: false).getUserToken(),
      ).then((response) {
        if(response!.isSuccess) {
          Navigator.pop(context);
          showCustomSnackBar(getTranslated('bank_info_updated_successfully', context), context, isError: false);
        }else {
          showCustomSnackBar(response.message, context);

        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _bankNameController = TextEditingController();
    _branchController = TextEditingController();
    _holderNameController = TextEditingController();
    _accountController = TextEditingController();

    _bankNameController!.text = widget.sellerModel!.bankName ?? '';
    _branchController!.text = widget.sellerModel!.branch ?? '';
    _holderNameController!.text = widget.sellerModel!.holderName ?? '';
    _accountController!.text = widget.sellerModel!.accountNo ?? '';

  }

  @override
  void dispose() {
    _bankNameController!.dispose();
    _branchController!.dispose();
    _holderNameController!.dispose();
    _accountController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: getTranslated('bank_info', context),),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Form(
            key: _formKeyLogin,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [

                Text(getTranslated('holder_name', context)!,
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: ColorResources.getHintColor(context),)),

                const SizedBox(height: Dimensions.paddingSizeSmall),
                CustomTextField(
                  border: true,
                  hintText: 'Ex: mr.john',
                  controller: _holderNameController,
                  focusNode: _holderNameNode,
                  nextNode: _bankNameNode,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Text(getTranslated('bank_name', context)!,
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: ColorResources.getHintColor(context),)),

                const SizedBox(height: Dimensions.paddingSizeSmall),
                CustomTextField(
                  border: true,
                  hintText: getTranslated('bank_name_hint', context),
                  focusNode: _bankNameNode,
                  nextNode: _branchNode,
                  controller: _bankNameController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                Text(
                    getTranslated('branch_name', context)!,
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: ColorResources.getHintColor(context),)),

                const SizedBox(height: Dimensions.paddingSizeSmall),
                CustomTextField(
                  border: true,
                  hintText: getTranslated('branch_name_hint', context),
                  focusNode: _branchNode,
                  controller: _branchController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),


                Text(getTranslated('account_no', context)!,
                    style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      color: ColorResources.getHintColor(context),)),

                const SizedBox(height: Dimensions.paddingSizeSmall),
                CustomTextField(
                  border: true,
                  hintText:  getTranslated('account_no_hint', context),
                  controller: _accountController,
                  focusNode: _accountNode,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                ),

                // for save button
                const SizedBox(height: Dimensions.paddingSizeButton),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: !Provider.of<BankInfoProvider>(context).isLoading ?
                  CustomButton(onTap: _updateUserAccount,
                      btnTxt: getTranslated('save', context)) :
                  Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
