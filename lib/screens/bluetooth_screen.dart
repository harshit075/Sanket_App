import 'package:flutter/material.dart';
import 'device_detail_screen.dart'; // <-- import the new screen

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  bool isBluetoothOn = true; // mock state
  bool isScanning = false;
  String? connectedDevice;

  // Dummy device list
  final List<String> devices = [
    "SANKET DEVICE D1",
    "SANKET DEVICE D2",
    "SANKET DEVICE D3",
    "SANKET DEVICE D4",
  ];

  void _toggleBluetooth() {
    setState(() {
      isBluetoothOn = !isBluetoothOn;
      connectedDevice = null;
    });
  }

  void _scanDevices() {
    setState(() {
      isScanning = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isScanning = false;
      });
    });
  }

  void _connectToDevice(String device) {
    setState(() {
      connectedDevice = device;
    });

    // Navigate to new detail screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DeviceDetailScreen(deviceName: device),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Connected to $device")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bluetooth Devices"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isBluetoothOn ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
              color: Colors.white,
            ),
            onPressed: _toggleBluetooth,
          ),
        ],
      ),
      body: Column(
        children: [
          // Connected device section
          if (connectedDevice != null)
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.devices_other, color: Colors.green),
                title: Text(
                  connectedDevice!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Connected"),
                trailing: IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => setState(() => connectedDevice = null),
                ),
              ),
            ),

          // Scan button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.teal.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: isBluetoothOn ? _scanDevices : null,
              icon: const Icon(Icons.search),
              label: Text(isScanning ? "Scanning..." : "Scan for Devices"),
            ),
          ),

          // Device list
          Expanded(
            child: isScanning
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: devices.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return ListTile(
                        leading: const Icon(Icons.bluetooth, color: Colors.blue),
                        title: Text(device),
                        subtitle: const Text("Tap to connect"),
                        onTap: () => _connectToDevice(device),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
