import 'package:flutter/material.dart';
import 'package:oscaru95/features/user/setting/model/story_model.dart';
import 'package:oscaru95/networks/api_access.dart';
import 'package:story/story_page_view.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  void initState() {
    storyRxObj.getStory(); // Assuming this fetches the stories
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: storyRxObj.userProfileStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                StoryModel dataModel = snapshot.data!;

                return StoryPageView(
                  itemBuilder: (context, pageIndex, storyIndex) {
                    // Ensure storyIndex is within bounds for the API's data
                    if (storyIndex >= dataModel.data!.length) {
                      return const SizedBox
                          .shrink(); // Return an empty widget if out of bounds
                    }

                    var story = dataModel.data![
                        storyIndex]; // Get the story based on the storyIndex

                    return Stack(
                      children: [
                        Positioned.fill(
                          child:
                              Container(color: Colors.black.withOpacity(0.7)),
                        ),
                        Positioned.fill(
                          child: Image.network(
                            "https://oscaru.softvencefsd.xyz/${story.image}",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        _buildUserProfile(), // Assuming you have dynamic user profile data
                      ],
                    );
                  },
                  gestureItemBuilder: (context, pageIndex, storyIndex) {
                    return Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: IconButton(
                          color: Colors.white,
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    );
                  },
                  pageLength: 1,
                  storyLength: (int pageIndex) => dataModel
                      .data!.length,
                  onPageLimitReached: () => Navigator.pop(context),
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Padding(
      padding: const EdgeInsets.only(top: 44, left: 8),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              'https://randomuser.me/api/portraits/men/1.jpg',
              height: 32,
              width: 32,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'John Doe', // Replace with dynamic user name
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
