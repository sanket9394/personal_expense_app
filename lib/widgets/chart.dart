import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> userTransactions;

  Chart(this.userTransactions);

  List<Map<String, Object>> get weekdays {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      double totalSpend = 0;
      for (int i = 0; i < userTransactions.length; i++) {

          if(weekday.day == userTransactions[i].date.day &&
          weekday.month == userTransactions[i].date.month &&
          weekday.year == userTransactions[i].date.year){
            totalSpend+=userTransactions[i].amount;
          }


      }

      return {"day": DateFormat.E().format(weekday).substring(0,1), "total": totalSpend};
    }).reversed.toList();
  }


  double get totalSpendings{

    double tot=0;
    for(int i=0;i < weekdays.length; i++)
      tot+=weekdays[i]['total'];
    return tot;
  }

  

  @override
  Widget build(BuildContext context) {
    print(weekdays);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ...this.weekdays.map((data){
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'],
                  data['total'],
                  totalSpendings==0 ? 0.0 :(data['total'] as double)/totalSpendings 
                  ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
