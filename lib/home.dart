import 'package:flutter/material.dart';
import 'package:flutter_basics/home_event.dart';

import 'home_modal.dart';
import 'home_state.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final model = HomeModal();

  @override
  void initState() {
    model.dispatch(FetchData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.dispatch(FetchData(hasData: false, hasError: false));
          },
        ),
        backgroundColor: Colors.grey[900],
        body: StreamBuilder(
            stream: model.homeState,
            builder: (buildContext, snapshot) {
              if (snapshot.hasError) {
                return _getInformationMessage(snapshot.error.toString());
              }

              var homeState = snapshot.data;

              if (!snapshot.hasData || homeState == BusyHomeState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (homeState is DataFetchedHomeState) {
                if (!homeState.hasData) {
                  return _getInformationMessage('No data found');
                }
              }

              if (homeState is DataFetchedHomeState) {
                return ListView.builder(
                  itemCount: homeState.data.length,
                  itemBuilder: (context, index) =>
                      _getListItemUi(index, homeState.data),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
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
