import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('Aaron Burr', 'AB'),
    const ActorFilterEntry('Alexander Hamilton', 'AH'),
    const ActorFilterEntry('Eliza Hamilton', 'EH'),
    const ActorFilterEntry('James Madison', 'JM'),
  ];
  List<String> _filters = <String>[];

  double _value = 0;

  Iterable<Widget> get actorWidgets sync* {
    for (final ActorFilterEntry actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 8, 0),
        child: FilterChip(
          labelPadding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
          shape: StadiumBorder(side: BorderSide()),
          showCheckmark: false,
          backgroundColor: Colors.white,
          label: Text(actor.name),
          selected: _filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(actor.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          child: Container(
            padding: EdgeInsets.all(15),
            color: const Color(0xFFF3F3F3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '지역',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Wrap(
                  children: actorWidgets.toList(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          child: Container(
            height: 200,
            padding: EdgeInsets.all(15),
            color: const Color(0xFFF3F3F3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '지역',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                SliderTheme(
                  data: SliderThemeData(thumbColor: Colors.white),
                  child: Slider(
                    min: 0.0,
                    max: 50.0,
                    divisions: 5,
                    value: _value,
                    onChanged: (double value) {
                      setState(() {
                        _value = value;
                      }); 
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}
