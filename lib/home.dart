import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: FutureBuilder<List<String>>(
            future: _getListData(hasData: true),
            builder: (buildContext, snapshot) {
              if (snapshot.hasError) {
                return _getInformationMessage(snapshot.error.toString());
              }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              var listItems = snapshot.data;

              if (listItems!.isEmpty) {
                return _getInformationMessage('No data found');
              }

              return ListView.builder(
                itemCount: listItems.length,
                itemBuilder: (context, index) =>
                    _getListItemUi(index, listItems),
              );
            }));
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

  Widget _getListItemUi(int index, List<String>? listItems) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: Colors.grey[600]),
      child: Center(
        child: Text(
          listItems![index],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _getInformationMessage(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[500]),
      ),
    );
  }
}
