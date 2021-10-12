import 'package:flutter/material.dart';

class CustomPage extends StatefulWidget {
  /// Title of the AppBar.
  final String title;

  /// Bottom of the AppBar.
  final Widget bottom;

  /// Body of the page.
  final Widget child;

  const CustomPage({
    Key? key,
    required this.title,
    required this.bottom,
    required this.child,
  }) : super(key: key);

  @override
  _CustomPageState createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  /// Scroll controller of the page.
  final _controller = ScrollController();

  /// Min height of the AppBar (including bottom AppBar).
  final _minHeight = kToolbarHeight * 2;

  /// Max height of the AppBar (including bottom AppBar).
  final _maxHeight = kToolbarHeight * 3;

  double _expandRatio = 1.0;

  /// Snap the Appbar when the [_controller] stopped in the middle of its way.
  void _snapAppbar() {
    final scrollDistance = _maxHeight - _minHeight + 1;
    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final snapOffset =
          _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0.0;
      Future.microtask(
        () => _controller.animateTo(
          snapOffset,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        ),
      );
    }
  }

  /// Calculate the ratio of the scroll effectuated.
  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - _minHeight) / (_maxHeight - _minHeight);
    if (expandRatio > 1.0) {
      expandRatio = 1.0;
    } else if (expandRatio < 0.0) {
      expandRatio = 0.0;
    }
    return expandRatio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (_) {
            _snapAppbar();
            return false;
          },
          child: CustomScrollView(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                stretch: true,
                pinned: true,
                collapsedHeight: _minHeight,
                expandedHeight: _maxHeight,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                flexibleSpace: LayoutBuilder(
                  builder: (_, constraints) {
                    _expandRatio = _calculateExpandRatio(constraints);
                    final animation = AlwaysStoppedAnimation(_expandRatio);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentTween(
                              begin: Alignment.topCenter,
                              end: Alignment.centerLeft,
                            ).evaluate(animation),
                            child: SizedBox(
                              height: _minHeight / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          Tween<double>(begin: 18, end: 30)
                                              .evaluate(animation),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Card(
                              margin: EdgeInsets.zero,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              elevation: 0,
                              child: widget.bottom,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
