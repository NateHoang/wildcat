import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../componenets/state_management.dart';

class WildcatPage extends StatefulWidget {
  const WildcatPage({super.key, required this.title});
  final String title;

  @override
  State<WildcatPage> createState() => _WildcatPageState();
}

class _WildcatPageState extends State<WildcatPage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _editAmount(BuildContext context) {
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter new amount'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Enter amount'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                Provider.of<AppState>(context, listen: false).updateAmount(
                    double.tryParse(amountController.text) ?? 3.0);
              });
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _editText(BuildContext context) {
    TextEditingController mainTextController = TextEditingController();
    TextEditingController subTextController = TextEditingController();
    TextEditingController bubbleTextController = TextEditingController();
    TextEditingController sendTextController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter new text'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: mainTextController,
              decoration: const InputDecoration(hintText: 'Enter main text'),
            ),
            TextField(
              controller: subTextController,
              decoration: const InputDecoration(hintText: 'Enter sub text'),
            ),
            TextField(
              controller: bubbleTextController,
              decoration: const InputDecoration(hintText: 'Enter bubble text'),
            ),
            TextField(
              controller: sendTextController,
              decoration: const InputDecoration(hintText: 'Enter send text'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                Provider.of<AppState>(context, listen: false)
                    .updateMainText(mainTextController.text);
                Provider.of<AppState>(context, listen: false)
                    .updateSubText(subTextController.text);
                Provider.of<AppState>(context, listen: false)
                    .updateBubbleText(bubbleTextController.text);
                Provider.of<AppState>(context, listen: false)
                    .updateSendText(sendTextController.text);
              });
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // make the title on the left side
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text('Payment Details'),
          ],
        ),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(appState.bubbleText),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _editText(context),
                      child: Text(
                        appState.mainText,
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _editText(context),
                      child: Text(
                        appState.subText,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _editAmount(context),
                      child: Text(
                        //if there are decimals show the format as is, otherwise show as integer
                        appState.amount % 1 != 0
                            ? '\$${appState.amount.toStringAsFixed(2)}'
                            : '\$${appState.amount.toInt()}',
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Social Activity'),
                    const SizedBox(height: 4),
                    Image.asset(
                      'assets/images/social.png',
                      height: 23.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/business.png',
                  fit: BoxFit.cover,
                ),
              ),
              const ListTile(
                title: Text('Status'),
                subtitle: Text('Complete'),
              ),
              const ListTile(
                title: Text("Payment Method"),
              ),
              ListTile(
                leading: SizedBox(
                  height: 23.0,
                  width: 23.0,
                  child: Image.asset(
                    'assets/images/WF.png',
                  ),
                ),
                subtitle: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('WELLS FARGO BANK NA'),
                    Text('Personal Checking'),
                    Text('Bank •• 0459')
                  ],
                ),
              ),
              ListTile(
                title: const Text('Transaction details'),
                subtitle: Text(
                  'Date: ${selectedDate.toLocal().toString().split(' ')[0]}, Time: ${selectedTime.format(context)}',
                ),
                trailing: const Icon(Icons.edit),
                onTap: () async {
                  await _selectDate(context);
                  _selectTime(context);
                },
              ),
              ListTile(
                title: const Text('Paid to'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appState.sendText),
                    const Text(
                        'you paid for goods or services. You can get a full refund by texting this number below if you have any questions. Thank you for your usage of venmo.'),
                  ],
                ),
              ),
              const ListTile(
                title: Text('Type of transaction'),
                subtitle: Text('Purchase'),
              ),
              const ListTile(
                title: Text('Transaction ID'),
                subtitle: Text('3978511740254646200'),
              ),
            ],
          );
        },
      ),
    );
  }
}
