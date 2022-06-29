// ignore_for_file: overridden_fields

import 'package:bloc_repository/clients/clients.dart';

abstract class ClientState {
  List<Client>? clients;
  ClientState([this.clients]);
}

class ClientInitialState extends ClientState {
  @override
  List<Client>? clients = [];
  ClientInitialState({required this.clients}) : super(clients);
}

class ClientSucessState extends ClientState {
  @override
  List<Client>? clients;
  ClientSucessState({required this.clients}) : super();
}

class ClientErrorState extends ClientState {
  ClientErrorState(String errorMessage) : super();
}

class ClientLoadingState extends ClientState {}
