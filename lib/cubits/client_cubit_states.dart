import 'package:bloc_repository/clients/clients.dart';

abstract class ClientCubitState {}

class ClientCubitInitialState extends ClientCubitState {
  List<Client> clients = [];
  ClientCubitInitialState() : super();
}

class ClientCubitSucessState extends ClientCubitState {
  List<Client> clients;
  ClientCubitSucessState({required this.clients}) : super();
}

class ClientCubitLoadingState extends ClientCubitState {}

class ClientCubitErrorState extends ClientCubitState {}
