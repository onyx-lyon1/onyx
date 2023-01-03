import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmailAttachmentWidget extends StatelessWidget {
  const EmailAttachmentWidget({
    Key? key,
    required this.fileName,
    required this.onTap,
    this.icon = Icons.attach_file_rounded,
    this.onLongPress,
  }) : super(key: key);
  final String fileName;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20.sp,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                fileName,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
