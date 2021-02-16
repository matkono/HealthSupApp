import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthsup/features/disease/domain/entities/diseases.dart';
import 'package:healthsup/features/disease/presentation/bloc/disease_bloc.dart';

class DiseasesListHomePage extends StatefulWidget {
  final List<Diseases> diseasesList;
  final int totalRows;

  const DiseasesListHomePage({
    Key key,
    @required this.diseasesList,
    @required this.totalRows,
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
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.diseasesList.length + 1,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.diseasesList.length) {
            if (index != widget.totalRows) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text(''),
              );
            }
          }
          return Container(
            constraints: BoxConstraints.tightFor(height: 80),
            child: Text(widget.diseasesList[index].name),
          );
        },
      ),
    );
  }
}
