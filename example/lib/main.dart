import 'package:flutter/material.dart';
import 'package:optimized_search_field/optimized_search_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optimized Search Field Example',
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            mouseCursor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return SystemMouseCursors.forbidden;
              }
              return SystemMouseCursors.click;
            }),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String currentItem;
  late List<String> currentItems;
  @override
  void initState() {
    currentItem = 'none';
    currentItems = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
          children: [
            Text('You Entered: $currentItem', style: TextStyle(fontSize: 24)),
            SizedBox(height: 200),
            OptimizedSearchField(
              onChanged:
                  (text) => setState(() {
                    currentItem = text;
                  }),
              labelText: 'Enter Item',
              dropDownList: List.generate(
                100000,
                (index) => 'item ${index + 1}',
              ),
              itemStyle: const ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              menuMaxHeight: 200,
              optionsViewOpenDirection: OptionsViewOpenDirection.up,
            ),
            SizedBox(height: 200),
            MultiSearchField(
              labelText: 'Enter Items',
              dropDownList: List.generate(
                100000,
                (index) => 'item ${index + 1}',
              ),
              removeEvent:
                  (value) => setState(() {
                    currentItems.remove(value);
                  }),
              values: currentItems,
              onChanged:
                  (text) => setState(() {
                    currentItems.add(text);
                  }),
              menuMaxHeight: 400,
            ),
            SizedBox(height: 800),
          ],
        ),
      ),
    );
  }
}
