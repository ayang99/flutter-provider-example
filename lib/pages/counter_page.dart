import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test_harness2/services/data_provider.dart';

// Counter Page
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataProvider _data = Provider.of<DataProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ChangeNotifierProvider Example'),
            SizedBox(height: 150),
            Text(
              '${_data.count}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _data.incrementCount(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
