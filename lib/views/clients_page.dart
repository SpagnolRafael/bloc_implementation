import 'package:bloc_repository/clients/clients.dart';
import 'package:bloc_repository/clients/clients_bloc.dart';
import 'package:bloc_repository/clients/clients_events.dart';
import 'package:bloc_repository/clients/clients_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late final ClientBloc bloc;
  late final TextEditingController _nomeController = TextEditingController();
  late final TextEditingController _cpfController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  // showDialog(
  //                     context: context,
  //                     builder: (context) {
  //                       return const SizedBox(
  //                         width: 150,
  //                         height: 150,
  //                         child: AlertDialog(
  //                           content: Text("Nome superior a 5 caracteres"),
  //                         ),
  //                       );
  //                     }),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista Clientes"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        color: Colors.grey.shade400,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _nomeController,
                                decoration: const InputDecoration(
                                    hintText: "Nome",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _cpfController,
                                decoration: const InputDecoration(
                                    hintText: "Cpf",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  bloc.add(AddClientEvent(
                                    client: Client(
                                        name: _nomeController.text,
                                        cpf: _cpfController.text),
                                  ));
                                  _nomeController.text = "";
                                  _cpfController.text = "";
                                  Navigator.pop(context);
                                },
                                child: const Text("Adicionar"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.person_add),
            ),
          )
        ],
      ),
      body: BlocConsumer<ClientBloc, ClientState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ClientErrorState) {
            const snackBar =
                SnackBar(content: Text("Erro: Nome maior que 5 caracteres"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is ClientLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          final clientList = state.clients ?? [];
          return ListView.separated(
            itemBuilder: (context, index) => ListTile(
              title: Text(clientList[index].name),
              subtitle: Text(clientList[index].cpf),
              trailing: IconButton(
                onPressed: () {
                  bloc.add(RemoveClientEvent(client: clientList[index]));
                },
                icon: const Icon(Icons.delete),
              ),
            ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: clientList.length,
          );
        },
      ),
    );
  }
}
