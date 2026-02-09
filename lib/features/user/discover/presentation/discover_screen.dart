import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_network_image.dart';
import 'package:oscaru95/constants/app_constants.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/user/discover/presentation/widget/comment_screen.dart';
import 'package:oscaru95/features/user/home/model/discover_response.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/di.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/discover_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int? favId;

  bool isFav = false;
  @override
  void initState() {
    disoverFilterRxObj.getFilter();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiscoverProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discover',
                      style: TextFontStyle.headline16w600CFFFFFFPoppins),
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(Routes.filterScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFE5401),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: SvgPicture.asset(
                        Assets.icons.filters,
                        fit: BoxFit.cover,
                        height: 16.h,
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(16.h),
              StreamBuilder(
                stream: disoverFilterRxObj.getFoodSpecialtream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    DiscoverResponse response = snapshot.data;
                    return response.data!.isEmpty
                        ? Center(
                            child: Text(
                              "No data found",
                              style: TextFontStyle.headline18w600cFFFFFFPoppins,
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.only(bottom: 30.h),
                              // shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = response.data![index];

                                return DiscoverItems(
                                  id: data.id.toString(),
                                  type: data.establishment ?? "",
                                  img: data.cover ?? "",
                                  favButton: () {},
                                  titile: data.venueName ?? "",
                                  location: data.address ?? "",
                                  distance: '30 km',
                                  ratting: "4.5 (12)",
                                  day:
                                      "(${data.fromDay ?? "N/A"} to ${data.toDay ?? "N/A"} )",
                                  time: "(7:00 AM - 8:00 PM)",
                                  likeCount: provider.likeCount.toString(),
                                  commentCount: "${data.totalComment ?? ""}",
                                  firstViewProfileUrl:
                                      "https://img.freepik.com/free-photo/bearded-man-wearing-red-beanie_23-2148378557.jpg",
                                  secoundViewProfileUrl:
                                      "https://img.freepik.com/free-photo/bearded-man-wearing-red-beanie_23-2148378557.jpg",
                                  thirdViewProfileUrl:
                                      "https://img.freepik.com/free-photo/bearded-man-wearing-red-beanie_23-2148378557.jpg",
                                  timeAgo: "5 hours ago",
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  UIHelper.verticalSpaceSmall,
                              itemCount: response.data!.length,
                            ),
                          );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DiscoverItems extends StatefulWidget {
  final VoidCallback favButton;
  final String titile;
  final String location;
  final String img;
  final String type;
  final String id;
  final String distance;
  final String ratting;
  final String day;
  final String time;
  final String likeCount;
  final String commentCount;
  final String firstViewProfileUrl;
  final String secoundViewProfileUrl;
  final String thirdViewProfileUrl;
  final String timeAgo;

  const DiscoverItems(
      {super.key,
      required this.favButton,
      required this.titile,
      required this.location,
      required this.type,
      required this.distance,
      required this.ratting,
      required this.img,
      required this.id,
      required this.day,
      required this.time,
      required this.likeCount,
      required this.commentCount,
      required this.firstViewProfileUrl,
      required this.secoundViewProfileUrl,
      required this.thirdViewProfileUrl,
      required this.timeAgo});

  @override
  State<DiscoverItems> createState() => _DiscoverItemsState();
}

class _DiscoverItemsState extends State<DiscoverItems> {
  @override
  Widget build(BuildContext context) {
    final discoverProvider = Provider.of<DiscoverProvider>(context);
    var userIdFromStorage = appData.read(KKeyUserId);
    bool fav = false;
    List<String> comments = [
      "Great post!",
      "I agree with this.",
      "Nice photo!",
    ];

    // This function is called when a new comment is submitted
    void onCommentSubmit(String comment) {
      setState(() {
        comments.add(comment); // Add the new comment to the list
      });
    }

    int userId;
    userId = int.parse(widget.id);
    print("this is user id:$userId");
    return Container(
        margin: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          color: AppColors.c282828,
          borderRadius: BorderRadius.circular(8.r),
          // image: DecorationImage(
          //   image: AssetImage(
          //     Assets.images.restaurentDiscover.path,

          //   ),
          // ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomNetworkImageWidget(
                  status: true,
                  urls: widget.img,
                  height: 166.h,
                  width: double.infinity,
                ),
                Positioned(
                  top: 11.h,
                  right: 10.w,
                  child: InkWell(
                    onTap: () {
                      addFavouriteRx
                          .addToFavourite(id: widget.id)
                          .then((success) {
                        discoverProvider.fav();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                        color: discoverProvider.isFavorite
                            ? AppColors.cFFFFFF
                            : AppColors.allPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        Assets.icons.favIcon,
                        width: 16.w,
                      ),
                    ),
                  ),
                )
              ],
            ),
            UIHelper.verticalSpace(16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.type,
                    style: TextFontStyle.headline10w400c6B6B6BPoppins
                        .copyWith(color: AppColors.c999999),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.titile,
                        style: TextFontStyle.headline18w400CFFFFFFPoppins,
                      ),
                      SvgPicture.asset(
                        Assets.icons.crown,
                        width: 16.w,
                      )
                    ],
                  ),
                  UIHelper.verticalSpace(5.h),
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icons.location),
                      Expanded(
                        child: Text(
                          widget.location,
                          style: TextFontStyle.headline10w400c6B6B6BPoppins
                              .copyWith(color: AppColors.c999999),
                        ),
                      ),
                      UIHelper.horizontalSpace(4.w),
                      Text(
                        "•",
                        style: TextFontStyle.headline10w400c6B6B6BPoppins
                            .copyWith(color: AppColors.c999999),
                      ),
                      UIHelper.horizontalSpace(4.w),
                      Text(
                        widget.distance,
                        style: TextFontStyle.headline10w400c6B6B6BPoppins
                            .copyWith(color: AppColors.c999999),
                      ),
                      UIHelper.horizontalSpace(4.w),
                      Text(
                        "•",
                        style: TextFontStyle.headline10w400c6B6B6BPoppins
                            .copyWith(color: AppColors.c999999),
                      ),
                      UIHelper.horizontalSpace(4.w),
                      SvgPicture.asset(
                        Assets.icons.star,
                      ),
                      UIHelper.horizontalSpace(4.w),
                      Text(
                        widget.ratting,
                        style: TextFontStyle.headline10w400c6B6B6BPoppins
                            .copyWith(color: AppColors.c999999),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(7.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                          color: AppColors.c484848,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Happy Hour",
                              style: TextFontStyle.headline12w500c222222Poppins
                                  .copyWith(color: AppColors.cFFFFFF),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.day,
                                  style:
                                      TextFontStyle.headline6w400cFFFFFFPoppins,
                                ),
                                Text(
                                  "•",
                                  style: TextFontStyle
                                      .headline6w400cFFFFFFPoppins
                                      .copyWith(color: AppColors.cFFFFFF),
                                ),
                                Text(widget.time,
                                    style: TextFontStyle
                                        .headline6w400cFFFFFFPoppins),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: AppColors.cFE5401,
                        child: Icon(
                          CupertinoIcons.arrow_right,
                          color: AppColors.cFFFFFF,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(10.h),
                  const Divider(
                    color: AppColors.c343434,
                  ),
                  UIHelper.verticalSpace(8.h),
                  Row(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () async {
                                discoverProvider.toggleLike();
                                await likePostRxObj
                                    .like(id: userId)
                                    .then((response) {
                                  getDiscoverRx.getDiscover();
                                });
                              },
                              child: SvgPicture.asset(Assets.icons.like)),
                          UIHelper.horizontalSpace(4.w),
                          Text(
                            widget.likeCount,
                            style: TextFontStyle.headline12w400C999999Poppins,
                          )
                        ],
                      ),
                      UIHelper.horizontalSpace(32.w),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: AppColors.scaffoldColor,
                                    context: context,
                                    builder: (context) {
                                      return CommentBottomSheet(
                                          id: widget.id,
                                          initialComments: comments,
                                          onCommentSubmit: onCommentSubmit);
                                    });
                              },
                              child: SvgPicture.asset(Assets.icons.comment)),
                          UIHelper.horizontalSpace(4.w),
                          Text(
                            widget.commentCount,
                            style: TextFontStyle.headline12w400C999999Poppins,
                          )
                        ],
                      ),
                      UIHelper.horizontalSpace(32.w),
                      SvgPicture.asset(Assets.icons.send),
                    ],
                  ),
                  UIHelper.verticalSpace(15.h),
                  Row(
                    children: [
                      SizedBox(
                        height: 32,
                        width: 96,
                        child: Stack(
                          children: [
                            Positioned(
                                left: 0, // Position the first image,
                                child: CustomNetworkImageWidget(
                                  urls: widget.firstViewProfileUrl,
                                  height: 32.h,
                                  width: 32.w,
                                )),
                            Positioned(
                                left: 20
                                    .w, // Slightly offset the second image to overlap
                                child: CustomNetworkImageWidget(
                                  urls: widget.secoundViewProfileUrl,
                                  height: 32.h,
                                  width: 32.w,
                                )),
                            Positioned(
                              left: 40.w, // Offset the third image further
                              child: CustomNetworkImageWidget(
                                urls: widget.thirdViewProfileUrl,
                                height: 32.h,
                                width: 32.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Text(
                        "Liked by kerry01 and 56fatema others",
                        style: TextFontStyle.headline10w500c6B6B6BPoppins,
                      ))
                    ],
                  ),
                  ReadMoreText(
                    delimiterStyle: TextFontStyle.headline10w500c6B6B6BPoppins,
                    style: TextFontStyle.headline10w500c6B6B6BPoppins,
                    'kerry01 There is no such thing as a perfect deal, i am very happy with thatnnnnnnnnnnnnnnnnnnnnnnnnnnnnn',
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimCollapsedText: 'View more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.timeAgo,
                    style: TextFontStyle.headline8w400cFFFFFFPoppins
                        .copyWith(color: AppColors.c535353),
                  ),
                  UIHelper.verticalSpace(12.h)
                ],
              ),
            )
          ],
        ));
  }
}
