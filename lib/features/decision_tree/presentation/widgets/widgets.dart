import 'package:cardiompp/features/decision_tree/domain/entities/answer.dart';
import 'package:cardiompp/features/decision_tree/domain/entities/possible_Answer.dart';
import 'package:flutter/material.dart';

class RadioAnswer extends StatefulWidget {
  final String title;

  RadioAnswer({Key key, this.title}) : super(key: key);

  @override
  _RadioAnswerState createState() => _RadioAnswerState();
}

class _RadioAnswerState extends State<RadioAnswer> {
  List<PossibleAnswer> possibleAnswer;
  int radioButton = 0;

  void initState() {
    super.initState();
  }

  Widget radioAnswer(BuildContext context, List<PossibleAnswer> possibleAnswers, Answer answer) {
    Map<String, int> finalAnswer =
    {
      "Value": possibleAnswers[1].id,
    };

    (answer.answers.isNotEmpty)
    ? print(answer.answers)
    : answer.answers.add(finalAnswer);

    return SizedBox(
      height: MediaQuery.of(context).size.height / 5,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
        return ListTile(
          title: Text(possibleAnswers[index].value),
          leading: Radio(
            value: index,
            groupValue: radioButton,
            onChanged: (value) {
              setState(() {
                radioButton = value;
                answer.answers[0]['Value'] = possibleAnswers[index].id;
                print(answer.answers[0]['Value']);
              });
            },
          ),
        );
      }),
    );
  }

  Widget multiAnswer(String answer, bool option) {

    return Center(
      child: ListTile(
        title: Text(answer),
        leading: Checkbox(
          value: option,
          onChanged: (bool value) {
            setState(() {
              option = value;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
