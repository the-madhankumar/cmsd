import 'package:cmsd_home/localization/locales.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_bluetooth_seria_changed/flutter_bluetooth_serial.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lottie/lottie.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFFFFFF, <int, Color>{
          50: Colors.white,
          100: Colors.white,
          200: Colors.white,
          300: Colors.white,
          400: Colors.white,
          500: Colors.white,
          600: Colors.white,
          700: Colors.white,
          800: Colors.white,
          900: Colors.white
        }),
      ),
      home: HomePage(),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool connected = true;

  bool isConnectedPopupShown = false;

  final List<DrawerItem> drawerItems = [
    const DrawerItem(title: LocaleData.profile, icon: Icons.person, page: ProfilePage()),
    const DrawerItem(title: LocaleData.history, icon: Icons.info, page: HistoryPage()),
    const DrawerItem(title: LocaleData.adddevice, icon: Icons.code, page: AddDevicePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocaleData.title.getString(context),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor:
            const Color.fromARGB(246, 240, 237, 237).withOpacity(0.5),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(246, 240, 237, 237),
              ),
              child: Text(
                LocaleData.info8.getString(context),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            for (var item in drawerItems)
              ListTile(
                title: Text(item.title.getString(context)),
                leading: Icon(item.icon),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item.page,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: connected
                      ? Container(
                          margin: const EdgeInsets.only(
                              top: 20.0), // Adjust the top margin
                          child: Opacity(
                            opacity:
                                0.5, // Set the desired opacity (0.5 for 50%)
                            child: Column(
                              children: [
                                Lottie.network(
                                  'https://lottie.host/8cb372e2-6d74-4086-9ec8-cb6d2234d0ab/qRwKy9dAzj.json',
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                    height:
                                        40), // Add space between image and text
                                const Text(
                                  'Connected',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(
                              top: 20.0), // Adjust the top margin
                          child: Opacity(
                            opacity:
                                0.5, // Set the desired opacity (0.5 for 50%)
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/notcon.png',
                                  fit: BoxFit.cover,
                                  height: 250, // Adjust the height as needed
                                  width: 350, // Adjust the width as needed
                                ),
                                const SizedBox(
                                    height:
                                        40), // Add space between image and text
                                const Text(
                                  'Device Not Connected',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 2.0,
                  color: Colors.transparent,
                ),
              ),
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(129, 255, 255, 255).withOpacity(0.5),
                    const Color.fromARGB(124, 255, 255, 255).withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Data",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Device",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) {
          switch (index) {
            case 0:
              // Use pushReplacement instead of push to prevent stacking pages
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ElementsPage(),
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddDevicePage(),
                ),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryPage(),
                ),
              );
              break;
            case 4:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeDetailsPage(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final Widget page;

  const DrawerItem(
      {required this.title, required this.icon, required this.page});
}

class ElementsPage extends StatelessWidget {
  ElementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleData.info3.getString(context),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor:
            const Color.fromARGB(246, 240, 237, 237).withOpacity(0.5),
      ),
      body: Column(
        children: [
          // First Sectional Box
          Container(
            width: double.infinity,
            height: 150,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(
                    0,
                    3,
                  ),
                ),
              ],
            ),
            child: Center(
              child: Text(
                LocaleData.info4.getString(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // Second Sectional Box
          Container(
            width: double.infinity,
            height: 150,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(
                    0,
                    3,
                  ),
                ),
              ],
            ),
            child: Center(
              child: Text(
                LocaleData.info5.getString(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // Third Sectional Box
          Container(
            width: double.infinity,
            height: 150,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(
                    0,
                    3,
                  ),
                ),
              ],
            ),
            child: Center(
              child: Text(
                LocaleData.info6.getString(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Data",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Device",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
              break;
            case 1:
              // You are already on the ElementsPage, no need to navigate again.
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddDevicePage(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryPage(),
                ),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeDetailsPage(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String boxText;

  const DetailPage(this.boxText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 74, 157, 195),
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: Text(
          'You tapped on $boxText',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddDevicePageState createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  String user = "User1";
  final List<BluetoothDiscoveryResult> _devicesList = [];
  BluetoothConnection? _bluetoothConnection;
  late final DatabaseReference fireRef;

  TextEditingController _ssidController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _BluetoothScanPageState() {
    fireRef = FirebaseDatabase.instance.ref(user);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _checkBluetoothStatus() async {
    bool isEnabled = (await FlutterBluetoothSerial.instance.isEnabled) ?? false;
    if (!isEnabled) {
      _askUserToEnableBluetooth();
    } else {
      _startDiscovery();
    }
  }

  Future<void> _askUserToEnableBluetooth() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bluetooth is turned off'),
          content:
              const Text('Please turn on Bluetooth and try again to continue.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                OpenSettings.openBluetoothSetting();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> requestBluetoothScanPermission() async {
    var status = await Permission.bluetoothScan.status;
    if (status.isDenied) {
      PermissionStatus result = await Permission.bluetoothScan.request();
      if (result.isGranted) {
        _startDiscovery();
      } else {
        _showNotGrantedAlert();
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else {
      _checkBluetoothStatus();
    }
  }

  void _startDiscovery() async {
    setState(() {
      _devicesList.clear();
    });

    await FlutterBluetoothSerial.instance.cancelDiscovery();

    FlutterBluetoothSerial.instance.startDiscovery().listen((device) {
      setState(() {
        _devicesList.add(device);
      });
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      _disconnect();

      final BluetoothConnection connection =
          await BluetoothConnection.toAddress(device.address);

      print('Connected to ${device.name}');

      setState(() {
        _bluetoothConnection = connection;
      });
    } catch (error) {
      print('Error connecting to ${device.name}: $error');
    }
  }

  void _sendData(String data) {
    try {
      if (_bluetoothConnection != null) {
        _bluetoothConnection!.output.add(Uint8List.fromList(data.codeUnits));
        _bluetoothConnection!.output.allSent.then((_) {
          print('Data sent: $data');
        });
      } else {
        _showNotConnectedAlert();
      }
    } catch (error) {
      if (error is StateError) {
        _showNotPairedAlert();
      } else {
        print('Error sending data: $error');
      }
    }
  }

  void _showNotConnectedAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Not Connected'),
          content: const Text(
              'Please connect to the device before sending WIFI credentials.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await requestBluetoothScanPermission();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showNotGrantedAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Bluetooth permission not granted please grant access to continue.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await requestBluetoothScanPermission();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showNotPairedAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Device Not Paired'),
          content: const Text(
              'Please pair with a Bluetooth device before sending data.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await requestBluetoothScanPermission();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _disconnect() {
    if (_bluetoothConnection != null) {
      _bluetoothConnection!.dispose();
      _bluetoothConnection = null;
      print('Disconnected');
    }
  }

  @override
  void dispose() {
    _disconnect();
    FirebaseDatabase.instance.goOffline(); // Close Firebase connection
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleData.adddevice.getString(context),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor:
            const Color.fromARGB(246, 240, 237, 237).withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await requestBluetoothScanPermission();
                await connectToFirebase();
              },
              child: const Text('Start Scan'),
            ),
            const SizedBox(height: 16),
            const Text('Discovered Devices:'),
            Expanded(
              child: ListView.builder(
                itemCount: _devicesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_devicesList[index].device.name ?? 'Unknown'),
                    subtitle: Text(_devicesList[index].device.address),
                    trailing: _devicesList[index].device.isBonded
                        ? const Icon(Icons.bluetooth_connected,
                            color: Colors.green)
                        : const Icon(Icons.bluetooth, color: Colors.grey),
                    onTap: () {
                      _connectToDevice(_devicesList[index].device);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text("Enter the WIFI Details:"),
            TextField(
              controller: _ssidController,
              decoration: const InputDecoration(labelText: 'Enter Wifi Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Enter Password'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String ssid = _ssidController.text;
                String password = _passwordController.text;
                _sendData('$ssid:$password');
              },
              child: const Text('Send WiFi Credentials'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Data",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Device",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: const Color.fromARGB(255, 132, 143, 148),
        currentIndex: 2, // Set the initial index here
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ElementsPage(),
                ),
              );
              break;
            case 2:
              // You are already on the AddDevicePage, no need to navigate again.
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryPage(),
                ),
              );
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeDetailsPage(),
                ),
              );
              break;
          }
        },
      ),
    );
  }

  Future<void> connectToFirebase() async {
    try {
      fireRef.once().then((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        print('Connected to Firebase: ${snapshot.value}');
      });
    } catch (error) {
      print('Error connecting to Firebase: $error');
    }
  }
}

class HomeDetailsPage extends StatefulWidget {
  const HomeDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeDetailsPageState createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  int colorIndex = 0;
  late List<Color> themeColors;

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    print("out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocaleData.info9.getString(context),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor:
            const Color.fromARGB(246, 240, 237, 237).withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleData.info7.getString(context),
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              title: Text(LocaleData.setbtn1.getString(context)),
              subtitle: const Text('Manage your account settings'),
              leading: const Icon(Icons.account_circle),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(LocaleData.setbtn2.getString(context)),
              subtitle: const Text('Configure app notifications'),
              leading: const Icon(Icons.notifications),
            ),
            ListTile(
              title: Text(LocaleData.setbtn3.getString(context)),
              subtitle: const Text('Configure app languages'),
              leading: const Icon(Icons.language),
              trailing: DropdownButton(
                value: _currentLocale, // Set the initially selected option
                items: const [
                  DropdownMenuItem(
                    value: "en",
                    child: Text("English")
                  ),
                  DropdownMenuItem(
                    value: "ta",
                    child: Text("தமிழ்")
                  ),
                  DropdownMenuItem(
                    value: "hi",
                    child: Text("हिंदी")
                  )
                ], 
                onChanged: (String? value) {
                  _setLocale(value);
                },
              ),
            ),
            ListTile(
              title: Text(LocaleData.setbtn4.getString(context)),
              leading: const Icon(Icons.logout),
              onTap: signUserOut,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Data",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Device",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        currentIndex: 4,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ElementsPage(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddDevicePage(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryPage(),
                ),
              );
              break;
            case 4:
              // You are already on the HistoryPage, no need to navigate again.
              break;
          }
        },
      ),
    );
  }

  late  FlutterLocalization _flutterLocalization;
  late String _currentLocale = "en";

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    //print(_currentLocale);
  }

  void _setLocale(String? value) {
    if (value == null) return;
    if(value == "en"){
      _flutterLocalization.translate("en");
    } else if(value == "hi"){
      _flutterLocalization.translate("hi");
    } else if(value == "ta"){
      _flutterLocalization.translate("ta");
    } else{
      return;
    }
    setState(() {
      _currentLocale = value;
    });
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocaleData.history.getString(context),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor:
            const Color.fromARGB(246, 240, 237, 237).withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // Handle search action
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Data",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ElementsPage(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddDevicePage(),
                ),
              );
              break;
            case 3:
              // You are already on the SourceDetailsPage, no need to navigate again.
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeDetailsPage(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: const Color.fromARGB(
                255, 255, 255, 255), // Change the color as needed
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/images/profile.png'), // Replace with your image asset
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe', // Replace with the actual username
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildProfileRow(Icons.person, 'Username', 'john_doe123'),
          buildProfileRow(Icons.email, 'Email', 'john.doe@example.com'),
          buildProfileRow(Icons.lock, 'Password', '********'),
        ],
      ),
    );
  }

  Widget buildProfileRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
