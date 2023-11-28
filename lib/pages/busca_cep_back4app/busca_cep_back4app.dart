import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalhos_dio/pages/shared/drawer.dart';

import '../../apis/cep_api.dart';
import '../../models/cep_back4app_model.dart';
import '../../models/cep_model.dart';

class BuscaCepApi extends StatefulWidget {
  const BuscaCepApi({super.key});

  @override
  State<BuscaCepApi> createState() => _BuscaCepApiState();
}

class _BuscaCepApiState extends State<BuscaCepApi> {

  TextEditingController cepController = TextEditingController();
  bool loading = false;
  var cepModel = CepModel();
  late CepBack4AppModel cepBack4AppModel = CepBack4AppModel();
  late  CepApi cepApi;

  @override
  void initState() {
    cepApi = CepApi();
    listarCeps();
    super.initState();
  }



void listarCeps() async {
  setState(() {loading = true;});
  cepBack4AppModel = await cepApi.getAllBy4App(null);
  print(cepBack4AppModel.results);
  setState(() {loading = false;});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TRABALHOS DIO")),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("CEP"),
            TextFormField(
              controller: cepController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                // obrigatório
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ],
            ),

            TextButton(
                onPressed: () async{
                  setState(() {
                    loading = true;
                  });
                  var cep = cepController.text.replaceAll(RegExp(r'[^0-9]'), '');
                 // print(cep);
                  if(cep.length == 8){
                   cepModel = await cepApi.getByCep(cep);

                   ///Verifica se esta salvo na base BAck4App:
                    if(cepModel.cep != null){
                      var lista = await cepApi.getAllBy4App(cep);
                      if(lista.results!.isEmpty) {
                        cepModel.cep = cep;
                        await cepApi.add(cepModel);
                        listarCeps();
                        setState(() {});
                      }
                    }
                  }
                  setState(() {loading = false;});
                  },
                child: const Text("Pesquisar")
            ),
            const SizedBox(height: 25,),
            loading ?
            const Center(child: CircularProgressIndicator()) :
            Expanded(child:
                    ListView.builder(
                      itemCount: cepBack4AppModel.results!.length,
                        itemBuilder: (BuildContext bc, int index ){
                          var cep = cepBack4AppModel.results![index];
                          return Dismissible(
                            onDismissed: (DismissDirection dismissDirection) async {
                              setState(() {
                                loading = true;
                              });
                              await cepApi.delete(cep!.objectId!);
                              listarCeps();
                              setState(() {
                                loading = false;
                              });
                            },
                            key: Key(cep!.cep!),
                            child: ListTile(
                              title: Text(cep!.logradouro!),
                              subtitle:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('''${cep!.bairro!}, ${cep!.localidade!}/${cep!.uf}'''),
                                  Text('''Cep: ${cep.cep}''')
                                ],
                              )

                            ),
                          );

                    })

            )
          ],
        ),
      ),
      drawer: const DrawerCustom(),
    );

  }
}
