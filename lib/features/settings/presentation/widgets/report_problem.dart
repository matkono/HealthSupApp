// import 'package:flutter/material.dart';

// class ReportProblem extends StatefulWidget {
//   @override
//   _ReportProblemState createState() => _ReportProblemState();
// }

// class _ReportProblemState extends State<ReportProblem> {
//   String valueProblem = 'Bug';
//   List<String> listProblem = [
//     'Bug',
//     'Erro',
//     'Reclamação',
//     'Melhoria',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Column(
//         children: [
//           AppBar(
//             backgroundColor: Colors.grey[300],
//             iconTheme: IconThemeData(
//               color: Colors.black,
//             ),
//             title: Text(
//               'Relatar problema',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 30,
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(
//               top: 20,
//               left: 30,
//               bottom: 10,
//             ),
//             alignment: Alignment.centerLeft,
//             width: MediaQuery.of(context).size.width,
//             child: Text(
//               'INFORME O PROBLEMA',
//               style: TextStyle(
//                 fontSize: 20,
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.bottomLeft,
//             padding: EdgeInsets.only(left: 30),
//             height: MediaQuery.of(context).size.height / 25,
//             child: Text(
//               'Tipo',
//               style: TextStyle(
//                 fontSize: 17,
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 30, right: 30),
//             width: MediaQuery.of(context).size.width,
//             child: DropdownButton<String>(
//               value: valueProblem,
//               isExpanded: true,
//               icon: Icon(Icons.arrow_downward),
//               elevation: 16,
//               style: TextStyle(color: Colors.black, fontSize: 20),
//               onChanged: (String newValue) {
//                 setState(() {
//                   valueProblem = newValue;
//                 });
//               },
//               underline: Container(
//                 height: 0.5,
//                 color: Colors.black,
//               ),
//               items: listProblem.map<DropdownMenuItem<String>>((String valor) {
//                 return DropdownMenuItem<String>(
//                   value: valor,
//                   child: Text(valor),
//                 );
//               }).toList(),
//             ),
//           ),
//           Container(
//             alignment: Alignment.bottomLeft,
//             padding: EdgeInsets.only(top: 15, left: 30),
//             child: Text(
//               'Descrição',
//               style: TextStyle(
//                 fontSize: 17,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(20),
//             padding: EdgeInsets.only(
//               left: 15,
//               right: 15,
//             ),
//             height: MediaQuery.of(context).size.height / 5,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 1,
//               ),
//             ),
//             child: TextFormField(
//               maxLines: 7,
//               style: TextStyle(
//                 fontSize: 17,
//               ),
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(
//               left: 20,
//               right: 20,
//             ),
//             height: MediaQuery.of(context).size.height / 14,
//             width: MediaQuery.of(context).size.width,
//             child: FlatButton(
//               color: Colors.blue[600],
//               child: Text(
//                 'Enviar',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                 ),
//               ),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
