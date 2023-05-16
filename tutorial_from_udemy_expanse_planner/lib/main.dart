import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_from_udemy_expanse_planner/widgets/transaction_list.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expanse planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(
          secondary: Colors.orange,
        ),
        fontFamily: 'Quicksand',
        // appBarTheme: AppBarTheme(
        // toolbarTextStyle: ThemeData.light().textTheme.copyWith().bodyText2,
        // titleTextStyle: ThemeData.light().textTheme.copyWith().headline6),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _showAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    var isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Expanse planner'),
      actions: <Widget>[
        IconButton(
          onPressed: () => _showAddNewTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final txListWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransaction, _deleteTransaction),
    );

    final txChartWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.3,
      child: Chart(_recentTransactions),
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (isLandscape)
                Column(
                  children: [
                    Row(
                      children: [
                        const Text('Show Chart'),
                        Switch.adaptive(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          },
                        ),
                      ],
                    ),
                    _showChart ? txChartWidget : txListWidget,
                  ],
                ),
              if (!isLandscape)
                Column(
                  children: [
                    txChartWidget,
                    txListWidget,
                  ],
                ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TargetPlatform.iOS == defaultTargetPlatform
          ? Container()
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _showAddNewTransaction(context),
            ),
    );
  }
}
