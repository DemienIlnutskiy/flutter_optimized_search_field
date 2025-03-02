import 'package:flutter/material.dart';
import 'package:optimized_search_field/optimized_search_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optimized Search Field Example',
      theme: ThemeData(
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
            Text('You Entered: $currentItem',
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 200),
            OptimizedSearchField(
              onChanged: (text) => setState(() {
                currentItem = text;
              }),
              labelText: 'Enter Item',
              dropDownList: List.generate(
                100000,
                (index) => 'item ${index + 1}',
              ),
              itemStyle: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              menuMaxHeight: 200,
              fieldSuffixIcon: ({
                required menuOpened,
                required onCloseIconTap,
                required onlyCloseMenu,
              }) =>
                  menuOpened
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: onCloseIconTap,
                        )
                      : const Icon(Icons.arrow_drop_down),
            ),
            const SizedBox(height: 200),
            MultiSearchField(
              labelText: 'Enter Items',
              dropDownList: List.generate(
                100000,
                (index) => 'item ${index + 1}',
              ),
              removeEvent: (value) => setState(() {
                currentItems.remove(value);
              }),
              values: currentItems,
              onSelected: (text) => setState(() {
                currentItems.add(text);
              }),
              menuMaxHeight: 400,
              fieldSuffixIcon: null,
            ),
            const SizedBox(height: 800),
          ],
        ),
      ),
    );
  }
}
