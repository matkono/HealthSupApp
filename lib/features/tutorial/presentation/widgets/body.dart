import 'package:healthsup/features/login/presentation/pages/login.dart';
import 'package:flutter/material.dart';

class BodyPage extends StatefulWidget {
  final List<Widget> widgetList;
  final int index;

  const BodyPage({
    Key key,
    @required this.widgetList,
    @required this.index,
  }) : super(key: key);

  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            if (widget.widgetList.isNotEmpty) widget.widgetList[widget.index],
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 15,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Anterior',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 15,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Próximo',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      setState(() {
                        print(widget.index);
                        if (widget.index < widget.widgetList.length - 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BodyPage(
                                      widgetList: widget.widgetList,
                                      index: (widget.index) + 1)));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
