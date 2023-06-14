import 'package:dartus/tomuss.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:sizer/sizer.dart';

class GradeCoefWidget extends StatefulWidget {
  const GradeCoefWidget({
    Key? key,
    required this.grade,
  }) : super(key: key);

  final Grade grade;

  @override
  State<GradeCoefWidget> createState() => _GradeCoefWidgetState();
}

class _GradeCoefWidgetState extends State<GradeCoefWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.grade.coef != 1.0) {
      _controller.text = (widget.grade.coef).toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key('GradeCoefWidget${widget.grade.title}'),
      padding: EdgeInsets.only(right: 2.w),
      child: SizedBox(
        width: 14.5.w,
        height: 13.w,
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 10.sp,
              color: Theme.of(context).textTheme.bodyLarge!.color!),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
            hintText: "1.0",
          ),
          onChanged: (value) {
            context.read<TomussCubit>().updateCoef(
                widget.grade, (value.isNotEmpty) ? double.parse(value) : null);
          },
        ),
      ),
    );
  }
}
