import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MailAttachmentWidget extends StatelessWidget {
  const MailAttachmentWidget({
    super.key,
    required this.fileName,
    required this.onTap,
    this.icon = Icons.attach_file_rounded,
    this.onLongPress,
  });
  final String fileName;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
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
                style: TextStyle(fontSize: 15.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
