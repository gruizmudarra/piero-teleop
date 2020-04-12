import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'verticalSlider.dart';
import 'horizontalSlider.dart';

/*TODO: Changes in this page are:
        2. Redistribute the pads
        3. Make it prettier */
class ControlPage extends StatefulWidget {
  final Socket channel;
  ControlPage({Key key, this.channel}) : super(key: key);

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  void dispose() {
    widget.channel.close();
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
      body: Container(
        color: Color(0xffE5E5E5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                  child: VerticalSlider(channel: widget.channel,)
              ),

              Spacer(),
              Expanded(
                child: HorizontalSlider(channel: widget.channel,)
              ),
            ]),
        ]),
        ),
        // Spacer()
      );
      /*App body*/
  }
}
