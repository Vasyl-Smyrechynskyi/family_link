// import 'dart:async';
// import 'dart:io';

// import 'package:connectivity/connectivity.dart';

// class InternetConnectivityService {
//   static final InternetConnectivityService _internetConnectivity =
//       InternetConnectivityService._internal();

//   factory InternetConnectivityService() {
//     return _internetConnectivity;
//   }

//   InternetConnectivityService._internal(){
//     initialize();
//   }

//   bool hasConnection = false;

//   //This is how we'll allow subscribing to connection changes
//   StreamController connectionChangeController =
//       StreamController.broadcast();

//   //flutter_connectivity
//   final Connectivity _connectivity = Connectivity();

//   //Hook into flutter_connectivity's Stream to listen for changes
//   //And check the connection status out of the gate
//   void initialize() {
//     _connectivity.onConnectivityChanged.listen(_connectionChange);
//     checkConnection();
//   }

//   Stream get connectionChange => connectionChangeController.stream;

//   //flutter_connectivity's listener
//   void _connectionChange(ConnectivityResult result) {
//     checkConnection();
//   }

//   //The test to actually see if there is a connection
//   Future<bool> checkConnection() async {
//     bool previousConnection = hasConnection;

//     try {
//       final result = await InternetAddress.lookup('example.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         hasConnection = true;
//       } else {
//         hasConnection = false;
//       }
//     } on SocketException catch (_) {
//       hasConnection = false;
//     }

//     //The connection status changed send out an update to all listeners
//     if (previousConnection != hasConnection) {
//       connectionChangeController.add(hasConnection);
//     }

//     return hasConnection;
//   }

//   void dispose() {
//     connectionChangeController.close();
//   }
// }
