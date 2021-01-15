import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

      String _info = "Informe seus dados";

  void _Reset(){

    weightController.text = "";
    heightController.text = "";

    setState(() {
      _info = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });

  }

  void _Calculate(){

    setState(() {//metodo para conseguir alterar
      
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;


      double imc = weight/(height * height);

      if(imc < 18.6){
        _info = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.6 && imc < 24.9){
        _info = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 24.9 && imc < 29.9){
        _info = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 29.9 && imc < 34.9){
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 34.9 && imc < 39.9){
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40){
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caulculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _Reset)
        ],
      ),
      backgroundColor: Colors.white,

      // coluna de centro
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //Icone pessoa
              Icon(Icons.account_circle_rounded, size: 120.0, color: Colors.purple),

              //parte de peso
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso em Quilograma",
                    labelStyle: TextStyle(color: Colors.purple)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "insira seu peso";
                  }
                },
              ),
              // parte de altura
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Sua altura em centimetros",
                    labelStyle: TextStyle(color: Colors.purple)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "insira sua altura";
                  }
                },
              ),

              // container para conter uma função e definir tamanho
              Padding(
                padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      // se estiver tudo valido entrar aqui e faz a função
                      if(_formKey.currentState.validate()){
                        _Calculate();
                      }
                    }, // raise button criar botão estilo canvas unity
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.purple,
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple, fontSize: 25.0),
              )
            ],
          ),
        )
      ),
    );
  }
}
