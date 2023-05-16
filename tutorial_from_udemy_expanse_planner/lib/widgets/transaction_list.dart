import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrains) {
            return Column(
              children: <Widget>[
                const Text('No transactions added yet!'),
                const SizedBox(height: 10),
                SizedBox(
                  height: constrains.maxHeight * 0.5,
                  child: Image.asset('assets/images/waiting.png'),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Text('\$${transactions[index].amount}'),
                  ),
                  title: Text(
                    transactions[index].title,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => deleteTx(transactions[index].id),
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteTx(transactions[index].id),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
