import 'package:digital_park/components/buttons/background_button.dart';
import 'package:digital_park/components/default_scaffold_app.dart';
import 'package:digital_park/components/inputs/label_box.dart';
import 'package:digital_park/components/inputs/text_input.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:digital_park/screens/seggestions/sugestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SuggestionHome extends StatefulWidget {
  const SuggestionHome({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  State<SuggestionHome> createState() => _SuggestionHomeState();
}

class _SuggestionHomeState extends State<SuggestionHome> {
  double sliderValue = 50.0;
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return DefaultScaffoldApp(
      userProfile: widget.userProfile,
      body: PageView(
        controller: controller,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sugestões',
                        style: TextStyle(fontSize: 36),
                      ),
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (constxt) => AlertDialog(
                            title: const Text('Bem vindo as Sugestões!'),
                            content: SizedBox(
                              height: 150,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text('Feito para você!'),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                      'Aqui iremos analisar algumas situações e sugerir um roteiro.'),
                                  Text(
                                      'Um roteiro com melhores atividades que você pode fazer no período que estiver no parque'),
                                ],
                              ),
                            ),
                            actions: [
                              BackgroundButton(
                                label: 'Tope, vamos nessa!',
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        ),
                        child: const Icon(Icons.help),
                      ),
                    ],
                  ),
                ),
                Slider(
                  thumbColor: Theme.of(context).primaryColor,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                  value: sliderValue,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: 'Arraste',
                  onChanged: (double value) {
                    setState(() {
                      sliderValue = value;
                    });
                  },
                ),
                Wrap(
                  children: [
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.5,
                      child: Text(
                        'Esporte',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    FractionallySizedBox(
                      alignment: Alignment.centerRight,
                      widthFactor: 0.5,
                      child: Text(
                        'Lazer',
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Text('Tempo livre para atividades'),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: TextInput(
                        controller: TextEditingController(),
                        label: 'Horas',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: TextInput(
                        controller: TextEditingController(),
                        label: 'Minutos',
                      ),
                    )
                  ],
                ),
                LabelBox(
                  function: () {},
                  label: 'Programar alimentação?',
                ),
                LabelBox(
                  function: () {},
                  label: 'Sugerir com gastos?',
                ),
                BackgroundButton(
                  label: 'Sugerir',
                  onPressed: () {
                    controller.jumpToPage(1);
                  },
                ),
              ],
            ),
          ),
          Suggestion(userProfile: widget.userProfile),
        ],
      ),
    );
  }
}
