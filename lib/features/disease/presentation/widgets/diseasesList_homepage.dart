import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/disease/presentation/bloc/disease_bloc.dart';

class DiseasesListHomePage extends StatefulWidget {
  const DiseasesListHomePage({
    Key key,
  }) : super(key: key);

  @override
  _DiseasesListHomePageState createState() => _DiseasesListHomePageState();
}

class _DiseasesListHomePageState extends State<DiseasesListHomePage> {
  ScrollController _scrollController = new ScrollController();

  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchTen();
      }
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void fetchTen() {
    BlocProvider.of<DiseaseBloc>(context).add(GetNextDiseaseListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'Doenças',
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
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                child: ListView.builder(
                  itemCount: 50,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Text('Center'),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
