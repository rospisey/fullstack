part of pisey_ui_kits;

class MyFlatButtonWithIcon extends StatelessWidget {
  final void Function()? onPressed;

  const MyFlatButtonWithIcon({Key? key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.all(15),
      width: double.infinity,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blue, width: 0.3)),
      child: TextButton.icon(
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          label: Text(
            'Save Data',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          onPressed: onPressed),
    );
  }
}

class BouncingButton extends StatefulWidget {
  final Widget? child;

  const BouncingButton({Key? key, this.child}) : super(key: key);
  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.01,
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
      child: Transform.scale(scale: _scale!, child: widget.child),
    );
  }
}

class SplashButton extends StatefulWidget {
  final Widget? child;

  const SplashButton({Key? key, this.child}) : super(key: key);
  @override
  _SplashButtonState createState() => _SplashButtonState();
}

class _SplashButtonState extends State<SplashButton>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;
  bool enable = false;

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
    super.dispose();
    _controller!.dispose();
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
        child: GestureDetector(
            onTap: () {
              print('click');
            },
            child: widget.child),
      ),
    );
  }
}

class SplashAndBounceButton extends StatefulWidget {
  final Widget? child;

  const SplashAndBounceButton({Key? key, this.child}) : super(key: key);
  @override
  _SplashAndBounceButtonState createState() => _SplashAndBounceButtonState();
}

class _SplashAndBounceButtonState extends State<SplashAndBounceButton>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;
  bool enable = false;

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
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        setState(() {
          enable = true;
          _controller!.forward();
        });
      },
      onPointerUp: (PointerUpEvent event) {
        setState(() {
          enable = false;
          _controller!.reverse();
        });
      },
      child: Transform.scale(
        scale: _scale!,
        child: GestureDetector(
            onTap: () {
              print('click');
            },
            child: widget.child),
      ),
    );
  }
}
