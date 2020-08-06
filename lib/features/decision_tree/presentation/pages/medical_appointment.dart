import 'package:HealthSup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:HealthSup/features/decision_tree/presentation/widgets/checkbox_question.dart';
import 'package:HealthSup/features/decision_tree/presentation/widgets/decision_layout.dart';
import 'package:HealthSup/features/decision_tree/presentation/widgets/error_layout.dart';
import 'package:HealthSup/features/decision_tree/presentation/widgets/radio_question.dart';
import 'package:HealthSup/features/decision_tree/presentation/widgets/start_decision_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalAppointment extends StatefulWidget {
  final String title;

  MedicalAppointment({Key key, this.title}) : super(key: key);

  @override
  _MedicalAppointmentState createState() => _MedicalAppointmentState();
}

class _MedicalAppointmentState extends State<MedicalAppointment> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/prancheta2.jpg'), fit: BoxFit.fill,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              BlocListener<DecisionTreeBloc, DecisionTreeState>(
                listener: (BuildContext context, state) {},
                child: BlocBuilder<DecisionTreeBloc, DecisionTreeState>(
                  builder: (BuildContext context, DecisionTreeState state) {
                    if (state is DecisionTreeInitial) return StartDecisionTree();
                    else if (state is LoadedDecisionTreeState)
                      return (state.node.nodeTypeCode == 300 &&
                              state.node.question.questionTypeCode == 100)
                          ? RadioQuestionLoaded(
                              node: state.node,
                            )
                          : (state.node.nodeTypeCode == 300 &&
                                  state.node.question.questionTypeCode == 101)
                              ? CheckBoxQuestion(node: state.node)
                              : DecisionLayout(node: state.node);
                    else if (state is ErrorDecisionTreeState) return ErrorLayout();
                    else return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
