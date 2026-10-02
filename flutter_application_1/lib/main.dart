import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFollowing = false;
  bool isLiked = false;

  int followers = 1000;
  int likes = 342;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;

      if (isFollowing) {
        followers++;
      } else {
        followers--;
      }
    });
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;

      if (isLiked) {
        likes++;
      } else {
        likes--;
      }
    });
  }

  void reset() {
    setState(() {
      isFollowing = false;
      isLiked = false;
      followers = 1000;
      likes = 342;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Avatar
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300",
              ),
            ),

            const SizedBox(height: 20),

            // Name
            const Text(
              "Li Anastassiya",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Profile description
            const Text(
              "IT in Business",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const Text(
              "4th year student at Narxoz University",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // Followers
            Text(
              "Followers: $followers",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Follow button
            ElevatedButton(
              onPressed: toggleFollow,
              child: Text(
                isFollowing ? "Following" : "Follow",
              ),
            ),

            const SizedBox(height: 15),

            // Like button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: toggleLike,
                  icon: Icon(
                    isLiked
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                ),

                Text(
                  "$likes",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Reset button
            OutlinedButton(
              onPressed: reset,
              child: const Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}