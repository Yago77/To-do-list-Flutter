import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasks/tarefa.dart';

main () => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({ Key? key }) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
  
}

class _MainAppState extends State<MainApp> {

  TextEditingController edtTarefa = TextEditingController();
  List<Tarefa>tarefas = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.black
        )
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBar(),
        body: body(),
      ),
    );
  }

    body(){
    return SingleChildScrollView(
      child: Container(
        margin:  EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: edtTarefa,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.book,color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 2.5),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black ,width: 2.5),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                hintText: "Adicione uma Tarefa",
                labelText: "Tarefa",
                labelStyle: TextStyle(color: Colors.black)
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                    cadastrarElemento();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Cadastrar"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.paste
                      )
                    ],
                  )
                ),
                )
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: tarefas.length,
              itemBuilder: (context,index){
                return buildItem(index);
              }
            )
          ],
        ),
     ),
   );
   
    }
    appBar(){
    return AppBar(
      centerTitle: true,
      title: const Text("To do List",),
    );
  }

  buildItem (index) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: CheckboxListTile(
        secondary: Icon(Icons.delete , color: Colors.black),
        title: Text(tarefas[index].tarefa,
        style:TextStyle(
          decoration: tarefas[index].estado ? TextDecoration.lineThrough : TextDecoration.none
          )
        ),
        value: tarefas[index].estado,
        onChanged: (value){
          setState(() {
            tarefas[index].estado = !tarefas[index].estado;
            tarefas.sort((a,b) {
              if(b.estado) {
                return -1;
              }
              return 1;
            });
          });
        },
        activeColor: Colors.black,
      ),
    );
  }

  void cadastrarElemento(){
    setState(() {
      tarefas.add(Tarefa(edtTarefa.text,false));
      edtTarefa.clear();
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }
}


