import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_network_image.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/user/home/presentation/widgets/shop_profile_coupon_widget.dart';
import 'package:oscaru95/features/user/home/presentation/widgets/shop_profile_drink.dart';
import 'package:oscaru95/features/user/home/presentation/widgets/shop_profile_shop_widget.dart';
import 'package:oscaru95/features/user/profile/model/list_of_model.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class HomeTileDetailsScreen extends StatefulWidget {
  final String id;
  final String profileImage;
  final String title;
  final String type;
  final String location;
  final bool isWishlisted;
  final String distance;


  const HomeTileDetailsScreen({
    super.key,
    required this.profileImage,
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.isWishlisted,
    required this.distance
  });

  @override
  State<HomeTileDetailsScreen> createState() => _HomeTileDetailsScreenState();
}

class _HomeTileDetailsScreenState extends State<HomeTileDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    // Initial API call for Food tab
    foodListRxObj.getVenu(widget.id);

    // Tab change listener
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      switch (_tabController.index) {
        case 0:
          foodListRxObj.getVenu(widget.id);
          break;
        case 1:
          foodListRxObj.getVenu(widget.id);
          break;
        case 2:
          foodListRxObj.getVenu(widget.id);
          // Menu handled in StreamBuilder
          break;

        case 3:
          foodListRxObj.getVenu(widget.id);
          // Coupon handled statically
          break;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List icons = [
      Assets.icons.callCalling,
      Assets.icons.arrowSquare,
      Assets.icons.messageFavorite,
      Assets.icons.heartBoldIcon,
      widget.isWishlisted ? Assets.icons.heartBoldIcon  : Assets.icons.heartColord,
    ];
    print("this is my heart of screen:${widget.isWishlisted}");

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.sp, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildProfileImage(),
                          UIHelper.verticalSpace(10.h),
                          Text(
                            widget.title,
                            style: TextFontStyle.headline16w400CFFFFFFPoppins
                                .copyWith(fontSize: 22.sp),
                          ),
                       Row(
  mainAxisSize: MainAxisSize.min,
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    SvgPicture.asset(Assets.icons.shopGrayish),
    UIHelper.horizontalSpace(4.w),
    Flexible(
      child: Text(
        widget.type,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextFontStyle.headline14w400c666666Poppins
            .copyWith(color: AppColors.c999999),
      ),
    ),
    UIHelper.horizontalSpace(8.w),
    SvgPicture.asset(Assets.icons.locationGraish),
    UIHelper.horizontalSpace(4.w),
    Flexible(
      child: Text(
        widget.location,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextFontStyle.headline14w400c666666Poppins
            .copyWith(color: AppColors.c999999),
      ),
    ),
    UIHelper.horizontalSpace(6.w),
    Image.asset(
      Assets.images.routing.path,
      width: 24.w,
      height: 24.h,
    ),
    UIHelper.horizontalSpace(4.w),
    Text(
      widget.distance,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextFontStyle.headline10w400c6B6B6BPoppins
          .copyWith(color: AppColors.c999999),
    ),
  ],
),

                          
                          Text(
                            "Daily Operating Hour: 9:30 AM to 10:00 PM",
                            style: TextFontStyle.headline14w400c666666Poppins
                                .copyWith(color: AppColors.c999999),
                          ),
                          UIHelper.verticalSpace(24.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              icons.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  if (index == 2) {
                                    NavigationService.navigateToWithArgs(
                                        Routes.shopProfileRattingReviewScreen,
                                        {"id": widget.id});
                                    // NavigationService.navigateTo(
                                    //     Routes.shopProfileRattingReviewScreen);
                                  }
                                  if (index == 3) {
                                    setState(() {
                                      // widget = !isFav;
                                    });
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                                  padding: EdgeInsets.all(12.sp),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.c282828,
                                  ),
                                  child: SvgPicture.asset(
                                    icons[index],
                                    height: 18.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SvgPicture.asset(Assets.icons.shopGrayish),
                    //     UIHelper.horizontalSpace(4.w),
                    //     Text(
                    //       widget.type,
                    //       style: TextFontStyle
                    //           .headline14w400c666666Poppins
                    //           .copyWith(color: AppColors.c999999),
                    //     ),
                    //     UIHelper.horizontalSpace(8.w),
                    //     SvgPicture.asset(Assets.icons.locationGraish),
                    //     UIHelper.horizontalSpace(4.w),
                    //     Expanded(
                    //       child: Text(
                    //         widget.location,
                    //         style: TextFontStyle
                    //             .headline14w400c666666Poppins
                    //             .copyWith(color: AppColors.c999999),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    Positioned(
                      top: 0,
                      left: 18.w,
                      child: GestureDetector(
                        onTap: () => NavigationService.goBack(),
                        child: Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: const BoxDecoration(
                            color: AppColors.c282828,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.cFFFFFF,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: _TabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.cFE5401,
                    labelColor: AppColors.cFE5401,
                    unselectedLabelColor: AppColors.c999999,
                    dividerColor: AppColors.c282828,
                    labelStyle: TextFontStyle.headline12w500c222222Poppins,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const [
                      Tab(text: "Food"),
                      Tab(text: "Drink"),
                      Tab(text: "Menu"),
                      Tab(text: "Coupon"),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              ShopProfileFoodWidget(
                id: widget.id,
                tab: "tab=food",
              ),
              ShopProfileDrink(
                id: widget.id,
                tab: "tab=drink",
              ),
              StreamBuilder(
                stream: foodListRxObj.getDiscoverStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    FoodListModel model = snapshot.data;
                    var menu = model.data?.data?.menu;
                    if (menu == null) {
                      return Center(
                        child: Text(
                          "Menu is Not Upload",
                          style: TextFontStyle.headline10w400c6B6B6BPoppins
                              .copyWith(
                                  color: AppColors.cFFFFFF, fontSize: 16.sp),
                        ),
                      );
                    }
                    return Padding(
                        padding: EdgeInsets.all(12.sp),
                        child: CustomNetworkImageWidget(
                          urls: menu,
                          status: true,
                          menu: false,
                        ));
                  }
                  return const SizedBox.shrink();
                },
              ),
              const ShopProfileCouponWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () {
        NavigationService.navigateTo(Routes.addStory);
      },
      child: Container(
        height: 134.h,
        width: 134.w,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFFFFC900),
              Color(0XFFFE5401),
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(4.sp),
          child: ClipOval(
            child: CustomNetworkImageWidget(
              urls: widget.profileImage,
              height: 100.h,
              width: 100.w,
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  _TabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: AppColors.scaffoldColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) => false;
}
