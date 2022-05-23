import 'dart:math';

import 'package:common_components/animation/animation_store.dart';
import 'package:common_components/utils/enum_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AnimationsComponent extends StatefulWidget {

  final DrawerComponentEnum drawerComponentEnum;


  const AnimationsComponent({
    Key? key,
    required this.drawerComponentEnum,

  }) : super(key: key);

  @override
  _AnimationsComponentState createState() => _AnimationsComponentState();
}

class _AnimationsComponentState extends State<AnimationsComponent>
    with TickerProviderStateMixin {
  late AnimationStore animationStore;


  late final AnimationController _scaleController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );


  late final AnimationController _slideController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );


  bool ab = false;

  @override
  void initState() {
    super.initState();
    animationStore = AnimationStore();
  }

  @override
  void dispose() {
    super.dispose();
    _scaleController.dispose();
    _slideController.dispose();
  }

  Widget get _fadeIn {
    return AnimatedOpacity(
        opacity: 1,
        duration: Duration(milliseconds: 1000),
        child: ItemView(UniqueKey()));
  }

  Widget get _fadeOut {
    return AnimatedOpacity(
        opacity: 0,
        duration: Duration(milliseconds: 1000),
        child: ItemView(UniqueKey()));
  }

  Widget get _scaleIn {
    late final Animation<double> _animation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.fastOutSlowIn,
    );

    return Builder(
      builder: (_) {
        _scaleController.forward();

        return ScaleTransition(
          scale: _animation,
          child: ItemView(UniqueKey()),
        );
      },
    );
  }

  Widget get _scaleOut {
    late final Animation<double> _animation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.fastOutSlowIn,
    );

    return Builder(
      builder: (_) {
        _scaleController.reverse();

        return ScaleTransition(
          scale: _animation,
          child: ItemView(UniqueKey()),
        );
      },
    );
  }

  Widget get _slideUp {
    Animation<Offset> _slideUpAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -1),
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeIn,
      ),
    );

    return Builder(
        builder: (context) {
          _slideController.forward();
          _slideController.reset();
          if (_slideController.isCompleted) {
            _slideController.reset();
          } else {
            _slideController.forward();
          }
          return SlideTransition(
            position: _slideUpAnimation,
            child: ItemView(UniqueKey()),
          );
        }
    );
  }

  Widget get _slideDown {
    Animation<Offset> _slideUpAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 1),
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeIn,
      ),
    );

    return Builder(
        builder: (context) {
          _slideController.forward();
          _slideController.reset();
          if (_slideController.isCompleted) {
            _slideController.reset();
          } else {
            _slideController.forward();
          }
          return SlideTransition(
            position: _slideUpAnimation,
            child: ItemView(UniqueKey()),
          );
        }
    );
  }

  Widget get _slideLeft {
    Animation<Offset> _slideUpAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(1, 0),
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeIn,
      ),
    );

    return Builder(
        builder: (context) {
          _slideController.forward();
          _slideController.reset();
          if (_slideController.isCompleted) {
            _slideController.reset();
          } else {
            _slideController.forward();
          }
          return SlideTransition(
            position: _slideUpAnimation,
            child: ItemView(UniqueKey()),
          );
        }
    );
  }

  Widget get _slideRight {
    Animation<Offset> _slideUpAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(-1, 0),
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeIn,
      ),
    );

    return Builder(
        builder: (context) {
          _slideController.forward();
          _slideController.reset();
          if (_slideController.isCompleted) {
            _slideController.reset();
          } else {
            _slideController.forward();
          }
          return SlideTransition(
            position: _slideUpAnimation,
            child: ItemView(UniqueKey()),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Observer(builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  DropdownButton<AnimationEnum>(
                    value: animationStore.animationEnum,
                    onChanged: (val) {
                      animationStore.animationEnum = val;
                    },
                    isExpanded: true,
                    hint: Text('Select animation Type'),
                    items: AnimationEnum.values
                        .map(
                          (e) =>
                          DropdownMenuItem<AnimationEnum>(
                            child: Text(
                              EnumUtil.toStringEnum(e),
                            ),
                            value: e,
                          ),
                    )
                        .toList(),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  ToggleButton(),

                  SizedBox(
                    height: 30,
                  ),

                ],
              ),
            ),


            if(animationStore.animationEnum == AnimationEnum.fade_in)
              _fadeIn,

            if(animationStore.animationEnum == AnimationEnum.fade_out)
              _fadeOut,

            if(animationStore.animationEnum == AnimationEnum.size_in)
              _scaleIn,

            if(animationStore.animationEnum == AnimationEnum.size_out)
              _scaleOut,

            if(animationStore.animationEnum == AnimationEnum.slide_up)
              _slideUp,

            if(animationStore.animationEnum == AnimationEnum.slide_down)
              _slideDown,

            if(animationStore.animationEnum == AnimationEnum.slide_left)
              _slideRight,

            if(animationStore.animationEnum == AnimationEnum.slide_right)
              _slideLeft,


          ],
        );
      }),
    );
  }
}

class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

const double width = 300.0;
const double height = 60.0;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class _ToggleButtonState extends State<ToggleButton>
    with TickerProviderStateMixin {

  late double xAlign;
  late Color loginColor;
  late Color signInColor;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: Duration(milliseconds: 300),
            child: Container(
              width: width * 0.5,
              height: height,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onHorizontalDragStart: (DragStartDetails detail) {
              print('START+++++++++++++>${detail.globalPosition}');
            },
            onHorizontalDragUpdate: (DragUpdateDetails detail) {
              print('UPDATE DATA ----------------------->${detail.localPosition
                  .dx / 200}');

              if (detail.localPosition.dx / 200 < 0.5) {
                setState(() {
                  xAlign = detail.localPosition.dx / 200;
                });
              } else {
                setState(() {
                  xAlign = signInAlign;
                });
              }
            },
            onTap: () {
              setState(() {
                xAlign = loginAlign;
                loginColor = selectedColor;

                signInColor = normalColor;
              });
            },
            child: Align(
              alignment: Alignment(-1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: loginColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onHorizontalDragStart: (DragStartDetails detail) {},
            onHorizontalDragUpdate: (DragUpdateDetails detail) {
              if (detail.localPosition.dx / 200 < 1) {
                if (detail.localPosition.dx / 200 > 0.5) {
                  setState(() {
                    xAlign = detail.localPosition.dx / 200;
                  });
                } else {
                  setState(() {
                    xAlign = loginAlign;
                  });
                }
              }
            },
            onTap: () {
              setState(() {
                xAlign = signInAlign;
                signInColor = selectedColor;

                loginColor = normalColor;
              });
            },
            child: Align(
              alignment: Alignment(1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  'Signin',
                  style: TextStyle(
                    color: signInColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemView extends StatelessWidget {
  final Key key;

  ItemView(this.key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        key: key,
        height: 200,
        width: 200,
        color: Colors.green,
        margin: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
