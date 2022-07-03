import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class FuturesScreenView extends StatelessWidget {
  const FuturesScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('futures'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 100,
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
            Expanded(
                child: Container(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchPostsFromApi(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                        height: 100,
                        width: 100,
                        child: CircularProgressIndicator()); //loading
                  } else if (snap.hasError) {
                    return Text(snap.error.toString());
                  } else if (snap.data == null) {
                    return Text('no data');
                  }
                  return ListView.builder(
                      itemCount: snap.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            snap.data![index]["title"].toString(),
                          ),
                        );
                      });
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  // wait for five seconds
  Future waitForFiveSec() async {
    return await Future.delayed(Duration(seconds: 5)).then((value) => true);
  }

  // get a list of posts from this url https://jsonplaceholder.typicode.com/posts

  Future<List<Map<String, dynamic>>> fetchPostsFromApi() async {
    final String _apiEndpoint = "https://jsonplaceholder.typicode.com/posts";
    http.Response _response = await http.get(Uri.parse(_apiEndpoint));
    var _decodedJson = json.decode(_response.body);
    List<Map<String, dynamic>> _listOfPosts =
        _decodedJson.cast<Map<String, dynamic>>();

    print(_listOfPosts[0]["title"].toString());
    return _listOfPosts;
  }
}
