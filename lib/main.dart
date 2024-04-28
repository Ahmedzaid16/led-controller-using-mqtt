import 'package:flutter/material.dart';
import 'mqtt_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MQTTControlPage(),
    );
  }
}

class MQTTControlPage extends StatefulWidget {
  const MQTTControlPage({super.key});

  @override
  _MQTTControlPageState createState() => _MQTTControlPageState();
}

class _MQTTControlPageState extends State<MQTTControlPage> {
  late MQTTManager mqttManager;

  @override
  void initState() {
    super.initState();
    mqttManager = MQTTManager(
      server: '192.168.43.100', // Replace with your MQTT Broker IP
      topic: 'home/led',
      clientIdentifier: 'flutter_client',
    );
    mqttManager.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MQTT LED Controller"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => mqttManager.publish("1"),
              child: const Text("Turn On"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => mqttManager.publish("0"),
              child: const Text("Turn Off"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mqttManager.disconnect();
    super.dispose();
  }
}
