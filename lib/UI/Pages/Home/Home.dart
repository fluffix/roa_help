import 'package:flutter/material.dart';
import 'package:roa_help/UI/Pages/Home/FatsCalc.dart';
import 'package:roa_help/UI/Pages/Home/Feelings.dart';
import 'package:roa_help/UI/Pages/Home/widgets/SmallCardWidget.dart';
import 'package:roa_help/UI/Pages/Home/widgets/WaterControl.dart';
import 'package:roa_help/UI/Requests/Food/FoodRequest.dart';
import 'package:roa_help/UI/Requests/Food/GetFood.dart';
import 'package:roa_help/UI/widgets/CustomAppBar.dart';
import 'package:roa_help/Utils/Svg/IconSvg.dart';
import 'package:roa_help/generated/l10n.dart';

class Home extends StatefulWidget {
  final int firstFats;
  final int secondFats;
  final int feeling;
  final int recipes;

  Home({this.firstFats, this.secondFats, this.feeling, this.recipes = 8});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GetFood db;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
                title: S.of(context).app_name, icon: IconsSvg.calendar),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32),
                child: Column(
                  children: [
                    WaterConrol(
                      onChange: () {},
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallCardWidget(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FatsCalc()));
                          },
                          quantity: widget.firstFats,
                          subtitlte: S.of(context).gramms_eating,
                          icon: IconSvg(
                            IconsSvg.fats,
                            width: 20,
                          ),
                          text: '${S.of(context).first_peaunts}',
                        ),
                        SmallCardWidget(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FatsCalc()));
                          },
                          icon: IconSvg(IconsSvg.fats, width: 20),
                          subtitlte: S.of(context).gramms_eating,
                          text: '${S.of(context).second_peaunts}',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallCardWidget(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Feelings()));
                          },
                          subtitlte: S.of(context).quantity_of_feelings,
                          icon: IconSvg(IconsSvg.feeling, width: 20),
                          text: '${S.of(context).feeling}',
                        ),
                        SmallCardWidget(
                          onTap: () async {
                            db = await getFood('Яйцо');
                            print(db.items[1].name);
                          },
                          quantity: widget.recipes,
                          subtitlte: S.of(context).pieces,
                          icon: IconSvg(IconsSvg.recipes, width: 20),
                          text: '${S.of(context).recieps}',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 120,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
