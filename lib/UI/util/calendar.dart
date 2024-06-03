import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  final Function(List<DateTime?>) onCalendarChanged;

  const CalendarWidget({Key? key, required this.onCalendarChanged})
      : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime.now(), //Giorno evidenziato quando apri il calendario
  ];
  List<DateTime?> _multiDatePickerValueWithDefaultValue = [];

  @override
  Widget build(BuildContext context) {
    return _buildCalendarDialogButton();
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  Widget _buildCalendarDialogButton() {
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    const weekendTextStyle = TextStyle(
        color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w600);
    const anniversaryTextStyle = TextStyle(
      color: Color.fromARGB(255, 13, 22, 208),
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: const Color.fromRGBO(2, 67, 69, 1),
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2021))) {
          //giorno dell'anniversario(non toccato)
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 27.5),
                    child: SizedBox(
                      height: 4,
                      width: 4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required year,
        decoration,
        isCurrentYear,
        isDisabled,
        isSelected,
        textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),

                    /* TESTO RIMOSSO, MA ARCHIVIATO :Serve per aggiungere
                    un pallino rosso o del colore che viene selezionato accanto 
                    all'anno. In questo caso sarà un rettangolo per il
                    campo BoxShape.rectangle al posto di BoxShape.circle (unici 2 campi).
                    Codice UTILISSIMO per quando dovranno esser messi gli esami nel calendario!!!

                     if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color.fromARGB(255, 147, 151,
                              186), //colore pallino calendario anno attuale
                        ),
                      ),
 */
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
//Ho isolato il bottone, perchè tutto quello che c'è sopra è la configurazione del calendario
//mentre questa sezione qui sotto si occupa solamente del bottone

          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/calendar.png'),
                  fit: BoxFit.contain),
            ),
            child: GestureDetector(
              onTap: () async {
                final values = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: config,
                  dialogSize: const Size(325, 400),
                  borderRadius: BorderRadius.circular(15),
                  value: _dialogCalendarPickerValue,
                  //colore sfondo calendario
                  dialogBackgroundColor:
                      const Color.fromARGB(255, 255, 231, 174),
                );
                if (values != null) {
                  // ignore: avoid_print
                  print(_getValueText(
                    config.calendarType,
                    values,
                  ));
                  setState(() {
                    _dialogCalendarPickerValue = values;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultMultiDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: Colors.indigo,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text('Multi Date Picker (With default value)'),
        CalendarDatePicker2(
          config: config,
          value: _multiDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _multiDatePickerValueWithDefaultValue = dates),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: [
            const Text('Selection(s):  '),
            const SizedBox(width: 10),
            Text(
              _getValueText(
                config.calendarType,
                _multiDatePickerValueWithDefaultValue,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
