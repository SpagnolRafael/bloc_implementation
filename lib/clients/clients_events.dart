import 'package:bloc_repository/clients/clients.dart';

abstract class ClientEvent {
  //assinatura de metodo ou estrutura padrao para usar em todos os eventos

}

class LoadClientEvent extends ClientEvent {}

class AddClientEvent extends ClientEvent {
  Client client;

  AddClientEvent({required this.client});
}

class RemoveClientEvent extends ClientEvent {
  Client client;

  RemoveClientEvent({required this.client});
}
