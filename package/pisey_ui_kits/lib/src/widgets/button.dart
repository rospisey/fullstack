part of pisey_ui_kits;

class PsButtonOutlineWithIcon extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? text;
  final Widget? icon;

  const PsButtonOutlineWithIcon(
      {Key? key, @required this.onPressed, this.text, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.all(15),
      width: double.infinity,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blue, width: 0.3)),
      child: TextButton.icon(
          icon: icon ??
              Icon(
                Icons.save,
                color: psColorBlackToWhite(context),
              ),
          label: text ??
              Text(
                'Outline Icon Text',
                style: myDefaultTextStylePtSans(context),
              ),
          onPressed: onPressed),
    );
  }
}

class PsButtonBouncing extends StatefulWidget {
  final Widget? child;
  final double? upperBound;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final Color? splashColor;
  final double? borderRadius;

  const PsButtonBouncing(
      {Key? key,
      @required this.child,
      this.upperBound: 0.02,
      @required this.onTap,
      this.margin,
      this.splashColor,
      this.borderRadius})
      : super(key: key);
  @override
  _PsButtonBouncingState createState() => _PsButtonBouncingState();
}

class _PsButtonBouncingState extends State<PsButtonBouncing>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;
  bool onhover = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: widget.upperBound!,
    );
    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _controller!.forward();
      },
      onPointerUp: (PointerUpEvent event) {
        _controller!.reverse();
      },
      child: Transform.scale(
          scale: _scale!,
          child: Container(
            margin: widget.margin ??
                EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
            child: InkWell(
                onHover: (hover) {
                  onhover = hover;
                  setState(() {});
                },
                onTap: widget.onTap ?? () => print('tap'),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Stack(children: <Widget>[
                  widget.child!,
                  if (onhover)
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius ?? 0),
                            color: onhover
                                ? (widget.splashColor ??
                                    Colors.black.withOpacity(0.1))
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                ])),
          )),
    );
  }
}

class PsButtonSplahBouncing extends StatefulWidget {
  final Widget? child;
  final double? upperBound;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final Color? splashColor;
  final double? borderRadius;

  const PsButtonSplahBouncing(
      {Key? key,
      @required this.child,
      this.upperBound: 0.02,
      @required this.onTap,
      this.margin,
      this.splashColor,
      this.borderRadius})
      : super(key: key);
  @override
  _PsButtonSplahBouncingState createState() => _PsButtonSplahBouncingState();
}

class _PsButtonSplahBouncingState extends State<PsButtonSplahBouncing>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;
  bool onhover = false;
  bool enable = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: widget.upperBound!,
    );
    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _controller!.forward();
        setState(() {
          enable = true;
        });
      },
      onPointerUp: (PointerUpEvent event) {
        _controller!.reverse();
        setState(() {
          enable = false;
        });
      },
      child: Transform.scale(
          scale: _scale!,
          child: Container(
            margin: widget.margin ??
                EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
            child: InkWell(
                onHover: (hover) {
                  onhover = hover;
                  setState(() {});
                },
                onTap: widget.onTap ?? () => print('tap'),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Stack(children: <Widget>[
                  widget.child!,
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius ?? 0),
                        color: enable
                            ? (widget.splashColor ??
                                Colors.black.withOpacity(0.2))
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  if (onhover)
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(widget.borderRadius ?? 0),
                            color: onhover
                                ? (widget.splashColor ??
                                    Colors.black.withOpacity(0.1))
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                ])),
          )),
    );
  }
}

class PsButtonSplash extends StatefulWidget {
  final Widget? child;
  final Color? splashColor;
  final Color? hoverColor;
  final void Function()? onTap;
  final Widget? center;
  final Widget? centerBottom;
  final Widget? topRight;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final bool Function()? selectedWidget;

  PsButtonSplash(
      {Key? key,
      @required this.child,
      this.splashColor,
      @required this.onTap,
      this.center,
      this.borderRadius,
      this.centerBottom,
      this.topRight,
      this.margin,
      this.hoverColor,
      this.selectedWidget})
      : super(key: key);
  @override
  _PsButtonSplashState createState() => _PsButtonSplashState();
}

class _PsButtonSplashState extends State<PsButtonSplash>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;
  bool enable = false;
  bool onhover = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.02,
    );
    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          enable = true;
        });
      },
      onPointerUp: (PointerUpEvent event) {
        setState(() {
          enable = false;
        });
      },
      child: Transform.scale(
        scale: _scale!,
        child: Container(
          margin: widget.margin ??
              EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          child: InkWell(
            onTap: widget.onTap ?? () => print('tap'),
            onHover: (hover) {
              onhover = hover;
              setState(() {});
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                widget.child!,
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 0),
                      color: enable
                          ? (widget.splashColor ??
                              Colors.black.withOpacity(0.2))
                          : Colors.transparent,
                    ),
                  ),
                ),
                if (widget.selectedWidget != null)
                  if (widget.selectedWidget!())
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 5,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                        ),
                      ),
                    )),
                if (onhover)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius ?? 0),
                          color: onhover
                              ? (widget.hoverColor ??
                                  Colors.black.withOpacity(0.1))
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                if (widget.center != null)
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: enable
                        ? Icon(Icons.play_circle_outline,
                            size: 36, color: widget.splashColor ?? Colors.white)
                        : Container(),
                  )),
                if (widget.centerBottom != null)
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: enable ? widget.centerBottom : Container())),
                if (widget.topRight != null)
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.topRight,
                          child: enable ? widget.topRight : Container())),
                // Container(
                //   margin: widget.margin,
                //   child: Material(
                //     color: enable
                //         ? (widget.splashColor ?? Colors.black.withOpacity(0.4))
                //         : Colors.transparent,
                //     borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                //     child: GestureDetector(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: <Widget>[
                //           Material(
                //               color: Colors.transparent,
                //               child: Container(
                //                 width: widget.width ??
                //                     MediaQuery.of(context).size.width * 0.9,
                //                 height: widget.height,
                //                 child: enable
                //                     ? widget.whenSplashWidget
                //                     // Align(
                //                     //     alignment: Alignment.topRight,
                //                     //     child: Padding(
                //                     //       padding: const EdgeInsets.all(8.0),
                //                     //       child: CircleAvatar(
                //                     //         child: Icon(EvaIcons.playCircleOutline),
                //                     //       ),
                //                     //     ),
                //                     //   )
                //                     : Text(''),
                //               ))
                //         ],
                //       ),

                //       onTap: widget.onTap,
                //       // borderRadius: BorderRadius.circular(15.0),
                //     ),
                //   ),
                // ),
                // enable
                //     ? Positioned(
                //         top: 30, left: 10, child: widget.topLeft ?? Text(''))
                //     : Text(''),
                // enable
                //     ? Positioned(
                //         top: 30, right: 10, child: widget.topRight ?? Text(''))
                //     : Text(''),
                // enable
                //     ? Positioned(
                //         bottom: 30,
                //         right: 10,
                //         child: widget.bottomRight ?? Text(''))
                //     : Text(''),
                // enable
                //     ? Positioned(
                //         bottom: 30, left: 10, child: widget.bottomLeft ?? Text(''))
                //     : Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
