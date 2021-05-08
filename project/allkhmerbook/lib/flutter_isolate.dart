import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlutterIsolateTest extends StatefulWidget {
  @override
  _FlutterIsolateTestState createState() => _FlutterIsolateTestState();
}

class _FlutterIsolateTestState extends State<FlutterIsolateTest> {
  Future printSixToTen() async {
    for (int i = 6; i <= 10; i++) {
      await new Future.delayed(Duration(seconds: 1), () {
        print(i);
      });
    }
  }

  Future printOneToFive() async {
    for (int i = 1; i <= 5; i++) {
      await new Future.delayed(const Duration(seconds: 1), () {
        print(i);
      });
    }
  }

  int? prime;

  void _getPrime() async {
    try {
      //Output:
      // var oneToFive = await printOneToFive();
      // var sixToTen = await printSixToTen();

      //Output:
      // var oneToFive =  printOneToFive();
      // var sixToTen =  printSixToTen();
      //
      int ans = await compute(getnthPrime, 10000);
      print(ans);
      setState(() {
        prime = ans;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  static int getnthPrime(int n) {
    int currentPrimeCount = 0;
    int candidate = 1;
    while (currentPrimeCount < n) {
      ++candidate;
      if (isPrime(candidate)!) {
        ++currentPrimeCount;
      }
    }
    return candidate;
  }

  static bool? isPrime(int n) {
    int count = 0;
    for (int i = 1; i <= n; ++i) {
      if (n % i == 0) {
        ++count;
      }
    }
    return count == 2;
  }

  int count = 0;

  countInt() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Center(child: Text('Number: $count')),
          TextButton(
            child: Text('Press'),
            onPressed: _getPrime,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: countInt,
      ),
    );
  }
}
