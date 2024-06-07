import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _pageData = [];
  @override
  void initState() {
    super.initState();
    _getListData().then((data) => setState(() {
          _pageData = data;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView.builder(
        itemCount: _pageData.length,
        itemBuilder: (context, index) => _getListItemUi(index),
      ),
    );
  }

// Return a list of data after 1 second to emulate network request
  Future<List<String>> _getListData() async {
    await Future.delayed(const Duration(seconds: 1));
    return List<String>.generate(10, (index) => '$index title');
  }

  Widget _getListItemUi(int index) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.grey[600]),
      child: Center(
        child: Text(
          _pageData[index],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
