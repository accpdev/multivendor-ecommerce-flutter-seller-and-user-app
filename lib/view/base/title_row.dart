import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';

class TitleRow extends StatelessWidget {
  final String? title;
  final Function? onTap;
  final Duration? eventDuration;
  final bool? isDetailsPage;
  final bool isPrimary;
  final bool isPopular;
  final Color? color;
  const TitleRow({Key? key, required this.title, this.onTap, this.eventDuration, this.isDetailsPage, this.isPrimary=false, this.isPopular=false, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? days, hours, minutes, seconds;
    if (eventDuration != null) {
      days = eventDuration!.inDays;
      hours = eventDuration!.inHours - days * 24;
      minutes = eventDuration!.inMinutes - (24 * days * 60) - (hours * 60);
      seconds = eventDuration!.inSeconds - (24 * days * 60 * 60) - (hours * 60 * 60) - (minutes * 60);
    }

    return Row(children: [
      Text(title!, style: robotoBold.copyWith(color: color ?? (isPopular? Theme.of(context).cardColor : isPrimary? Theme.of(context).primaryColor : ColorResources.titleColor(context)))),
      eventDuration == null
          ? const Expanded(child: SizedBox.shrink())
          : Expanded(
              child: Row(children: [
              const SizedBox(width: 5),
              TimerBox(time: days),
              Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),
              TimerBox(time: hours),
              Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),
              TimerBox(time: minutes),
              Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),
              TimerBox(time: seconds, isBorder: true),
            ])),
      onTap != null
          ? InkWell(
              onTap: onTap as void Function()?,
              child: Row(children: [
                isDetailsPage == null ? Text(getTranslated('VIEW_ALL', context)!,
                        style: titilliumRegular.copyWith(
                          color: color ?? (isPopular? Theme.of(context).cardColor : Theme.of(context).primaryColor),
                          fontSize: Dimensions.fontSizeDefault,
                          decoration: TextDecoration.underline
                        ))
                    : const SizedBox.shrink(),

              ]),
            )
          : const SizedBox.shrink(),
    ]);
  }
}

class TimerBox extends StatelessWidget {
  final int? time;
  final bool isBorder;

  const TimerBox({Key? key, required this.time, this.isBorder = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.all(isBorder ? 0 : 2),
      decoration: BoxDecoration(
        color: isBorder ? null : ColorResources.getPrimary(context),
        border: isBorder ? Border.all(width: 2, color: ColorResources.getPrimary(context)) : null,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Text(time! < 10 ? '0$time' : time.toString(),
          style: robotoBold.copyWith(
            color: isBorder ? ColorResources.getPrimary(context) : Theme.of(context).highlightColor,
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
      ),
    );
  }
}
