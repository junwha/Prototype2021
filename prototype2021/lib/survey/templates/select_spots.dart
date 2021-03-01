import 'package:flutter/material.dart';

/* 선택할 여행지를 카드 그리드뷰 형식으로 나타내는 클래스.
   XD 2-10 페이지에 해당. */
class SelectSpots extends StatefulWidget {
  @override
  _SelectSpotsState createState() => _SelectSpotsState();
}

class _SelectSpotsState extends State<SelectSpots> {
  List<int> selectedCards = List(); // 선택된 카드의 index를 저장하는 리스트
  List<GridCards> _buildGridCards(BuildContext context) {
    List<GridCards> cards = List.generate(6, (index) {
      return GridCards(
        // preview: '../../assets/images/logo.jpg',
        title: '놀이공원',
        fatigue: '피로',
        population: '많음',
        index: index,
        isSelected: (bool value) {
          setState(() {
            value ? selectedCards.add(index) : selectedCards.remove(index);
            print("$index : $value");
            print(selectedCards.length);
          });
        },
      );
    });

    return (cards.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: GridView.count(
          crossAxisCount: 2,
          children: _buildGridCards(context),
        )),
      ],
    );
  }
}

/* 한 카드 */
class GridCards extends StatefulWidget {
  // final String preview;
  final String title;
  final String fatigue;
  final String population;
  final int index;
  final ValueChanged<bool> isSelected;

  const GridCards(
      {
      // this.preview,
      this.title,
      this.fatigue,
      this.population,
      this.index,
      this.isSelected});

  @override
  _GridCardsState createState() => _GridCardsState();
}

class _GridCardsState extends State<GridCards> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        color: isSelected ? Colors.blue[100] : Colors.white,
        child: InkWell(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
              widget.isSelected(isSelected);
            });
          },
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: SizedBox.expand(
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              left: 0,
                              child: Checkbox(value: isSelected)),

                          //FIXME: HACK: 임시방편으로 positioned

                          Positioned(
                            top: 90,
                            left: 55,
                            child: Container(
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/login_background.jpg'),
                        fit: BoxFit.fill,
                      )),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                alignment: Alignment.center,
                                child: Icon(Icons.people)),
                            Container(
                              alignment: Alignment.center,
                              child: Container(child: Text(widget.fatigue)),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                alignment: Alignment.center,
                                child: Icon(Icons.people)),
                            Container(
                              alignment: Alignment.center,
                              child: Container(child: Text(widget.population)),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
