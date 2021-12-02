import 'package:digital_park/components/buttons/background_button.dart';
import 'package:digital_park/models/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({
    Key? key,
    required this.userProfile,
  }) : super(key: key);
  final UserProfile userProfile;

  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  double sliderValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          const Card(
            child: ListTile(
              title: Text('Caminhada'),
              subtitle: Text('Caminhar em redor da lagoa'),
            ),
          ),
          const Card(
            child: ListTile(
              title: Text('Trilha'),
              subtitle: Text('Fazer uma trilha'),
            ),
          ),
        ],
      ),
    );
  }
}
