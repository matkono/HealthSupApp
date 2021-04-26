import 'package:flutter/material.dart';

class CardiomppLayout extends StatefulWidget {
  @override
  _CardiomppLayoutState createState() => _CardiomppLayoutState();
}

Widget _body(String text) {
  return Container(
    margin: EdgeInsets.only(left: 10, top: 20, right: 10),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      softWrap: true,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
    ),
  );
}

class _CardiomppLayoutState extends State<CardiomppLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'Cardiomiopatia Periparto',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.grey[300],
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                image: AssetImage('assets/images/HealthSup-logo-sem-nome.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '→ Tratamento',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 20, right: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '- O tratamento da cardiomiopatia periparto é baseado'
                        'no tratamento da IC com fração de ejeção reduzida.'
                        'No entanto, o tratamento difere nas fases antes e'
                        'depois do parto, pois alguns medicamentos são'
                        'contra-indicados durante a gestação.',
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '→ Antes do parto',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    _body(
                        '- Beta-bloqueadores: METOPROLOL (12,5-25mg até 200mg/dia - 1x/dia)'),
                    _body(
                        '- Diuréticos: HIDROCLOROTIAZIDA (12,5-25mg - 1x/dia), CLORTALIDONA (12,5-25mg - 1x/dia), INDAPAMIDA (2,5-5mg - 1x/dia) e FUROSEMIDA (20-80mg até 240mg - 4x/dia)'),
                    _body(
                        '- Vasodilatadores: HIDRALAZINA (25-50mg até 4x/dia)'),
                    _body(
                        '- Em caso de falha do tratamento, acrescentar DIGOXINA (0,125-0,25mg/dia - 1x/dia)'),
                    _body(
                        '*A administração de diuréticos e vasodilatadores deve ser realizada com cautela devido ao risco de hipotensão e hipoperfusão placentária. É necessária a monitorização fetal durante o tratamento.'),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '→ Pós-parto',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    _body(
                        'Após o parto, deve ser realizado o tratamento otimizado para a insuficiência cardíaca. No entanto, alguns medicamentos devem ser administrados com cautela durante a lactação.'),
                    _body(
                        '- Diuréticos tiazídicos: HIDROCLOROTIAZIDA (12,5-25mg - 1x/dia), CLORTALIDONA (12,5-25mg - 1x/dia), INDAPAMIDA (2,5-5mg - 1x/dia)'),
                    _body(
                        '- Beta-bloqueadores: METOPROLOL (12,5-25mg até 200mg/dia - 1x/dia)'),
                    _body(
                        '- Inibidores da Enzima Conversora de Angiotensina (IECA): CAPTOPRIL (6,25-50mg - 3x/dia) e ENALAPRIL (2,5-20mg - 2x/dia)'),
                    _body(
                        '- Bloqueadores AT1: LOSARTAN (25-50mg até 100mg/dia), CANDESARTAN (4-8mg até 32mg/dia - 1x/dia), VALSARTAN (20-40mg até 160mg/dia - 2x/dia) - devem ser usados em casos de intolerância aos IECA'),
                    _body(
                        '- Nitrato + Hidralazina: DINITRATO DE ISOSSORBIDA (20-30mg até 4x/dia) e HIDRALAZINA HIDRALAZINA (25-50mg até 4x/dia)'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
