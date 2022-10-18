import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados !";

  void _limparCampos() {

    alturaController.text = "";
    pesoController.text = "";

    setState(() {

      _infoText = "Informe seus dados !";

    });
  }

  void _calcular() {

    setState(() {

      double peso = double.parse(pesoController.text);

      double altura = double.parse(alturaController.text) / 100;

      double imc = peso / (altura * altura);

      if(imc < 18.6) {

        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(2)})";

      } else if(imc >= 18.9 && imc <= 24.9) {

        _infoText = "Peso ideal (${imc.toStringAsPrecision(2)})";

      } else if(imc >= 25.0 && imc <= 29.9) {

        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(2)})";

      } else if(imc >= 30.0 && imc <= 34.9) {

        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(2)})";

      } else if(imc >= 35.0 && imc <= 39.9) {

        _infoText = "Obesidade Grau 2 (${imc.toStringAsPrecision(2)})";

      } else if(imc >= 40) {

        _infoText = "Obesidade Grau 3 (${imc.toStringAsPrecision(2)})";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limparCampos,
          )
        ],
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.greenAccent),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.deepPurple)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Insira seu Peso !";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura",
                    labelStyle: TextStyle(color: Colors.deepPurple)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if(value!.isEmpty) {

                    return "Informe a sua altura !";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {

                        _calcular();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
