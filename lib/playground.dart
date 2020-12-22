import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:play_with_me/fire_obect.dart';

import 'fighter_object.dart';
import 'widgets/rounded_card.dart';

class PlayGround extends HookWidget {
  Timer timer;
  ValueNotifier<Color> _selectedColor;

  Animation<double> _fireAnimation;

  Animation<double> _startAnimation;
  Animation<double> _scaleAnimation;

  ValueNotifier<double> _size;

  @override
  Widget build(BuildContext context) {
    _size = useState(1.0);
    final double maxDyLimit = MediaQuery.of(context).size.height - 200;
    final double maxDxLimit =
        MediaQuery.of(context).size.width - (_size.value * 70);
    final _dx = useState(MediaQuery.of(context).size.width * 0.4);
    final _dy = useState(MediaQuery.of(context).size.height * 0.4);

    final rotationController = useAnimationController(
        duration: Duration(
      milliseconds: 500,
    ));

    final fireAnimationController = useAnimationController(
      duration: Duration(
        milliseconds: 500,
      ),
    );

    final startAnimationController = useAnimationController(
      duration: Duration(
        seconds: 1,
      ),
    );

    final scaleController = useAnimationController(
        duration: Duration(
      milliseconds: 500,
    ));

    _fireAnimation =
        Tween<double>(begin: 0.0, end: -500).animate(fireAnimationController);

    _startAnimation = Tween<double>(begin: 0.0, end: -500).animate(
        CurvedAnimation(
            curve: Curves.bounceInOut, parent: startAnimationController));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: _size.value).animate(scaleController);

    _selectedColor = useState(Colors.transparent);

    final backgroundAnimation = useState("stopped");

    Widget _leftControls() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            child: GestureDetector(
              onTap: () {
                rotationController.forward(from: 0);
              },
              child: Icon(
                Icons.rotate_left_sharp,
              ),
            ),
          ),
          Row(children: [
            CircleAvatar(
              radius: 20,
              child: GestureDetector(
                onTap: () {
                  fireAnimationController.forward().then((value) {
                    fireAnimationController.reset();
                  });
                },
                child: Icon(
                  Icons.fireplace_rounded,
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            CircleAvatar(
              radius: 20,
              child: GestureDetector(
                onTap: () async {
                  Color color = await _openDialog(context);

                  if (color != null) {
                    _selectedColor.value = color;
                  }
                },
                child: Icon(
                  Icons.settings,
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: GestureDetector(
                  onTap: () {
                    _size.value = 1.5;

                    scaleController.forward();
                  },
                  child: Icon(
                    Icons.zoom_in,
                  ),
                ),
              ),
              SizedBox(width: 30),
              CircleAvatar(
                radius: 20,
                child: GestureDetector(
                  onTap: () {
                    _size.value = 1.0;
                    scaleController.forward();
                  },
                  child: Icon(
                    Icons.zoom_out,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget _rightControls() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            child: GestureDetector(
              onScaleStart: (d) {
                timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
                  if (_dy.value > kToolbarHeight) {
                    _dy.value -= 1;
                  }
                });
              },
              onScaleEnd: (d) {
                if (timer != null) {
                  timer.cancel();
                }
              },
              child: Icon(
                Icons.arrow_upward,
              ),
            ),
          ),
          Row(children: [
            CircleAvatar(
              radius: 20,
              child: GestureDetector(
                onScaleStart: (d) {
                  timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
                    if (_dx.value > 0) {
                      _dx.value -= 1;
                    }
                  });
                },
                onScaleEnd: (d) {
                  if (timer != null) {
                    timer.cancel();
                  }
                },
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            CircleAvatar(
              radius: 20,
              child: GestureDetector(
                onScaleStart: (d) {
                  timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
                    if (_dx.value < maxDxLimit) {
                      _dx.value += 1;
                    }
                  });
                },
                onScaleEnd: (d) {
                  if (timer != null) {
                    timer.cancel();
                  }
                },
                child: Icon(
                  Icons.arrow_forward,
                ),
              ),
            ),
          ]),
          CircleAvatar(
            radius: 20,
            child: GestureDetector(
              onScaleStart: (d) {
                timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
                  if (_dy.value < maxDyLimit) {
                    _dy.value += 1;
                  }
                });
              },
              onScaleEnd: (d) {
                if (timer != null) {
                  timer.cancel();
                }
              },
              child: Icon(
                Icons.arrow_downward,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          FlareActor("assets/home.flr",
              alignment: Alignment.center,
              fit: BoxFit.cover,
              animation: backgroundAnimation.value),
          Positioned(
            top: _dy.value + 25,
            left: _dx.value,
            child: AnimatedBuilder(
              animation: _fireAnimation,
              builder: (c, child) => Transform.translate(
                offset: Offset(25, _fireAnimation.value),
                child: CustomPaint(
                  size: Size(20, 20),
                  painter: FireObject(),
                ),
              ),
            ),
          ),
          Positioned(
            top: _dy.value,
            left: _dx.value,
            child: GestureDetector(
              onPanStart: (details) {
                _dx.value = details.globalPosition.dx.clamp(0, maxDxLimit);

                _dy.value = details.globalPosition.dy.clamp(0, maxDyLimit);
              },
              onPanUpdate: (details) {
                _dx.value = details.globalPosition.dx.clamp(0, maxDxLimit);
                _dy.value = details.globalPosition.dy.clamp(0, maxDyLimit);
              },
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: CustomPaint(
                    size: Size(70, 70),
                    painter: Fighter(skinColor: _selectedColor.value),
                  ),
                ),
              ),
            ),
          ),
          Positioned(right: 16, bottom: 16, child: _leftControls()),
          Positioned(left: 16, bottom: 16, child: _rightControls()),
          Container(
            color: backgroundAnimation.value == "stopped"
                ? Colors.black.withOpacity(0.5)
                : null,
            child: Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _startAnimation,
                builder: (c, child) => Transform.translate(
                  offset: Offset(_startAnimation.value, 0.0),
                  child: RoundedCardTapable(
                    cardColor: Colors.blue,
                    onTap: () {
                      startAnimationController.forward().then((value) {
                        backgroundAnimation.value = "day_night";
                      });
                    },
                    content: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: Text(
                        "Start",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Color> _openDialog(context) async {
    Color _tempSelection;
    return await showDialog<Color>(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text("Change Fighter Skin"),
          content: MaterialColorPicker(
              selectedColor: _selectedColor.value,
              allowShades: false,
              onMainColorChange: (color) => _tempSelection = color),
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            RaisedButton(
              padding: EdgeInsets.all(16),
              color: Colors.blue,
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop(_tempSelection);
              },
            ),
          ],
        );
      },
    );
  }
}
