import 'package:bloc/bloc.dart';
import 'package:bloc_repository/clients/clients.dart';
import 'package:bloc_repository/clients/clients_repository.dart';
import 'package:bloc_repository/clients/clients_state.dart';

import 'clients_events.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  List<Client> _clients = [];
  final _repository = ClientRepository();
  ClientBloc() : super(ClientInitialState()) {
    on<LoadClientEvent>(
      (event, emit) async {
        _clients = _repository.load();
        emit(ClientLoadingState());
        await Future.delayed(const Duration(seconds: 3));
        emit(ClientSucessState(clients: _clients));
      },
    );
    on<AddClientEvent>(
      (event, emit) {
        if (event.client.name.length > 5) {
          emit(ClientErrorState());

          emit(ClientSucessState(clients: _clients));
        } else {
          emit(ClientSucessState(clients: _repository.add(event.client)));
        }
      },
    );

    on<RemoveClientEvent>(
      (event, emit) {
        emit(ClientSucessState(clients: _repository.remove(event.client)));
      },
    );
  }
}
