import 'dart:async';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sh_app/colours.dart';
import 'package:sh_app/textStyle.dart';

import 'package:url_launcher/url_launcher.dart';

Map _dataqu;
void main() async {
  _dataqu = await getQu();

  runApp(new MaterialApp(
    title: 'الشرق الاوسط للتأمين',
    localizationsDelegates: [
      // ... app-specific localization delegate[s] here
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', ''), // English, no country code
      const Locale('ar', ''), // Hebrew, no country code
    ],
    localeResolutionCallback: (locale, supportedLocales) {
      return supportedLocales.last;
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.transparent),
      //primarySwatch: kPrimaryColor,
      // primaryColor: Colors.white,
      // scaffoldBackgroundColor: Colors.white,
      fontFamily: "Cairo",
    ),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _firstController = TextEditingController();
  TextEditingController _resulte = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _dataqu['data'][0]['id'] == "1"
        ? Scaffold(
            drawer: Drawer(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: AppColours.kC_Gery,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                color: AppColours.kC_Gold,
                                child: Center(
                                  child: TxtApp(
                                    txt: "الشرق الاوسط للتأمين ",
                                    colour: AppColours.kC_LightBlue,
                                    size: 22,
                                    bold: true,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "عنا :",
                                        style: TextStyle(
                                            color: AppColours.kC_Pink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: "Cairo")),
                                    TextSpan(text: "\n"),
                                    TextSpan(
                                        text:
                                            "هذا التطبيق لحساب قسط التامين واستخراج قيمة التأمين او اجمالي القسط الذي يدفعه المزارع ",
                                        style: TextStyle(
                                            color: AppColours.kC_Dark,
                                            fontSize: 18,
                                            fontFamily: "Cairo")),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    TxtApp(
                                      txt: "للتواصل مع المبرمج",
                                      colour: AppColours.kC_Pink,
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          buildGestureDetector(
                                              onclik: _launchURLF,
                                              icon: FontAwesomeIcons.facebookMessenger),
                                          buildGestureDetector(
                                              onclik: _launchURLW,
                                              icon: FontAwesomeIcons.whatsapp),
                                          buildGestureDetector(
                                              onclik: _launchURLT,
                                              icon: FontAwesomeIcons.telegram),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: AppColours.kC_Dark,
            appBar: AppBar(
              iconTheme: new IconThemeData(
                color: AppColours.kC_Gery,
              ),
              backgroundColor: AppColours.kC_Dark,
              title: Center(
                  child: Text(
                "الشرق الاوسط للتأمين",
                style: TextStyle(
                  color: AppColours.kC_Gery,
                ),
              )),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    child: Column(
                      children: [
                        _nameTextField("ادخل مبلغ التامين"),
                        SizedBox(
                          height: 50,
                        ),
                        AbsorbPointer(
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 50.0,
                                color: AppColours.kC_Gold,
                                fontWeight: FontWeight.bold),
                            controller: _resulte,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: new AppBar(
              title: new Text('${_dataqu['data'][0]['type']}'),
              centerTitle: true,
              backgroundColor: Colors.red,
            ),
          );
  }

  GestureDetector buildGestureDetector({onclik, icon}) {
    return GestureDetector(
      onTap: onclik,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColours.kC_Gery,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Center(child: FaIcon(icon)),
      ),
    );
  }

  void _calculate() {
    if (_firstController.text.trim().isNotEmpty) {
      final firstValue = int.parse(_firstController.text);
      // final scValue = double.parse(_firstController.text);
      final firstValue1 = (firstValue * 0.04);
      final firstValue2 = (firstValue1 * 0.06);
      final firstValue3 = (firstValue2 + firstValue1 + 10);
      final firstValue4 = (firstValue3 / 2);
      _resulte.text = (firstValue4).toString();
    }
  }

  Widget _nameTextField(String lebel) {
    return TextFormField(
      controller: _firstController,
      onChanged: (value) {
        _calculate();
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20.0, color: AppColours.kC_Dark),
      decoration: InputDecoration(
        focusColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(vertical: 19.0, horizontal: 5.0),
        filled: true,
        fillColor: Color(0xFFE2E3E3),
        enabledBorder: OutlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.transparent,
          ),
        ),
        hintText: lebel,
      ),
    );
  }

  _launchURLF() async {
    const url = 'https://www.facebook.com/boygo.better';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLW() async {
    const url = 'https://wa.me/249920623939';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLT() async {
    const url = 'https://t.me/qusaizain';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

Future<Map> getQu() async {
  String apiUl = 'https://api.jsonbin.io/b/5f9d171e857f4b5f9ae076c8';

  http.Response response = await http.get(apiUl);

  return jsonDecode(response.body);
}
