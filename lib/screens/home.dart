import 'package:flutter/material.dart';
import 'package:electrons_dist/utils.dart';
import 'package:electrons_dist/calc.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final eC = TextEditingController();
  bool _byNearestGas = false;
  @override
  void dispose() {
    eC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Electrons Distributor"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            SystemNavigator.pop();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        backgroundColor: Colors.red[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(children: [
            Column(
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                ),
                Container(height: 75), // white space
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                  top: heightRatio(context, 0.065), right: 20.0, left: 20.0),
              child: new Container(
                height: 100.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Welcome to Electron Distributor",
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.w500),
                      ),
                      Text(
                          "Enter electrons count and check whether you want it by nearest stable gas or not.",
                          style: TextStyle(fontSize: 15.0))
                    ],
                  ),
                ),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: eC,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Enter Electrons count'),
                ),
                SizedBox(height: 5),
                Text(
                  "By nearest stable gas?",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('No'),
                      leading: Radio(
                        value: false,
                        groupValue: _byNearestGas,
                        onChanged: (bool value) {
                          setState(() {
                            _byNearestGas = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Yes'),
                      leading: Radio(
                        value: true,
                        groupValue: _byNearestGas,
                        onChanged: (bool value) {
                          setState(() {
                            _byNearestGas = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Retrieve the text the that user has entered by using the
                            // TextEditingController.
                            content: Text(calculateElectrons(
                                int.parse(eC.text), _byNearestGas)),
                          );
                        },
                      );
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text("Get results", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
