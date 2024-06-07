import 'dart:async';
import 'package:flutter_basics/home_event.dart';

import './home_state.dart';

class HomeModal {
  final StreamController<HomeState> _stateController =
      StreamController<HomeState>();

  List<String>? _listItems;

  Stream<HomeState> get homeState => _stateController.stream;

  void dispatch(HomeEvent event) {
    print('dispatching event: $event');
    if (event is FetchData) {
      _getListData(hasData: event.hasData, hasError: event.hasError);
    }
  }

  Future _getListData({bool hasError = false, hasData = true}) async {
    _stateController.add(BusyHomeState());

    await Future.delayed(const Duration(seconds: 2));

    if (hasError) {
      return _stateController.addError('Error fetching data');
    }

    if (!hasData) return _stateController.add(DataFetchedHomeState([]));

    _listItems = List<String>.generate(10, (index) => '$index title');

    _stateController.add(DataFetchedHomeState(_listItems!));
  }
}
