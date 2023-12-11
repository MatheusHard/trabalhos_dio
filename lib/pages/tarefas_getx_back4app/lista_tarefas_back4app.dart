import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:trabalhos_dio/controllers/tarefas_getx_controller.dart';

class ListaDeTarefasBack4App extends StatelessWidget {
     ListaDeTarefasBack4App({super.key});

  var descricaoContoller = TextEditingController();

  var listaTarefasController = TarefaGetxController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tarefas GetX"),),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            descricaoContoller.text = "";
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Adicionar tarefa"),
                    content: TextField(
                      controller: descricaoContoller,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () async {
                            listaTarefasController.adicionar(descricaoContoller.text);
                            Navigator.pop(context);
                          },
                          child: const Text("Salvar"))
                    ],
                  );
                });
          },
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Apenas concluídos",
                      style: TextStyle(fontSize: 18),
                    ),
                    Obx(() {
                      return Switch(
                          value: listaTarefasController.apenasConcluidos,
                          onChanged:  listaTarefasController.setApenasConcluidos
                      );
                    }
                    )
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      itemCount: listaTarefasController.tarefas.length,
                      itemBuilder: (BuildContext bc, int index) {
                        var tarefa = listaTarefasController.tarefas[index];
                        return  Dismissible(
                          onDismissed: (DismissDirection dismissDirection) async {
                            listaTarefasController.excluir(tarefa.id);
                          },
                          key: Key(tarefa.descricao),
                          child: ListTile(
                            title: Text(tarefa.descricao),
                            trailing: Switch(
                              onChanged: (bool value) async {
                                tarefa.concluido = value;
                                listaTarefasController.atualizar(tarefa.id, tarefa.descricao,tarefa.concluido);
                              },
                              value: tarefa.concluido,
                            ),
                          ),
                        );
                      }
                  );

                }
                ),
              ),
            ],
          ),
        ));
  }
}

