import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      home: SimpleCalculator(),
    );
  }
}
class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  Widget buildButton(String buttonText, double buttonHeight, Color butttonColor){
    return   Container(
        height: MediaQuery.of(context).size.height*0.1*buttonHeight,
        color:butttonColor,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color:Colors.white,
                  width:1.0,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: ()=>buttonPressed(buttonText),
          child: new Text(
            buttonText,
            style:new TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Text('Calculator',
        style: new TextStyle(
          color: Colors.orangeAccent,
          fontSize: 25.0
        ),),
      ),
      body: Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: new Text(equation,
            style:new TextStyle(
              fontSize: equationfontsize,
            ),),

          ),

          new Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: new Text(result,
              style:new TextStyle(
                  fontSize: resultfontsize,
              ),),

          ),

          Expanded(
            child:Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Container(
               width:MediaQuery.of(context).size.width*.75,
               child: new Table(
                 children: [
                   TableRow(
                     children: [
                       buildButton("C", 1.0, Colors.redAccent),
                       buildButton("⌫", 1.0, Colors.blue),
                       buildButton("÷", 1.0, Colors.blue)

                     ]
                   ),

                   TableRow(
                       children: [
                         buildButton("7", 1.0, Colors.black54),
                         buildButton("8", 1.0, Colors.black54),
                         buildButton("9", 1.0, Colors.black54)

                       ]
                   ),

                   TableRow(
                       children: [
                         buildButton("4", 1.0, Colors.black54),
                         buildButton("5", 1.0, Colors.black54),
                         buildButton("6", 1.0, Colors.black54)

                       ]
                   ),

                   TableRow(
                       children: [
                         buildButton("1", 1.0, Colors.black54),
                         buildButton("2", 1.0, Colors.black54),
                         buildButton("3", 1.0, Colors.black54)

                       ]
                   ),

                   TableRow(
                       children: [
                         buildButton(".", 1.0, Colors.black54),
                         buildButton("0", 1.0, Colors.black54),
                         buildButton("00", 1.0, Colors.black54)

                       ]
                   ),


                 ],
               ),
             ),

               new Container(
                 width: MediaQuery.of(context).size.width*0.25,
                 child: Table(
                   children: [
                     TableRow(
                       children: [
                         buildButton("×",1.0, Colors.blue),
                       ]
                     ),

                     TableRow(
                         children: [
                           buildButton("-",1.0, Colors.blue),
                         ]
                     ),
                     TableRow(
                         children: [
                           buildButton("+",1.0, Colors.blue),
                         ]
                     ),
                     TableRow(
                         children: [
                           buildButton("=",2.0, Colors.redAccent),
                         ]
                     ),
                   ],
                 ),

              )
            ],
          )

        ],
      ),
    );
  }

  String equation="0";
  String result="0";
  String expression="";
  double equationfontsize=38.0;
  double resultfontsize=48.0;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationfontsize = 38.0;
        resultfontsize = 48.0;
      }
      else if (buttonText == "⌫") {
        equationfontsize = 48.0;
        resultfontsize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      }
      else if (buttonText == "=") {
        equationfontsize = 38.0;
        resultfontsize = 48.0;

      expression = equation;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      }
      catch (e) {
        result = "Error";
      }
    }
        else {
        if (equation == "0") {
          equation = buttonText;
        }
        else {
          equation = equation + buttonText;
        }
      }
    });

  }
}
