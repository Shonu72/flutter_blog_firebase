import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/services/crud.dart';
import 'package:flutter_blog/widgets/app_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  // final User? user;
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CrudMethods crudMethods = CrudMethods();
  Stream? blogStream;
    bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    crudMethods.getData().then((result) {
      blogStream = result;
      setState(() {});
    });
  }

  Widget blogsList() {
    return blogStream != null
        ? SingleChildScrollView(
            child: Column(
              children: <Widget>[
                StreamBuilder(
                    stream: blogStream,
                    builder: (context, snapshot) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 20),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imgUrl: snapshot.data!.docs[index].get('imgUrl'),
                              title: snapshot.data!.docs[index].get('title'),
                              description:
                                  snapshot.data!.docs[index].get('description'),
                              cateogry:
                                  snapshot.data!.docs[index].get('category'),
                              tag: snapshot.data!.docs[index].get('tag'),
                            );
                          });
                    })
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
  Future<void> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('loggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<dynamic> logout() async {
      await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('loggedIn');
      getLoggedInStatus(); // Call getLoggedInStatus here
      Get.offAllNamed(Routes.login);
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 122, 170, 194),
        centerTitle: true,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hk",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Blog",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 89, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: blogStream != null
              ? blogsList()
              : const Center(
                  child: CircularProgressIndicator(),
                )),
      // if user loggedin then show floating action button

      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Get.toNamed(Routes.addblogPage);
                },
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.blueGrey,
                )),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String description;
  final String cateogry;
  final String tag;

  const BlogTile(
      {super.key,
      required this.imgUrl,
      required this.title,
      required this.description,
      required this.cateogry,
      required this.tag});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 550) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.network(
                      imgUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomAppText(
                      text: title,
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  CustomAppText(
                      text: description,
                      fontSize: 18,
                      maxLines: 2,
                      color: Colors.white.withOpacity(0.8),
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.normal),
                  const SizedBox(height: 2),
                  CustomAppText(
                      text: "Tags: $tag Category: $cateogry",
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                  const SizedBox(height: 2),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Read More..",
                      style: TextStyle(color: Colors.purple, fontSize: 16),
                    )),
              ),
            ],
          ),
        );
      } else {
        return Container(
          margin: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppText(
                        text: title,
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomAppText(
                        text: description,
                        fontSize: 18,
                        maxLines: 2,
                        color: Colors.white.withOpacity(0.8),
                        textAlign: TextAlign.justify,
                        fontWeight: FontWeight.normal,
                      ),
                      const SizedBox(height: 2),
                      CustomAppText(
                        text: "Tags: $tag Category: $cateogry",
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
