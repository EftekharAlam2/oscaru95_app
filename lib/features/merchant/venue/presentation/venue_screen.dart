import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oscaru95/common_widget/custom_network_image.dart';
import 'package:oscaru95/constants/text_font_style.dart';
import 'package:oscaru95/features/user/discover/presentation/widget/comment_screen.dart';
import 'package:oscaru95/features/user/home/model/discover_response.dart';
import 'package:oscaru95/gen/assets.gen.dart';
import 'package:oscaru95/gen/colors.gen.dart';
import 'package:oscaru95/helpers/all_routes.dart';
import 'package:oscaru95/helpers/navigation_service.dart';
import 'package:oscaru95/helpers/ui_helpers.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:oscaru95/provider/discover_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class VenueScreen extends StatefulWidget {
  const VenueScreen({super.key});

  @override
  State<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  int? favId;
  bool isFav = false;
  final _searchCnt = TextEditingController();

  // Track deleted venue IDs
  final Set<String> _deletedVenueIds = {};

  // Track edited venues
  final Map<String, Map<String, dynamic>> _editedVenues = {};

  // Track added venues
  final List<Map<String, dynamic>> _addedVenues = [];

  @override
  void initState() {
    disoverFilterRxObj.getFilter();
    super.initState();
  }

  @override
  void dispose() {
    _searchCnt.dispose();
    super.dispose();
  }

  /// Delete shop and add to deleted list
  Future<void> _removeShopFromJson(String shopId) async {
    try {
      // Add to deleted set
      setState(() {
        _deletedVenueIds.add(shopId);
      });

      // Reload the discover data to refresh the list
      await disoverFilterRxObj.getFilter();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Venue removed successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error removing venue: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error removing venue'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Show edit dialog
  void _showEditDialog(
    BuildContext context,
    String venueId,
    String venueName,
    String location,
    String type,
    String openHour,
    String closeHour,
  ) {
    final nameController = TextEditingController(text: venueName);
    final locationController = TextEditingController(text: location);
    final typeController = TextEditingController(text: type);
    final openHourController = TextEditingController(text: openHour);
    final closeHourController = TextEditingController(text: closeHour);
    final ratingController = TextEditingController();
    final distanceController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.c282828,
        title: Text(
          'Edit Venue',
          style: TextFontStyle.headline16w600CFFFFFFPoppins,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Venue Name
              TextField(
                controller: nameController,
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                decoration: InputDecoration(
                  labelText: 'Venue Name',
                  labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                  hintStyle: TextFontStyle.headline14w400c6B6B6BPoppins,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Type
              TextField(
                controller: typeController,
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                decoration: InputDecoration(
                  labelText: 'Type (Restaurant/Bar/etc)',
                  labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                  hintStyle: TextFontStyle.headline14w400c6B6B6BPoppins,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Location/Address with Map Button
              GestureDetector(
                onTap: () {
                  // TODO: Open map picker here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Map picker coming soon'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: TextField(
                  controller: locationController,
                  enabled: false,
                  style: TextFontStyle.headline14w400CFFFFFFPoppins,
                  decoration: InputDecoration(
                    labelText: 'Location/Address (Tap to pick)',
                    labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                    hintStyle: TextFontStyle.headline14w400c6B6B6BPoppins,
                    filled: true,
                    fillColor: AppColors.c282828,
                    suffixIcon: Icon(Icons.location_on, color: Color(0xFFFE5401)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Color(0xFFFE5401)),
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Open Hour Time Picker
              GestureDetector(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    openHourController.text = "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}:00";
                  }
                },
                child: TextField(
                  controller: openHourController,
                  enabled: false,
                  style: TextFontStyle.headline14w400CFFFFFFPoppins,
                  decoration: InputDecoration(
                    labelText: 'Open Hour',
                    labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                    hintStyle: TextFontStyle.headline14w400c6B6B6BPoppins,
                    filled: true,
                    fillColor: AppColors.c282828,
                    suffixIcon: Icon(Icons.access_time, color: Color(0xFFFE5401)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Color(0xFFFE5401)),
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Close Hour Time Picker
              GestureDetector(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    closeHourController.text = "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}:00";
                  }
                },
                child: TextField(
                  controller: closeHourController,
                  enabled: false,
                  style: TextFontStyle.headline14w400CFFFFFFPoppins,
                  decoration: InputDecoration(
                    labelText: 'Close Hour',
                    labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                    hintStyle: TextFontStyle.headline14w400c6B6B6BPoppins,
                    filled: true,
                    fillColor: AppColors.c282828,
                    suffixIcon: Icon(Icons.access_time, color: Color(0xFFFE5401)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: Color(0xFFFE5401)),
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Rating
              TextField(
                controller: ratingController,
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Rating (0-5)',
                  labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                  hintStyle: TextFontStyle.headline14w400c6B6B6BPoppins,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Distance
              TextField(
                controller: distanceController,
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Distance (km)',
                  labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                  hintStyle: TextFontStyle.headline14w400c6B6B6BPoppins,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: TextFontStyle.headline14w400CFFFFFFPoppins,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _saveEditedVenue(
                venueId,
                nameController.text,
                locationController.text,
                typeController.text,
                openHourController.text,
                closeHourController.text,
                ratingController.text,
                distanceController.text,
              );
            },
            child: Text(
              'Save',
              style: TextFontStyle.headline14w400CFFFFFFPoppins
                  .copyWith(color: Color(0xFFFE5401)),
            ),
          ),
        ],
      ),
    );
  }

  /// Save edited venue
  void _saveEditedVenue(
    String venueId,
    String newName,
    String newLocation,
    String newType,
    String newOpenHour,
    String newCloseHour,
    String newRating,
    String newDistance,
  ) {
    setState(() {
      _editedVenues[venueId] = {
        'name': newName,
        'location': newLocation,
        'type': newType,
        'open_hour': newOpenHour,
        'close_hour': newCloseHour,
        'rating': newRating,
        'distance': newDistance,
      };
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Venue updated successfully'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  /// Get edited venue name
  String _getVenueName(String venueId, String originalName) {
    return _editedVenues[venueId]?['name'] ?? originalName;
  }

  /// Get edited venue location
  String _getVenueLocation(String venueId, String originalLocation) {
    return _editedVenues[venueId]?['location'] ?? originalLocation;
  }

  /// Get edited venue type
  String _getVenueType(String venueId, String originalType) {
    return _editedVenues[venueId]?['type'] ?? originalType;
  }

  /// Get edited venue open hour
  String _getVenueOpenHour(String venueId, String originalOpenHour) {
    return _editedVenues[venueId]?['open_hour'] ?? originalOpenHour;
  }

  /// Get edited venue close hour
  String _getVenueCloseHour(String venueId, String originalCloseHour) {
    return _editedVenues[venueId]?['close_hour'] ?? originalCloseHour;
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
                  Text('Venues',
                      style: TextFontStyle.headline16w600CFFFFFFPoppins),
                  Row(
                    children: [
                      // Add Venue Button
                      GestureDetector(
                        onTap: () {
                          _showAddVenueDialog(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12.sp),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFE5401),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Icon(
                            Icons.add,
                            color: AppColors.cFFFFFF,
                            size: 16.sp,
                          ),
                        ),
                      ),
                      UIHelper.horizontalSpace(8.w),
                      // Filter Button
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
                ],
              ),
              UIHelper.verticalSpace(16.h),
              // Search Field
              TextField(
                controller: _searchCnt,
                onChanged: (value) {
                  provider.setSearchQuery(value);
                  disoverFilterRxObj.getFilter(searchQuery: value);
                },
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                decoration: InputDecoration(
                  hintText: "Search venues...",
                  hintStyle: TextFontStyle.headline14w400c6B6B6BPoppins,
                  prefixIcon: Icon(CupertinoIcons.search, size: 18.sp, color: AppColors.c9C9C9C),
                  suffixIcon: _searchCnt.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchCnt.clear();
                            provider.clearSearch();
                            disoverFilterRxObj.getFilter();
                          },
                          child: Icon(CupertinoIcons.clear, size: 18.sp, color: AppColors.c9C9C9C),
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
              UIHelper.verticalSpace(16.h),
              StreamBuilder(
                stream: disoverFilterRxObj.getFoodSpecialtream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    DiscoverResponse response = snapshot.data;

                    // Filter out deleted venues
                    final filteredVenues = response.data!
                        .where((venue) => !_deletedVenueIds.contains(venue.id.toString()))
                        .toList();

                    return filteredVenues.isEmpty
                        ? Center(
                            child: Text(
                              "No venues found",
                              style: TextFontStyle.headline18w600cFFFFFFPoppins,
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.only(bottom: 30.h),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = filteredVenues[index];
                                final displayName = _getVenueName(data.id.toString(), data.venueName ?? "");
                                final displayLocation = _getVenueLocation(data.id.toString(), data.address ?? "");
                                final displayType = _getVenueType(data.id.toString(), data.establishment ?? "");
                                final displayOpenHour = _getVenueOpenHour(data.id.toString(), data.fromDay ?? "N/A");
                                final displayCloseHour = _getVenueCloseHour(data.id.toString(), data.toDay ?? "N/A");

                                return VenueItems(
                                  id: data.id.toString(),
                                  type: displayType,
                                  img: data.cover ?? "",
                                  favButton: () {},
                                  titile: displayName,
                                  location: displayLocation,
                                  distance: data.distance ?? "",
                                  ratting: "${data.averageRating} (12)",
                                  day: "($displayOpenHour to $displayCloseHour)",
                                  time: "",
                                  likeCount: provider.likeCount.toString(),
                                  commentCount: "${data.totalComment ?? ""}",
                                  firstViewProfileUrl:
                                      "https://img.freepik.com/free-photo/bearded-man-wearing-red-beanie_23-2148378557.jpg",
                                  secoundViewProfileUrl:
                                      "https://img.freepik.com/free-photo/bearded-man-wearing-red-beanie_23-2148378557.jpg",
                                  thirdViewProfileUrl:
                                      "https://img.freepik.com/free-photo/bearded-man-wearing-red-beanie_23-2148378557.jpg",
                                  timeAgo: "5 hours ago",
                                  onDelete: () => _showDeleteConfirmation(
                                    context,
                                    data.id.toString(),
                                    displayName,
                                  ),
                                  onEdit: () => _showEditDialog(
                                    context,
                                    data.id.toString(),
                                    displayName,
                                    displayLocation,
                                    displayType,
                                    displayOpenHour,
                                    displayCloseHour,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  UIHelper.verticalSpaceSmall,
                              itemCount: filteredVenues.length,
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

  /// Show confirmation dialog before deleting
  void _showDeleteConfirmation(BuildContext context, String shopId, String shopName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.c282828,
        title: Text(
          'Delete Venue',
          style: TextFontStyle.headline16w600CFFFFFFPoppins,
        ),
        content: Text(
          'Are you sure you want to delete "$shopName"?',
          style: TextFontStyle.headline14w400CFFFFFFPoppins,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: TextFontStyle.headline14w400CFFFFFFPoppins,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _removeShopFromJson(shopId);
            },
            child: Text(
              'Delete',
              style: TextFontStyle.headline14w400CFFFFFFPoppins
                  .copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  /// Show add venue dialog
  void _showAddVenueDialog(BuildContext context) {
    final nameController = TextEditingController();
    final typeController = TextEditingController();
    final locationController = TextEditingController();
    final openHourController = TextEditingController();
    final closeHourController = TextEditingController();
    final latitudeController = TextEditingController();
    final longitudeController = TextEditingController();
    final ratingController = TextEditingController();
    final distanceController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.c282828,
        title: Text(
          'Add New Venue',
          style: TextFontStyle.headline16w600CFFFFFFPoppins,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Venue Name
              TextField(
                controller: nameController,
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                decoration: InputDecoration(
                  labelText: 'Venue Name *',
                  labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Type
              TextField(
                controller: typeController,
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                decoration: InputDecoration(
                  labelText: 'Type (Restaurant/Bar) *',
                  labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Location/Address with Map Picker
              GestureDetector(
                onTap: () {
                  // TODO: Implement map picker
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Map picker coming soon'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: TextField(
                  controller: locationController,
                  enabled: false,
                  style: TextFontStyle.headline14w400CFFFFFFPoppins,
                  decoration: InputDecoration(
                    labelText: 'Location/Address (Tap to pick) *',
                    labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                    filled: true,
                    fillColor: AppColors.c282828,
                    suffixIcon: Icon(Icons.location_on, color: Color(0xFFFE5401)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Open Hour Time Picker
              GestureDetector(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    openHourController.text = "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}:00";
                  }
                },
                child: TextField(
                  controller: openHourController,
                  enabled: false,
                  style: TextFontStyle.headline14w400CFFFFFFPoppins,
                  decoration: InputDecoration(
                    labelText: 'Open Hour *',
                    labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                    filled: true,
                    fillColor: AppColors.c282828,
                    suffixIcon: Icon(Icons.access_time, color: Color(0xFFFE5401)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Close Hour Time Picker
              GestureDetector(
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    closeHourController.text = "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}:00";
                  }
                },
                child: TextField(
                  controller: closeHourController,
                  enabled: false,
                  style: TextFontStyle.headline14w400CFFFFFFPoppins,
                  decoration: InputDecoration(
                    labelText: 'Close Hour *',
                    labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                    filled: true,
                    fillColor: AppColors.c282828,
                    suffixIcon: Icon(Icons.access_time, color: Color(0xFFFE5401)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(color: AppColors.c535353),
                    ),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Rating
              TextField(
                controller: ratingController,
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Rating (0-5) *',
                  labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Distance
              TextField(
                controller: distanceController,
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Distance (km) *',
                  labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Latitude
              TextField(
                controller: latitudeController,
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Latitude *',
                  labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              // Longitude
              TextField(
                controller: longitudeController,
                style: TextFontStyle.headline14w400CFFFFFFPoppins,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Longitude *',
                  labelStyle: TextFontStyle.headline12w400c6B6B6BPoppins,
                  filled: true,
                  fillColor: AppColors.c282828,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: AppColors.c535353),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Color(0xFFFE5401)),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: TextFontStyle.headline14w400CFFFFFFPoppins,
            ),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isEmpty ||
                  typeController.text.isEmpty ||
                  locationController.text.isEmpty ||
                  openHourController.text.isEmpty ||
                  closeHourController.text.isEmpty ||
                  ratingController.text.isEmpty ||
                  distanceController.text.isEmpty ||
                  latitudeController.text.isEmpty ||
                  longitudeController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all required fields'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              Navigator.of(dialogContext).pop();
              _saveAddedVenue(
                nameController.text,
                typeController.text,
                locationController.text,
                openHourController.text,
                closeHourController.text,
                latitudeController.text,
                longitudeController.text,
                ratingController.text,
                distanceController.text,
              );
            },
            child: Text(
              'Add',
              style: TextFontStyle.headline14w400CFFFFFFPoppins
                  .copyWith(color: Color(0xFFFE5401)),
            ),
          ),
        ],
      ),
    );
  }

  /// Save added venue
  void _saveAddedVenue(
    String name,
    String type,
    String location,
    String openHour,
    String closeHour,
    String latitude,
    String longitude,
    String rating,
    String distance,
  ) {
    final newVenue = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'venue_name': name,
      'type': type,
      'address': location,
      'open_hour': openHour,
      'close_hour': closeHour,
      'latitude': latitude,
      'longitude': longitude,
      'cover': 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=500&h=400&fit=crop',
      'distance': '$distance km',
      'average_rating': double.tryParse(rating) ?? 0,
      'total_review': 0,
      'is_wishlisted': false,
    };

    setState(() {
      _addedVenues.add(newVenue);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Venue added successfully'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class VenueItems extends StatefulWidget {
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
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const VenueItems(
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
      required this.timeAgo,
      required this.onDelete,
      required this.onEdit});

  @override
  State<VenueItems> createState() => _VenueItemsState();
}

class _VenueItemsState extends State<VenueItems> {
  @override
  Widget build(BuildContext context) {
    final discoverProvider = Provider.of<DiscoverProvider>(context);
    List<String> comments = [
      "Great post!",
      "I agree with this.",
      "Nice photo!",
    ];

    void onCommentSubmit(String comment) {
      setState(() {
        comments.add(comment);
      });
    }

    int userId = int.parse(widget.id);
    return Container(
        margin: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          color: AppColors.c282828,
          borderRadius: BorderRadius.circular(8.r),
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
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: widget.onEdit,
                        child: Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: Color(0xFFFE5401),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit_outlined,
                            color: AppColors.cFFFFFF,
                            size: 18.sp,
                          ),
                        ),
                      ),
                      UIHelper.horizontalSpace(8.w),
                      GestureDetector(
                        onTap: widget.onDelete,
                        child: Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: AppColors.cFFFFFF,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
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
                                discoverProvider.toggleItemLike(widget.id);
                                await likePostRxObj
                                    .like(id: userId)
                                    .then((response) {
                                  getDiscoverRx.getDiscover();
                                });
                              },
                              child: SvgPicture.asset(
                                discoverProvider.isItemLiked(widget.id)
                                    ? Assets.icons.heartColord
                                    : Assets.icons.like,
                              )),
                          UIHelper.horizontalSpace(4.w),
                          Text(
                            discoverProvider.getItemLikeCount(widget.id).toString(),
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
                                left: 0,
                                child: CustomNetworkImageWidget(
                                  urls: widget.firstViewProfileUrl,
                                  height: 32.h,
                                  width: 32.w,
                                )),
                            Positioned(
                                left: 20.w,
                                child: CustomNetworkImageWidget(
                                  urls: widget.secoundViewProfileUrl,
                                  height: 32.h,
                                  width: 32.w,
                                )),
                            Positioned(
                              left: 40.w,
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
                        "Liked by kerry01 and 56 others",
                        style: TextFontStyle.headline10w500c6B6B6BPoppins,
                      ))
                    ],
                  ),
                  ReadMoreText(
                    delimiterStyle: TextFontStyle.headline10w500c6B6B6BPoppins,
                    style: TextFontStyle.headline10w500c6B6B6BPoppins,
                    'Great venue for discovering amazing offers and deals!',
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
