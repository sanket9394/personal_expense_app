import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function inputHandler;

  NewTransaction(this.inputHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime currPickedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    final eneteredDate = currPickedDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || eneteredDate ==null) return;



    widget.inputHandler(enteredTitle, enteredAmount,eneteredDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext ctx) {
    showDatePicker(
            context: ctx,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        currPickedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => this.submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(this.currPickedDate == null
                        ? 'No Date Choosen'
                        :'Picked ${DateFormat.yMMMd().format(currPickedDate)}' ),
                  ),
                  FlatButton(
                    child: Text('Choose Date',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      _presentDatePicker(context);
                    },
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text('Add Transaction'),
                  onPressed: submitData,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
