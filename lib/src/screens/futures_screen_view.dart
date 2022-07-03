import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FuturesScreenView extends StatelessWidget {
  const FuturesScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('futures'),
      ),
      body: Center(
        child: FutureBuilder(
          future: waitForFiveSec(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              //we are
              return Text('Loading ... '); // indicate loading widget
            }
            if (snapshot.data == true) {}
            return Text(
              'Hello',
              style: TextStyle(fontSize: 28),
            );
          },
        ),
      ),
    );
  }

  // wait for five seconds
  Future waitForFiveSec() async {
    return await Future.delayed(Duration(seconds: 5)).then((value) => true);
  }
}
