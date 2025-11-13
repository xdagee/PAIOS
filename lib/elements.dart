import 'package:flutter/material.dart';


class Cards {
  double cardMarginV = 2;
  double cardMarginH = 15;
  Radius cardROuter = const Radius.circular(20);
  Radius cardRInner = const Radius.circular(5);
  Map<String,double> cardMargins = {"h":15, "v":2};
  late BuildContext context;

  Cards._internal(this.context);
  factory Cards({required BuildContext context}){
    return Cards._internal(context);
  }

  Widget cardGroup(List<Widget> cards) {
    double width = (WidgetsBinding.instance.platformDispatcher.views.first.physicalSize / WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio).width;
    double height = (WidgetsBinding.instance.platformDispatcher.views.first.physicalSize / WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio).height;
    switch(cards.length){
      case 0: return Container();
      case 1: return Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(cardROuter),
        ),
        color: Theme.of(context).colorScheme.onPrimaryFixed,
        margin: EdgeInsets.symmetric(
            horizontal: cardMarginH,
            vertical: cardMarginV
        ),
        child: Container(
          width: width - (cardMarginH * 2),
          child: cards[0],
        ),
      );
      case 2: return Column(
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: cardRInner,
                  topRight: cardROuter,
                  topLeft: cardROuter,
                  bottomLeft: cardRInner
              ),
            ),
            color: Theme.of(context).colorScheme.onPrimaryFixed,
            margin: EdgeInsets.symmetric(
                horizontal: cardMarginH,
                vertical: cardMarginV
            ),
            child: cards[0],
          ),
          Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: cardROuter,
                  topRight: cardRInner,
                  topLeft: cardRInner,
                  bottomLeft: cardROuter
              ),
            ),
            color: Theme.of(context).colorScheme.onPrimaryFixed,
            margin: EdgeInsets.symmetric(
                horizontal: cardMarginH,
                vertical: cardMarginV
            ),
            child: cards[1],
          ),
        ],
      );
      default:
        List<Widget> cardsOut = [];
        cardsOut.add(
            Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: cardRInner,
                    topRight: cardROuter,
                    topLeft: cardROuter,
                    bottomLeft: cardRInner
                ),
              ),
              color: Theme.of(context).colorScheme.onPrimaryFixed,
              margin: EdgeInsets.symmetric(
                  horizontal: cardMarginH,
                  vertical: cardMarginV
              ),
              child: cards[0],
            )
        );
        for(int i = 1; i<cards.length - 1; i++){
          cardsOut.add(
              Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: cardRInner,
                      topRight: cardRInner,
                      topLeft: cardRInner,
                      bottomLeft: cardRInner
                  ),
                ),
                color: Theme.of(context).colorScheme.onPrimaryFixed,
                margin: EdgeInsets.symmetric(
                    horizontal: cardMarginH,
                    vertical: cardMarginV
                ),
                child: cards[i],
              )
          );
        }
        cardsOut.add(
            Card(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: cardROuter,
                    topRight: cardRInner,
                    topLeft: cardRInner,
                    bottomLeft: cardROuter

                ),
              ),
              color: Theme.of(context).colorScheme.onPrimaryFixed,
              margin: EdgeInsets.symmetric(
                  horizontal: cardMarginH,
                  vertical: cardMarginV
              ),
              child: cards[cards.length - 1],
            )
        );
        return Column(children: cardsOut);
    }
  }
}

class cardContents {
  static Widget tap({
    required String title,
    required String subtitle,
    required VoidCallback action,
  }) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 10
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: subtitle == ""?10:0,),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle == ""?Container(height: 10,):
                Text(
                  subtitle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  static Widget static({
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20, vertical: 10
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: subtitle == ""?10:0,),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle == ""?Container(height: 10,):
          Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  static Widget doubleTap({
    required String title,
    required String subtitle,
    required VoidCallback action,
    required VoidCallback secondAction,
    required IconData icon
  }) {
    double width = (WidgetsBinding.instance.platformDispatcher.views.first.physicalSize / WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio).width;
    double height = (WidgetsBinding.instance.platformDispatcher.views.first.physicalSize / WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio).height;

    return InkWell(
      onTap: action,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 10
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: subtitle == ""?10:0,),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: 100,
                      maxWidth: width - 140
                  ),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                subtitle == ""?Container(height: 10,):
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: 100,
                      maxWidth: width - 140
                  ),
                  child: Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  VerticalDivider(thickness: 3,radius: BorderRadius.all(Radius.circular(15)),),
                  IconButton(
                    icon: Icon(
                      icon,
                      size: 32,
                    ),
                    onPressed: secondAction,
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
  static Widget longTap({
    required String title,
    required String subtitle,
    required VoidCallback action,
    required VoidCallback longAction,
  }) {
    return InkWell(
      onTap: action,
      onLongPress: longAction,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 10
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: subtitle == ""?10:0,),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle == ""?Container(height: 10,):
                Text(
                  subtitle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  static Widget turn({
    required String title,
    required String subtitle,
    required VoidCallback action,
    required ValueChanged<bool> switcher,
    required bool value
  }) {
    return InkWell(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: 15,
            left: 20
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  subtitle,
                ),
              ],
            ),
            Switch(
              value: value, onChanged: switcher,
            ),
          ],
        ),
      ),
    );
  }
  static Widget addretract({
    required String title,
    required String subtitle,
    required VoidCallback actionAdd,
    required VoidCallback actionRetract,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          right: 15,
          left: 20
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                subtitle,
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_rounded),
                onPressed: actionRetract,
              ),
              IconButton(
                icon: const Icon(Icons.add_rounded),
                onPressed: actionAdd,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
