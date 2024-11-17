import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<String> hello;

  @override
  void initState() {
    super.initState();
    hello = fetchData();
  }

  // Simulated network request using Future.delayed
  Future<String> fetchData() async {
    return await Future.delayed(
      const Duration(seconds: 3),
      () => 'Hello, FutureBuilder!',
      // () => throw Exception('Failed to fetch data'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder Example'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: hello, // The future to be executed
          builder: (context, snapshot) {
            // Check the connection state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading spinner
            } else if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              );
            } else if (snapshot.hasData) {
              return Text(
                snapshot.data!,
                style: const TextStyle(fontSize: 24),
              );
            } else {
              return const Text('Something went wrong!');
            }
          },
        ),
      ),
    );
  }
}
