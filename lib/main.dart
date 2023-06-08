import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_overvew_07/models/babies.dart';
import 'package:provider_overvew_07/models/dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Dog>(
          create: (context) => Dog(name: 'dog07', bread: 'breed07', age: 3),
        ),
        FutureProvider<int>(
            create: (context) {
              final int dogAge = context.read<Dog>().age;
              final babies = Babies(age: dogAge);
              return babies.getBabies();
            },
            initialData: 0),
        StreamProvider<String>(
            create: (context) {
              final int dogAge = context.read<Dog>().age;
              final babies = Babies(age: dogAge * 2);
              return babies.bark();
            },
            initialData: 'Bark 0 times')
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proovider 07"),
        actions: const [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '- name: ${context.watch<Dog>().name}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const BreedAndAge()
          ],
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- bread: ${context.select<Dog, String>((Dog dog) => dog.bread)}',
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Age()
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- age: ${context.select<Dog, int>((Dog dog) => dog.age)}',
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(height: 10.0),
        Text(
          '- number of babies: ${context.read<int>()}',
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(height: 10.0),
        Text(
          '- ${context.watch<String>()}',
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () => context.read<Dog>().grow(),
          child: const Text(
            'Grow',
            style: TextStyle(fontSize: 20.0, color: Colors.green),
          ),
          
        ),
      ],
    );
  }
}
