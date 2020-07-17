import 'package:covid19_tracker/model/countries.dart';
import 'package:covid19_tracker/model/covid19_dashboard.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:covid19_tracker/widgets/animation.dart';

import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var value1 = [
    0.0,
    1.0,
    1.5,
    0.3,
    2.0,2.2
  ];
  var value2 = [
    0.0,
    1.0,
    1.5,
    1.0,
    2.2,
    2.5
  ];
  var value3 = [
    0.0,
    1.0,
    1.5,
    1.8,
    2.0

  ];
 
  
  Covid19Dashboard data;
  AnimationController _controller;
  Animation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
    getData();

    //_controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.grey[300],
            Colors.blueGrey[400],
            Colors.blueGrey[300],
            Colors.blueGrey[600],
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text(
            'Covid-19 Tracker',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: data == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(18.0),
                child: RefreshIndicator(
                    onRefresh: getData,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 2.9,
                          ),
                          delegate: SliverChildListDelegate([
                            Padding(
                              padding: const EdgeInsets.only(top:40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      border: Border.all(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18.0),
                                          child: Text('Confirmed',
                                              style: TextStyle(
                                                  color: Colors.red[800],
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(height: 10),
                                        Text(formatter.format(data.confirmed),
                                            style: TextStyle(
                                                color: Colors.red[800],
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  // Column(
                                  //   children: [
                                  //     Text('Active',
                                  //       style: TextStyle(color:Colors.blue[800],fontSize:20,fontWeight:FontWeight.bold)),
                                  //       SizedBox(height:10),
                                  //       Text(formatter.format(data.active), style: TextStyle(color:Colors.blue[800],fontSize:14,fontWeight:FontWeight.bold))
                                  //   ],
                                  // ),
                                  Container(
                                    height: 80,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      border: Border.all(
                                        color: Colors.green,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18.0),
                                          child: Text('Recovered',
                                              style: TextStyle(
                                                  color: Colors.green[800],
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(height: 10),
                                        Text(formatter.format(data.recovered),
                                            style: TextStyle(
                                                color: Colors.green[800],
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 80,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.brown[100],
                                      border: Border.all(color: Colors.brown),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18.0),
                                          child: Text('Deaths',
                                              style: TextStyle(
                                                  color: Colors.brown[800],
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(height: 10),
                                        Text(formatter.format(data.deaths),
                                            style: TextStyle(
                                                color: Colors.brown[800],
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom:80),
                              child: SlideFadeTransition(
                                 delayStart: Duration(milliseconds: 100),
                                                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100.0,
                                      height: 20.0,
                                      child: Sparkline(
                                          data: value1,
                                          lineWidth: 2.0,
                                          lineColor: Colors.red[900]),
                                    ),
                                    Container(
                                      width: 100.0,
                                      height: 20.0,
                                      child: Sparkline(
                                          data: value2,
                                          lineWidth: 2.0,
                                          lineColor: Colors.green[900],)
                                    ),
                                    Container(
                                      width: 100.0,
                                      height: 20.0,
                                      child: Sparkline(
                                          data: value3,
                                          lineWidth: 2.0,
                                          lineColor: Colors.brown),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        ),
                       
                        SliverList(
                          
                            delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Center(
                              child: Text(' ${data.date}',
                                  style: TextStyle(
                                      color: Colors.pink[900],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text('Top countries:', style: TextStyle(
                                        color: Colors.teal[900],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                          )
                        ])),
                        SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            var item = data.countries[index];
                            return buildExpansionTile(item, index);
                          }, childCount: data.countries.length),
                        )
                      ],
                    )),
              ),
      ),
    );
  }

  Widget buildSummerCard({int count, String text}) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0, end: 2).animate(_curvedAnimation),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    //color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${formatter.format(count)}',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                )
              ],
            )),
      ),
    );
  }

  ExpansionTile buildExpansionTile(Countries item, int index) {
    return ExpansionTile(
      
      leading: item.countryCode.length == 2
          ? CountryPickerUtils.getDefaultFlagImage(
              Country(isoCode: item.countryCode))
          : Text(''),
      title: Text(
        '${item.country}',
        style: TextStyle(
          color: Colors.indigo[900],
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      trailing: Text('${formatter.format(item.confirmed)}',style: TextStyle(
          color: Colors.indigo[900],
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  buildDetailText(
                    
                      color: Colors.brown, count: index + 1, text: 'Rank',),
                  buildDetailText(
                      color: Colors.blue[900],
                      count: item.active,
                      text: 'Active'),
                  buildDetailText(
                      color: Colors.green[900],
                      count: item.recovered,
                      text: 'Recovered'),
                  buildDetailText(
                      color: Colors.red[900], count: item.deaths, text: 'Deaths'),
                ]),
            ],
          ),
        )
      ],
    );
  }

  Widget buildDetailText({int count, Color color, String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        '$text: ${formatter.format(count)}',
        style: TextStyle(color: color, fontSize:16),
       
      ),
    );
  }

  Future<void> getData() async {
    Covid covid = Covid();
    Covid19Dashboard result = await covid.getDashboardData();
    setState(() {
      data = result;
      if (data != null) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  final formatter = NumberFormat.decimalPattern('en-US');
}
