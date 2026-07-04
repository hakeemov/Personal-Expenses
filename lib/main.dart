import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput;
final List<Transaction> _userTransactions = [
  // Transaction(
  //     id: 't1',
  //     title: 'New Shoes',
  //     amount: 50.0,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: 't2',
  //     title: 'Weekly Groceries',
  //     amount: 77,
  //     date: DateTime.now(),
  //   ),
    ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }
     void _addNewTransaction(String txtitle, double txamount, DateTime chosenDate){
   final newTx = Transaction(id: DateTime.now().toString(), title: txtitle, amount: txamount, date: chosenDate);
     setState((){
       _userTransactions.add(newTx);
     });
   }

void _startAddNewTransaction(BuildContext ctx){
  showModalBottomSheet(context: ctx, builder: (_) {
return GestureDetector(
  onTap: (){},
  child: NewTransaction(_addNewTransaction),
  behavior: HitTestBehavior.opaque,
  ); 
  },);
}

 void _deleteTransaction(String id){
  setState(() {
    _userTransactions.removeWhere((tx){
      return tx.id==id;
    });
  },);
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Personal Expenses",
          style: GoogleFonts.actor(fontSize: 27,color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(onPressed:()=> _startAddNewTransaction(context), icon: Icon(Icons.add,color: Colors.white,))
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_userTransactions,_deleteTransaction),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: ()=> _startAddNewTransaction(context),
      ),
    );
    
  }
}

