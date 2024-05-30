// lib/cubit/network_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity;

  NetworkCubit(this._connectivity) : super(NetworkState.connected) {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      emit(NetworkState.disconnected);
    } else {
      emit(NetworkState.connected);
    }
  }
}
