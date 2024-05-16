import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  double amount = 3.0;
  String mainText = "WILDCAT LOUNGE";
  String subText = '"to WILDCAT LOUNGE"';
  String bubbleText = "WL";

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
                amount = double.tryParse(amountController.text) ?? amount;
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                mainText = mainTextController.text;
                subText = subTextController.text;
                bubbleText = bubbleTextController.text;
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
                //navigate to main.dart
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                }),
            const Text('Payment Details'),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const CircleAvatar(
                //   backgroundColor: Colors.grey,
                //   child: Text('WL'),
                // ),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(bubbleText),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _editText(context),
                  child: Text(
                    mainText,
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
                    subText,
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
                    amount % 1 != 0
                        ? '\$${amount.toStringAsFixed(2)}'
                        : '\$${amount.toInt()}',
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
                  // '/Users/nahoang/Desktop/Files/wildcat/wildcat/assets/images/social.png',
                  'assets/images/social.png',
                  height: 23.0,
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              // '/Users/nahoang/Desktop/Files/wildcat/wildcat/assets/images/business.png',
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
          const ListTile(
            title: Text('Paid to'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('@wildcat-15'),
                Text(
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
      ),
    );
  }
}
