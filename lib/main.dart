import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'main.g.dart';

void main() => runApp(new MyApp());

@FunctionalWidget(widgetType: FunctionalWidgetType.stateless)
Widget myApp() {
  return MaterialApp(
    home: Scaffold(
      body: App(),
    ),
  );
}

@hwidget
Widget app() {
  final caughtColor = useState(Colors.white);
  return Stack(
    children: <Widget>[
      DragBox(Offset(0.0, 0.0), 'Box one', Colors.red),
      DragBox(Offset(150.0, 0.0), 'Box two', Colors.cyan),
      DragBox(Offset(300.0, 15.0), 'Box three', Colors.amber),
      Positioned(
        left: 100.0,
        bottom: 0.0,
        child: DragTarget(
          onAccept: (Color color) {
            caughtColor.value = color;
          },
          builder: (context, accepted, rejected) {
            return Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                  color: accepted.isEmpty ? caughtColor.value : Colors.grey
                      .shade400
              ),
              child: Center(
                child: Text("Drag here"),
              ),
            );
          },
        ),
      ),
    ],
  );
}

@hwidget
Widget dragBox(Offset initPos, String label, Color itemColor) {
  final position = useState(initPos);
  return Positioned(
    left: position.value.dx,
    top: position.value.dy,
    child: Draggable(
      data: itemColor,
      child: Container(
        width: 100,
        height: 100,
        color: itemColor,
        child: Center(
          child: Text(
              label
          ),
        ),
      ),
      onDraggableCanceled: (velocity, offset) {
        position.value = offset;
      },
      feedback: Container(
        width: 120,
        height: 120,
        color: itemColor.withOpacity(0.5),
        child: Center(
          child: Text(label),
        ),
      ),
    ),
  );
}