import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_button.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/loading_helper.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/discover_provider.dart';
import 'package:provider/provider.dart';

class CommentBottomSheet extends StatefulWidget {
  final String id;

  final List<String> initialComments;
  final Function(String comment) onCommentSubmit;

  const CommentBottomSheet({
    super.key,
    required this.initialComments,
    required this.id,
    required this.onCommentSubmit,
  });

  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  late List<String> comments;

  @override
  void initState() {
    super.initState();
    comments = widget.initialComments;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiscoverProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add a Comment',
                style: TextFontStyle.headline10w400c6B6B6BPoppins
                    .copyWith(color: AppColors.cFFFFFF, fontSize: 16.sp),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: AppColors.cFFFFFF,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),

          // List of existing comments
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              itemCount: provider.comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    provider.comments[index],
                    style: TextFontStyle.headline10w400c6B6B6BPoppins
                        .copyWith(color: AppColors.cFFFFFF),
                  ),
                );
              },
            ),
          ),

          // Text input for the new comment
          CustomFormField(
            controller: _controller,
            hintText: "Write Your Comment",
          ), // Submit Button
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                textStaus: false,
                borderBg: false,
                fontSize: 10.sp,
                width: 100.w,
                height: 30.h,
                onTap: () async {
                  String comment = _controller.text.trim();
                  await commentRxObj
                      .commentRx(id: widget.id, comment: comment)
                      .waitingForSucess()
                      .then((success) {
                    if (comment.isNotEmpty) {
                      provider.comments.add(comment);
                      widget
                          .onCommentSubmit(comment); // Notify the parent widget
                      _controller.clear(); // Clear the input field
                    }
                  });
                },
                btnName: "Comment",
              )
              // ElevatedButton(
              //   onPressed: () {
              //     String comment = _controller.text.trim();
              //     if (comment.isNotEmpty) {
              //       setState(() {
              //         comments.add(comment); // Add the new comment to the list
              //       });
              //       widget.onCommentSubmit(comment); // Notify the parent widget
              //       _controller.clear(); // Clear the input field
              //     }
              //   },
              //   child: const Text("Post Comment"),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
