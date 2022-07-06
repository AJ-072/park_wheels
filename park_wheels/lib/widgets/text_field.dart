import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircularBorderTextField extends StatelessWidget{
  final TextInputType keyboardType;
  final String label;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  CircularBorderTextField({this.keyboardType = TextInputType.text,this.label = '',this.prefixIcon,this.validator,this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label,helperText: '',border: const OutlineInputBorder(),prefixIcon: prefixIcon),
      validator: validator,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

}

class PasswordTextField extends StatefulWidget{
  final String label;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  PasswordTextField({this.label = 'Password',this.validator,this.controller});



  @override
  State<StatefulWidget> createState() =>PasswordTextFieldState();

}

class PasswordTextFieldState extends State<PasswordTextField>{

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscure,
      validator: widget.validator,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.label,
        helperText: '',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: GestureDetector(
          onTap: ()=>setState(()=>obscure = !obscure),
          child: Icon(obscure?Icons.visibility_off:Icons.visibility),
        )
      ),

    );
  }
}