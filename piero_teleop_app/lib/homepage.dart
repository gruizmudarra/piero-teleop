import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'horizontalButtons.dart';
import 'verticalButtons.dart';
import 'glob.dart';

class ControlPage extends StatefulWidget {
  final Socket channel;
  ControlPage({Key key, this.channel}) : super(key: key);

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {

  @override
  void initState() {
    super.initState();

    // Set fixed orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    widget.channel.close();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*App Bar*/
      appBar: AppBar(
        /*Arrow back in App bar */
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              exit(0);
            }
            ),
        /*Arrow back in App bar */

        /*Title text*/
        title: Text("Piero Teleop"),
        /*Title text*/
        actions: <Widget>[],
      ),
      /*App bar */

      /*App body*/
      resizeToAvoidBottomPadding: false,
      body: Container(
            color: Color(0xffE5E5E5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(children: <Widget>[
                    Expanded(
                        child: VerticalButtons(
                          channel: widget.channel,
                        )
                    ),
                    Spacer(),
                    Expanded(
                        child: Container(
                            width: 400.0,
                            height: 250.0,
                            child: Material(
                                color: Colors.white,
                                elevation: 14.0,
                                borderRadius: BorderRadius.circular(24.0),
                                shadowColor: Color(0x802196F3),
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Linear velocity"),
                                    Container(
                                      width: 100.0,
                                      child:
                                      TextField(
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        maxLength: 3,
                                        onChanged: (input) {
                                          linVelInput = input;
                                        },
                                        onSubmitted: (input) {
                                          setState(() {
                                            linVel = double.parse(linVelInput);
                                          });
                                        },
                                      ),
                                    ),
                                    Text("Angular velocity"),
                                    Container(
                                        width: 100.0,
                                        child:
                                        TextField(
                                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                                          maxLength: 3,
                                          onChanged: (input) {
                                            angVelInput = input;
                                          },
                                          onSubmitted: (input) {
                                            setState(() {
                                              angVel = double.parse(angVelInput);
                                            });
                                          },
                                        )
                                    ),
                                  ],)
                            )
                        )
                    ),
                    Spacer(),
                    Expanded(
                        child: HorizontalButtons(
                          channel: widget.channel,
                        )
                    )
                  ]),
                ]),
          ),


        );
        // Spacer()
      /*App body*/
  }
}
