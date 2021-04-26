// import 'package:flutter/material.dart';

// class AlterDataAccount extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Column(
//         children: [
//           AppBar(
//             iconTheme: IconThemeData(
//               color: Colors.black,
//             ),
//             backgroundColor: Colors.grey[300],
//             title: Text(
//               'Conta',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 30,
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(20),
//             height: MediaQuery.of(context).size.height / 3.5,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 width: 1,
//               ),
//               borderRadius: BorderRadius.circular(2),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(left: 15, top: 20),
//                   margin: EdgeInsets.only(bottom: 10),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'ALTERAR DADOS CADASTRAIS',
//                     style: TextStyle(
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       width: 1,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(left: 10),
//                         child: Text(
//                           'Nome: ',
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width / 1.6,
//                         child: TextFormField(
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 10, left: 10, right: 10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       width: 1,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(left: 10),
//                         child: Text(
//                           'Telefone: ',
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width / 2,
//                         child: TextFormField(
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(20),
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
