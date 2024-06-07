import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String>? _pageData;
  bool get _fetchingData => _pageData == null;

  @override
  void initState() {
    _getListData(hasData: false)
        .then((data) => setState(() {
              if (data.isEmpty) {
                data.add("No data available");
                // _pageData = ['No data available'];
              }
              _pageData = data;
            }))
        .catchError((error) => setState(() {
              _pageData = [error];
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: _fetchingData
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _pageData?.length,
              itemBuilder: (context, index) => _getListItemUi(index),
            ),
    );
  }

// Return a list of data after 1 second to emulate network request
  Future<List<String>> _getListData(
      {bool hasError = false, hasData = true}) async {
    await Future.delayed(const Duration(seconds: 2));

    if (hasError) {
      return Future.error('Error fetching data');
    }

    if (!hasData) return [];

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
          _pageData![index],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
