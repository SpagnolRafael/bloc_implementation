// ignore_for_file: overridden_fields

import 'package:bloc_repository/clients/clients.dart';

abstract class ClientState {
  List<Client>? clients;
  ClientState([this.clients]);
}

class ClientInitialState extends ClientState {
  ClientInitialState() : super([]);
}

class ClientSucessState extends ClientState {
  ClientSucessState({required List<Client> clients}) : super(clients);
}

class ClientErrorState extends ClientState {
  ClientErrorState() : super();
}

class ClientLoadingState extends ClientState {}
