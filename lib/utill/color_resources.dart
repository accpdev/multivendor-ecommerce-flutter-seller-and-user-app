import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/theme_provider.dart';

class ColorResources {

  static Color getBlue(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF007ca3) : const Color(0xFF00ADE3);
  }

  static Color getWhite(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
  }

  static Color getEmergencyContactColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF14AF91) : const Color(0xFF14AF91);
  }

  static Color getColombiaBlue(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF678cb5) : const Color(0xFF92C6FF);
  }
  static Color getLightSkyBlue(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFc7c7c7) : const Color(0xFF8DBFF6);
  }
  static Color getHarlequin(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF257800) : const Color(0xFF3FCC01);
  }
  static Color getCheris(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF941546) : const Color(0xFFE2206B);
  }
  static Color getGrey(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF808080) : const Color(0xFFF1F1F1);
  }
  static Color getRed(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF7a1c1c) : const Color(0xFFD32F2F);
  }
  static Color getYellow(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF916129) : const Color(0xFFFFAA47);
  }
  static Color getHint(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFc7c7c7) : const Color(0xFF9E9E9E);
  }
  static Color getGainsBoro(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF999999) : const Color(0xFFE6E6E6);
  }
  static Color getTextBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF414345) : const Color(0xFFF3F9FF);
  }
  static Color getIconBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF2e2e2e) : const Color(0xFFF9F9F9);
  }
  static Color getHomeBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF343636) : const Color(0xFFF3F3F3);
  }
  static Color getImageBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF3f4347) : const Color(0xFFE2F0FF);
  }
  static Color getSellerTxt(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF517091) : const Color(0xFF92C6FF);
  }
  static Color getChatIcon(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFebebeb) : const Color(0xFFD4D4D4);
  }
  static Color getLowGreen(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF7d8085) : const Color(0xFFEFF6FE);
  }
  static Color getGreen(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF167d3c) : const Color(0xFF23CB60);
  }
  static Color getFloatingBtn(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF49698c) : const Color(0xFF7DB6F5);
  }
  static Color getPrimary(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF1B7FED) : Theme.of(context).primaryColor;
  }
  static Color getBottomSheetColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF25282B) : const Color(0xFFFCFCFC);
  }
  static Color getHintColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF98a1ab) : const Color(0xFF52575C);
  }
  static Color getButtonHintColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0x4d98a1ab) : const Color(0xFFF4F5F7);
  }

  static Color getSubTitleColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFA0A0A0) : const Color(0xFFA0A0A0);
  }
  static Color getGreyBunkerColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFE4E8EC) : const Color(0xFF25282B);
  }

  static Color getTextColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFE4E8EC) : const Color(0xFF4B566B);
  }

  static Color getHeadTextColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFA4AABB) : const Color(0xFF4B566B);
  }
  static Color getProfileTextColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFE4E8EC) : const Color(0xFFE4E8EC);
  }

  static Color mainCardOneColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF165AC5) : Theme.of(context).primaryColor;
  }

  static Color mainCardTwoColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF0084CF) : const Color(0xFF0084CF);
  }
  static Color mainCardThreeColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF219F61) : const Color(0xFF219F61);
  }
  static Color mainCardFourColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFFF6969) : const Color(0xFFFF6969);
  }

  static Color withdrawCardColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF32C02F) : const Color(0xFF32C02F);
  }

  static Color pendingCardColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFFF900E) : const Color(0xFFFF900E);
  }

  static Color commissionCardColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFFE8551) : const Color(0xFFFE8551);
  }

  static Color deliveryChargeCardColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF53ABFF) : const Color(0xFF53ABFF);
  }
  static Color collectedCashCardColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFE98F26) : const Color(0xFFE98F26);
  }
  static Color collectedTaxCardColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFB19810) : const Color(0xFFB19810);
  }
  static Color titleColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFE4ECF9) : const Color(0xFF4B566B);
  }
  static Color getSearchBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF585a5c) : const Color(0xFFF4F7FC);
  }

  static Color getTextTitle(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000743);
  }


  static Color secondaryColor = const Color(0xFFE0EC53);
  static const Color black = Color(0xff000000);
  static Color gradientColor = const Color(0xFF45A735);
  static const Color white = Color(0xffFFFFFF);
  static const Color colorBlue = Color(0xff00ADE3);
  static const Color colombiaBlue = Color(0xff00ADE3);
  static const Color lightSkyBlue = Color(0xff8DBFF6);
  static const Color harlequin = Color(0xff3FCC01);
  static const Color cerise = Color(0xffE2206B);
  static const Color grey = Color(0xffF1F1F1);
  static const Color red = Color(0xFFD32F2F);
  static const Color yellow = Color(0xFFFFAA47);
  static const Color hintTextColor = Color(0xff9E9E9E);
  static const Color gainsBro = Color(0xffE6E6E6);
  static const Color textBg = Color(0xFFF4F7FC);
  static const Color iconBg = Color(0xffF9F9F9);
  static const Color homeBg = Color(0xffF0F0F0);
  static const Color imageBg = Color(0xffE2F0FF);
  static const Color sellerText = Color(0xff38DBFF);
  static const Color chatIconColor = Color(0xffD4D4D4);
  static const Color lowGreen = Color(0xffEFF6FE);
  static const Color green = Color(0xff23CB60);
  static const Color floatingBtn = Color(0xff7DB6F5);
  static const Color colorLightBlack = Color(0xFF4A4B4D);
  static Color nevDefaultColor = const Color(0xFFAAAAAA);

  static const Map<int, Color> colorMap = {
    50: Color(0x101455AC),
    100: Color(0x201455AC),
    200: Color(0x301455AC),
    300: Color(0x401455AC),
    400: Color(0x501455AC),
    500: Color(0x601455AC),
    600: Color(0x701455AC),
    700: Color(0x801455AC),
    800: Color(0x901455AC),
    900: Color(0xff1455AC),
  };

  static const MaterialColor primaryMaterial = MaterialColor(0xFF1455AC, colorMap);
}
