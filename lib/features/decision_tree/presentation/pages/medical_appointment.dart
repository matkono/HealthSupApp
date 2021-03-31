import 'package:healthsup/features/decision_tree/domain/entities/medical_appointment.dart';
import 'package:healthsup/features/decision_tree/presentation/bloc/decision_tree_bloc.dart';
import 'package:healthsup/features/decision_tree/presentation/widgets/action_layout.dart';
import 'package:healthsup/features/decision_tree/presentation/widgets/checkbox_question.dart';
import 'package:healthsup/features/decision_tree/presentation/widgets/decision_layout.dart';
import 'package:healthsup/features/decision_tree/presentation/widgets/error_layout.dart';
import 'package:healthsup/features/decision_tree/presentation/widgets/radio_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalAppointmentPage extends StatefulWidget {
  final MedicalAppointment medicalAppointment;
  MedicalAppointmentPage({
    Key key,
    this.medicalAppointment,
  }) : super(key: key);

  @override
  _MedicalAppointmentPageState createState() => _MedicalAppointmentPageState();
}

class _MedicalAppointmentPageState extends State<MedicalAppointmentPage> {
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
              image: AssetImage('assets/images/prancheta2.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              BlocListener<DecisionTreeBloc, DecisionTreeState>(
                listener: (BuildContext context, state) {
                  if (state is ErrorDecisionTreeState) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                  if (state is AppointmentFinished) {
                    Navigator.pop(context);
                  }
                },
                child: BlocBuilder<DecisionTreeBloc, DecisionTreeState>(
                  builder: (BuildContext context, DecisionTreeState state) {
                    print('status: $state');
                    if (widget.medicalAppointment != null) {
                      return Container(
                        child: Center(
                          child: Text(widget
                              .medicalAppointment.currentNode.isInitial
                              .toString()),
                        ),
                      );
                    } else if (state is QuestionDecisionTreeState)
                      return (state.node.question.questionType.id == 1)
                          ? RadioQuestionLoaded(
                              node: state.node,
                              idAppointment: state.idAppointment,
                            )
                          : CheckBoxQuestion(
                              node: state.node,
                              idAppointment: state.idAppointment);
                    else if (state is DecisionDecisionTreeState)
                      return DecisionLayout(
                        node: state.node,
                        idAppointment: state.idAppointment,
                      );
                    else if (state is ActionDecisionTreeState)
                      return ActionLayout(
                        node: state.node,
                        idAppointment: state.idAppointment,
                      );
                    else if (state is LoadingDecisionTreeState)
                      return Center(
                        child: Text('Loading'),
                      );
                    else if (state is ErrorDecisionTreeState)
                      return ErrorLayout();
                    else
                      return Center(child: CircularProgressIndicator());
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
