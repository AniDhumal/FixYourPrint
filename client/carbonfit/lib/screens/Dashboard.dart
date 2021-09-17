import 'dart:ui';
import 'package:fixyourprint/screens/ProfileInfo.dart';
import 'package:fixyourprint/screens/UpdateScreen.dart';
import 'package:fixyourprint/services/AuthService.dart';
import 'package:fixyourprint/services/CarbonDataService.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double footprint = 0;
  bool _isLoading = false;
  String name = '';

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    // getEmission();
    // getProfile();
  }

  getProfile() async {
    name = await AuthService().getProfile();
    setState(() {
      _isLoading = false;
    });
  }

  getEmission() async {
    footprint = await CarbonDataService().totalEmission();
    footprint = double.parse(footprint.toStringAsFixed(2));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello $name, your footprint is...",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                footprint.toString() + ' ',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
              ),
              Text(
                "tonnes CO2/year",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
