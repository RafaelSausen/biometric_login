import 'package:biometric_login/shared/components/rsb_snack_bar.dart';
import 'package:biometric_login/shared/constants/theme.dart';
import 'package:flutter/material.dart';

class RSBButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? iconStart;
  final IconData? iconEnd;
  final Image? image;
  final EdgeInsets paddingButton;

  const RSBButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.iconStart,
    this.iconEnd,
    this.image,
    this.paddingButton = const EdgeInsets.all(20.0),
  }) : super(
          key: key,
        );

  @override
  State<RSBButton> createState() => _RSBButtonState();
}

class _RSBButtonState extends State<RSBButton> {
  bool loading = false;

  Widget buildLoading() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: kButtonText,
        ),
      ),
    );
  }

  Widget buildText() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        widget.text,
        style: const TextStyle(
          color: kButtonText,
          letterSpacing: 1.5,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  Icon buildIconStart() {
    return Icon(
      widget.iconStart,
      color: kButtonText,
    );
  }

  Icon buildIconEnd() {
    return Icon(
      widget.iconEnd,
      color: kButtonText,
    );
  }

  void inDevelopment(BuildContext context) {
    setState(() => loading = true);
    RSBSnackBar().show(
        context: context, message: "In development", color: Colors.yellow);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.paddingButton,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        onPressed: widget.onPressed ?? () => inDevelopment(context),
        child: Row(
          mainAxisAlignment: widget.iconStart != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: (loading)
              ? [buildLoading()]
              : (widget.iconStart != null || widget.iconEnd != null)
                  ? [buildIconStart(), buildText(), buildIconEnd()]
                  : widget.image != null
                      ? [widget.image!, buildText()]
                      : [buildText()],
        ),
      ),
    );
  }
}
