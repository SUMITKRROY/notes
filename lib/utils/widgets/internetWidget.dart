import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class InternetCheckWidget extends StatefulWidget {
  @override
  _InternetCheckWidgetState createState() => _InternetCheckWidgetState();
}

class _InternetCheckWidgetState extends State<InternetCheckWidget> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internet Connectivity Check'),
      ),
      body: Center(
        child: isConnected
            ? Text('Connected to the Internet')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please connect to the network',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                checkInternetConnectivity();
              },
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InternetCheckWidget(),
  ));
}
