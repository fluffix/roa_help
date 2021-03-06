import 'package:flutter/material.dart';
import 'package:roa_help/Utils/Style/Style.dart';
import 'package:roa_help/Utils/Svg/IconSvg.dart';
import 'package:roa_help/models/CardSettingsModel.dart';

class CardSettings extends StatefulWidget {
  final List<CardSettingsItem> items;

  const CardSettings({@required this.items});
  @override
  _CardSettingsState createState() => _CardSettingsState();
}

class _CardSettingsState extends State<CardSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: Theme.of(context).brightness != Brightness.dark
              ? Style.shadowCard
              : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.items.length, (index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (widget.items[index].onTap != null) {
                widget.items[index].onTap();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  index == 0
                      ? SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : Container(
                          height: 0.5,
                          width: MediaQuery.of(context).size.width,
                          color: Theme.of(context).disabledColor),
                  SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.items[index].text,
                            style: Theme.of(context).textTheme.headline5),
                        IconSvg(IconsSvg.next,
                            color: Theme.of(context).textTheme.headline5.color,
                            height: 16,
                            width: 16)
                      ]),
                  SizedBox(height: 16),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
