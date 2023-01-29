import 'package:flutter/material.dart';
import 'package:golearnv2/databases/database_manager.dart';
import 'package:golearnv2/pages/flashcards_page.dart';
import 'package:golearnv2/pages/home_page.dart';
import 'package:golearnv2/notifiers/flashcards_notifier.dart';
import 'package:golearnv2/utils/methods.dart';
import 'package:provider/provider.dart';

class ResultsBox extends StatefulWidget {
  const ResultsBox({super.key});

  @override
  State<ResultsBox> createState() => _ResultsBoxState();
}

//THIS IS THE CODE FOR THE RESULT OF THE TEST

class _ResultsBoxState extends State<ResultsBox> {
  bool _haveSavedCards = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FittedBox(
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            title: Text(
                notifier.isSessionCompleted
                    ? 'Congratulations! \nSession Completed!'
                    : 'Congratulations! \nRound Completed!',
                textAlign: TextAlign.center),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1),
                  },
                  children: [
                    buildTableRow(
                        title: 'Good Job! You got:',
                        stat: notifier.correctTally.toString()),
                    buildTableRow(
                        title: 'The total cards:',
                        stat: notifier.cardTally.toString()),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      notifier.isSessionCompleted
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FlashcardsPage(),
                                  ),
                                );
                              },
                              child: const Text('Retest Incorrect Cards')),
                      notifier.isSessionCompleted
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: _haveSavedCards
                                  ? null
                                  : () async {
                                      for (int i = 0;
                                          i < notifier.incorrectCards.length;
                                          i++) {
                                        await DatabaseManager().insertWord(
                                            word: notifier.incorrectCards[i]);
                                      }

                                      _haveSavedCards = true;
                                      runQuickBox(
                                          context: context,
                                          text: 'Incorrect Cards Saved!');
                                      Future.delayed(
                                          const Duration(milliseconds: 1000),
                                          () {
                                        if (!mounted) return;
                                        Navigator.maybePop(context);
                                      });
                                      setState(() {});
                                    },
                              child: const Text('Save Incorrect Cards')),
                      ElevatedButton(
                        onPressed: () {
                          notifier.reset();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false);
                        },
                        child: const Text('Home'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TableRow buildTableRow({required String title, required String stat}) {
    return TableRow(children: [
      Center(
          child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: TableCell(
          child: Text(
            title,
            textAlign: TextAlign.right,
          ),
        ),
      )),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TableCell(
            child: Text(
              stat,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    ]);
  }
}
