import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCounter extends StatefulWidget {
  final void Function()? increment;
  final void Function()? decrement;
  final int amount;
  int currentCount;

  AppCounter({
    Key? key,
    required this.amount,
    this.increment,
    this.decrement,
  required  this.currentCount ,
  }) : super(key: key);

  @override
  State<AppCounter> createState() => _AppCounterState();
}

class _AppCounterState extends State<AppCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.h,
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: const Color(0xff4C8613).withOpacity(.11),
      ),
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 5.w,
        vertical: 3.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap:
            widget.increment,
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: widget.currentCount < widget.amount
                    ? Colors.white
                    : Colors.transparent,
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: widget.currentCount < widget.amount
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
            ),
          ),
          Text(widget.currentCount.toString(),
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              )),
          GestureDetector(
            onTap:
            widget.decrement,
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: widget.currentCount <= 0
                    ? Colors.transparent
                    : Colors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.remove,
                  color: widget.currentCount <= 0
                      ? Colors.grey
                      : Theme.of(context).primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
