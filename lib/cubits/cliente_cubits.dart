import 'package:bloc/bloc.dart';
import 'package:bloc_repository/clients/clients.dart';
import 'package:bloc_repository/clients/clients_repository.dart';
import 'package:bloc_repository/cubits/client_cubit_states.dart';

class ClientCubit extends Cubit<ClientCubitState> {
  final ClientRepository repository;
  ClientCubit({required this.repository}) : super(ClientCubitInitialState());

  getClientsFromRepository() async {
    try {
      emit(ClientCubitLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      final clients = repository.load();
      emit(ClientCubitSucessState(clients: clients));
    } catch (e) {
      emit(ClientCubitErrorState());
    }
  }

  addClientsToRepository(Client client) {
    try {
      if (client.name.length > 5) {
        emit(ClientCubitErrorState());
      } else {
        final clients = repository.add(client);
        emit(ClientCubitSucessState(clients: clients));
      }
    } catch (e) {
      emit(ClientCubitErrorState());
    }
  }

  removeClientsFromRepository({required Client client}) {
    try {
      final clients = repository.remove(client);
      emit(ClientCubitSucessState(clients: clients));
    } catch (e) {
      emit(ClientCubitErrorState());
    }
  }
}
