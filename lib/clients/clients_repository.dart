import 'package:bloc_repository/clients/clients.dart';

class ClientRepository {
  final List<Client> _clients = [];

  List<Client> add(Client client) {
    _clients.add(client);
    return _clients;
  }

  List<Client> load() {
    _clients.addAll([
      Client(name: "Rafael", cpf: "218.894.608-88"),
      Client(name: "Viviane", cpf: "228.894.608-88"),
      Client(name: "Claudia", cpf: "338.894.608-88"),
      Client(name: "Paulo", cpf: "326.894.608-88"),
    ]);
    return _clients;
  }

  List<Client> remove(Client client) {
    _clients.remove(client);
    return _clients;
  }
}
