import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'componenets/state_management.dart';
import '../pages/wildcat.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
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
  final TextEditingController mainTextController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    mainTextController.text = "Aaron Aplaon";
    amountController.text = "20.00";
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WildcatPage(title: 'Wildcat Page'),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('12:33', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Icon(Icons.wifi),
                SizedBox(width: 5),
                Icon(Icons.signal_cellular_alt),
                SizedBox(width: 5),
                Icon(Icons.battery_full),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.search, size: 40),
                        Text('Search'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.qr_code_scanner, size: 40),
                        Text('Scan'),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/Cap.png'),
                          radius: 20,
                        ),
                        Text('Cappillen Lee', overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/Shawn.png'),
                          radius: 20,
                        ),
                        Text('Shawn Li', overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/Ryan.png'),
                          radius: 20,
                        ),
                        Text('Ryan Shi', overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // add an image
                    Image.asset('assets/images/Venmo.png'),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/Johno.png')),
                      title: Text('Johnson Chan paid Ryan Shi'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Now',
                            textScaleFactor: .8,
                          ),
                          SizedBox(height: 10),
                          Text('Foodies'),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.favorite_border),
                              SizedBox(width: 10),
                              Icon(Icons.chat_bubble_outline),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Consumer<AppState>(
                      builder: (context, appState, child) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/Nathan.png'),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('You paid ${appState.mainText}'),
                              Text(
                                '- \$${appState.amount}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Now',
                                textScaleFactor: .8,
                              ),
                              const SizedBox(height: 10),
                              Text(appState.subText),
                              const SizedBox(height: 10),
                              const Row(
                                children: [
                                  Icon(Icons.favorite_border),
                                  SizedBox(width: 10),
                                  Icon(Icons.chat_bubble_outline),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const WildcatPage(title: 'Wildcat Page'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const Divider(),
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/Cap.png'),
                      ),
                      title: Text('Cappillen Lee paid Shawn Li'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2hrs',
                            textScaleFactor: .8,
                          ),
                          SizedBox(height: 10),
                          Text('Korean Chippies because I\'m gay'),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.favorite_border),
                              SizedBox(width: 10),
                              Icon(Icons.chat_bubble_outline),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/Ian.png'),
                      ),
                      title: Text('Ian Huang paid Nicky Dick'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '5hrs',
                            textScaleFactor: .8,
                          ),
                          SizedBox(height: 10),
                          Text('Pookie slappies'),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.favorite_border),
                              SizedBox(width: 10),
                              Icon(Icons.chat_bubble_outline),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/venmo_icon.png')),
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
