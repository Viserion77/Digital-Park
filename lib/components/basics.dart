import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String tip;
  final double fontSize;
  final IconData icon;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry padding;

  Input(
      {this.controller,
      this.label,
      this.tip,
      this.fontSize,
      this.icon,
      this.keyboardType,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding != null
          ? padding
          : EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      child: Container(
        height: 40,
        decoration: new BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: controller,
          cursorColor: Colors.lightGreen,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(8),
              ),
            ),
            icon: icon != null ? Icon(icon) : null,
            labelText: label,
            hintText: tip,
          ),
          style: TextStyle(
            fontSize: fontSize != null ? fontSize : 16,
          ),
          keyboardType:
              keyboardType != null ? keyboardType : TextInputType.text,
        ),
      ),
    );
  }
}

class LabelBox extends StatelessWidget {
  final String label;
  final Function function;
  final bool value;

  const LabelBox({Key key, this.label, this.function, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (bool value) => function(),
          ),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onPressed;
  final double fontSize;
  final Color fontColor;
  final Color backgroundColor;
  final String imageAsset;
  final double height;

  Button(
      {this.height,
      this.label,
      this.icon,
      this.onPressed,
      this.fontSize,
      this.fontColor,
      this.backgroundColor,
      this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: RaisedButton(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: imageAsset != null,
                child: Image.asset(
                  imageAsset != null ? imageAsset : '',
                  width: 32,
                ),
              ),
              Visibility(
                visible: icon != null,
                child: Icon(icon),
              ),
              Container(
                child: Text(
                  label != null ? label : null,
                  style: TextStyle(
                    fontSize: fontSize != null ? fontSize : 24,
                    color: fontColor != null
                        ? fontColor
                        : Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                height: height != null ? height : null,
              )
            ],
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class TextFunction extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  TextFunction({this.label, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon != null ? icon : null),
              Text(
                label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
