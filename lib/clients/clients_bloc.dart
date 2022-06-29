import 'package:bloc/bloc.dart';
import 'package:bloc_repository/clients/clients_repository.dart';
import 'package:bloc_repository/clients/clients_state.dart';

import 'clients_events.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final _repository = ClientRepository();
  ClientBloc() : super(ClientInitialState(clients: [])) {
    on<LoadClientEvent>(
      (event, emit) async {
        if (_repository.load().isNotEmpty) {
          emit(ClientLoadingState());
          await Future.delayed(const Duration(seconds: 3));
          emit(ClientSucessState(clients: _repository.load()));
        } else {
          emit(ClientErrorState());
        }
      },
    );
    on<AddClientEvent>(
      (event, emit) {
        emit(ClientSucessState(clients: _repository.add(event.client)));
      },
    );

    on<RemoveClientEvent>(
      (event, emit) {
        emit(ClientSucessState(clients: _repository.remove(event.client)));
      },
    );
  }
}
