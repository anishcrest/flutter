import 'package:common_components/utils/enum_utils.dart';
import 'package:common_components/utils/string_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TabBarComponent extends StatefulWidget {
  const TabBarComponent({Key? key}) : super(key: key);

  @override
  _TabBarComponentState createState() => _TabBarComponentState();
}

class _TabBarComponentState extends State<TabBarComponent>
    with TickerProviderStateMixin {
  late TabController tabController;
 // late VideoPlayerController videoController;
  late ScrollController scrollController;
  bool downDirection = true, downFlag = true;
  bool upDirection = true, upFlag = true, isSmallSize = false;

  Tween<Offset> tweenOffset = Tween<Offset>(
    begin: Offset(0, -1),
    end: Offset(0, 0),
  );

  late AnimationController animationController;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: TabBarViewEnum.values.length, vsync: this);

/*
    videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..setLooping(true);
*/

    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
          ..addListener(() => setState(() {}));
    scrollController = ScrollController()
      ..addListener(() {
        downDirection = scrollController.position.userScrollDirection ==
                ScrollDirection.forward &&
            scrollController.position.pixels == 0;
        upDirection = scrollController.position.userScrollDirection ==
                ScrollDirection.reverse &&
            isSmallSize;

        // makes sure we don't call setState too much, but only when it is needed
        if (downDirection != downFlag) setState(() {});

        if (upDirection != upFlag) setState(() {});

        downFlag = downDirection;
        upFlag = upDirection;

        if (downDirection) {
          setTweenAnimation(Tween<Offset>(
            begin: Offset(0, 0),
            end: Offset(0.56, 3),
          ));
          isVisible = false;
          isSmallSize = true;
        }

        if (upDirection) {
          setTweenAnimation(Tween<Offset>(
            begin: Offset(0.38, 0.8),
            end: Offset(0, 0),
          ));
          isVisible = true;
          scrollController.animateTo(0,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn);
          isSmallSize = false;
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    // videoController.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: tabController,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: ListTile(
                      tileColor: Theme.of(context).cardColor,
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      minVerticalPadding: 0,
                      dense: true,
                      leading: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.black54,
                          ),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 35,
                        ),
                      ),
                      title: Text(
                        'Item $index',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      subtitle: Text(
                        'Item sub Title $index',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      onTap: () {
                        setTweenAnimation(
                          Tween<Offset>(
                            begin: Offset(0, 1),
                            end: Offset(0, 0),
                          ),
                        );
                        //  videoController.play();
                        isVisible = true;
                        // isInitial = true;
                      },
                    ),
                  );
                },
              ),
              Center(
                child: Text(
                  'Tab bar Business Widget',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.green,
                      ),
                ),
              ),
              Center(
                child: Text(
                  'Tab bar School Widget',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.purple,
                      ),
                ),
              ),
              Center(
                child: Text(
                  'Tab bar Settings Widget',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.pink,
                      ),
                ),
              ),
            ],
          ),
          SlideTransition(
            //position: tweenOffset.animate(animationController),
            position: tweenOffset.animate(animationController),
            child: Container(
              width: isSmallSize ? 250 : null,
              height: isSmallSize ? 150 : null,
              color: Theme.of(context).cardColor,
              child: ListView(
                controller: scrollController,
                children: [
                  /* videoController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: VideoPlayer(videoController),
                        )
                      : Container(),*/
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 600),
                    opacity: isVisible ? 1 : 0,
                    child: isVisible
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
                            child: Text(
                              AppString.detail_video,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          )
                        : Container(),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 600),
                    opacity: isVisible ? 1 : 0,
                    child: isVisible
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              AppString.video_desc,
                            ),
                          )
                        : Container(
                            height: 20,
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: TabBar(
          isScrollable: true,
          controller: tabController,
          indicator: BoxDecoration(),
          labelColor: Colors.orange,
          labelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
          unselectedLabelColor: Colors.black38,
          unselectedLabelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
          onTap: (index) {
            tabController.index = index;
            setState(() {});
          },
          tabs: [
            Text(
              'Home',
              textAlign: TextAlign.center,
            ),
            Text(
              'Business',
              textAlign: TextAlign.center,
            ),
            Text(
              'School',
              textAlign: TextAlign.center,
            ),
            Text(
              'Settings',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  setTweenAnimation(Tween<Offset> tween) {
    tweenOffset = tween;

    if (animationController.isCompleted) {
      animationController.reset();
      animationController.forward();
    } else {
      animationController.forward();
    }
  }
}
