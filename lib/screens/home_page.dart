import 'package:flutter/material.dart';
import 'package:land_registration/widget/header.dart';
import 'package:land_registration/widget/homePageDecription.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constant/utils.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    if (width > 600) {
      width = 590;
      isDesktop = true;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Top Header
            const Material(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 150.0, top: 15, right: 50, bottom: 15),
                child: HeaderWidget(),
              ),
            ),
            const SizedBox(
              height: 100,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 100.0, top: 0, right: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const LeftDescription(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomAnimatedContainer('Contract Owner', () {
                        Navigator.of(context).pushNamed(
                          '/login',
                          arguments: "owner",
                        );
                      }),
                      CustomAnimatedContainer('Land Inspector', () {
                        Navigator.of(context).pushNamed(
                          '/login',
                          arguments: "LandInspector",
                        );
                      }),
                      CustomAnimatedContainer('User', () {
                        Navigator.of(context).pushNamed(
                          '/login',
                          arguments: "UserLogin",
                        );
                      }),
                    ],
                  ),
                  // )
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
