import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oscaru95/common_widget/custom_form_field.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/user/favourite/model/favourite_response.dart';
import 'package:oscaru95/features/user/home/presentation/widgets/home_list_tile_widget.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isFav = false;
  final TextEditingController _searchCnt = TextEditingController();

  @override
  void initState() {
    getFavouriteRx.getFavourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.scaffoldColor,
        centerTitle: false,
        title: Text(
          'Favourite',
          style: TextFontStyle.headline18w600CFFFFFFPoppins,
        ),
      ),
      body: StreamBuilder(
          stream: getFavouriteRx.favouriteStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              FavouriteResponse response = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       CustomFormField(
                  //         contentPadding: const EdgeInsets.all(0),
                  //         hintText: "Search",
                  //         controller: _searchCnt,
                  //         prefixIcon: Icon(
                  //           CupertinoIcons.search,
                  //           color: AppColors.cFE5401,
                  //           size: 18.sp,
                  //         ),
                  //         textInputAction: TextInputAction.search,
                  //       ),
                  //       UIHelper.verticalSpace(16.h),
                  //       Text("Only you can see what you’ve saved",
                  //           style: TextFontStyle.headline12w400c6B6B6BPoppins),
                  //       UIHelper.verticalSpace(16.h),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: response.data!.isEmpty
                        ? Center(
                            child: Text(
                              "No data found",
                              style: TextFontStyle.headline14w400CFFFFFFPoppins,
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            itemCount: response.data!.length,
                            separatorBuilder: (context, index) {
                              return UIHelper.verticalSpaceSmall;
                            },
                            itemBuilder: (context, index) {
                              final data = response.data![index];
                              return HomeListTileWidget(
                                id: data.id.toString(),
                                name: data.venueName,
                                locationAddress: data.address,
                                img: data.cover,
                                distance: data.distance,
                                ratting: data.averageRating.toString(),
                                totalReview: data.totalReview.toString(),
                                resturentType: data.type,
                                isFav: true,
                                onFavTap: () {
                                  // Remove from favorites
                                  addFavouriteRx.addToFavourite(
                                      id: data.id.toString());
                                },
                              );
                            },
                          ),
                  ),
                ],
              );
            }
            return const Center(child: Text("No data"));
          }),
    );
  }
}
