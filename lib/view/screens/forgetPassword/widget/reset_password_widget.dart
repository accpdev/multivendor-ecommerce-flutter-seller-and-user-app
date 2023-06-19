import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/provider/auth_provider.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_button.dart';
import 'package:sixvalley_vendor_app/view/base/custom_snackbar.dart';
import 'package:sixvalley_vendor_app/view/base/textfeild/custom_pass_textfeild.dart';
import 'package:sixvalley_vendor_app/view/screens/auth/auth_screen.dart';
class ResetPasswordWidget extends StatefulWidget {
  final String mobileNumber;
  final String otp;
  const ResetPasswordWidget({Key? key,required this.mobileNumber,required this.otp}) : super(key: key);

  @override
  ResetPasswordWidgetState createState() => ResetPasswordWidgetState();
}

class ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;
  final FocusNode _newPasswordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();
  GlobalKey<FormState>? _formKeyReset;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }


  void resetPassword() async {
      String password = _passwordController!.text.trim();
      String confirmPassword = _confirmPasswordController!.text.trim();

      if (password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('CONFIRM_PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      }else if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)!),
          backgroundColor: Colors.red,
        ));
      } else {
        Provider.of<AuthProvider>(context, listen: false).resetPassword(widget.mobileNumber,widget.otp,
            password, confirmPassword).then((value) {
          if(value.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(getTranslated('password_reset_successfully', context)!),
                  backgroundColor: Colors.green,)
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
          }else {
            showCustomSnackBar(value.message, context);
          }
        });

      }
    // }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyReset,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Image.asset(Images.logoWithAppName, height: 150, width: 200),
            ),

            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Text(getTranslated('password_reset', context)!, style: robotoBold),
            ),
            // for new password
            Container(
                margin:
                const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeSmall),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('new_password', context),
                  focusNode: _newPasswordNode,
                  nextNode: _confirmPasswordNode,
                  controller: _passwordController,
                )),

            // for confirm Password
            Container(
                margin:
                const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeLarge),
                child: CustomPasswordTextField(
                  hintTxt: getTranslated('confirm_password', context),
                  textInputAction: TextInputAction.done,
                  focusNode: _confirmPasswordNode,
                  controller: _confirmPasswordController,
                )),


            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
              child: Provider.of<AuthProvider>(context).isLoading
                  ? Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ) : CustomButton(onTap: resetPassword, btnTxt: getTranslated('reset_password', context)),
            ),


          ],
        ),
      ),
    );
  }
}
