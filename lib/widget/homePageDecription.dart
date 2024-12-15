import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:universal_html/html.dart' as html;
import '../constant/utils.dart';

class LeftDescription extends StatelessWidget {
  const LeftDescription({Key? key}) : super(key: key);
  static final appContainer = kIsWeb
      ? html.window.document.querySelectorAll('flt-glass-pane')[0]
      : null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // title
        const FittedBox(
          child: Text('''BLOCKCHAIN
BASED LAND 
REGISTRY PORTAL  ''',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xff28313b),
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                letterSpacing: 1,
              )),
        ),
        // Description

        const SizedBox(
          height: 15,
        ),
        Row(
          children: <Widget>[
            // button
            InkWell(
              onTap: () {
                launchUrl(
                    "https://drive.google.com/file/d/1ax28DALXR16GaMVIAY32c1B9_aU00CK3/view?usp=sharing");
              },
              child: Container(
                  width: 150,
                  height: 60,
                  child: const Center(
                    child: Text("Learn More",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 2,
                        )),
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xff47afc9),
                      borderRadius: BorderRadius.circular(8))),
            ),
          ],
        ),
      ],
    );
  }
}
