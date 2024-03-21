import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/model/categories.dart';
import 'package:food_app/model/meals.dart';
import 'package:food_app/provider/categories.dart';
import 'package:food_app/provider/meals.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  @override
  @override
  Widget build(BuildContext context) {
    // provider.getDataFromApi();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: Icon(Icons.menu),
        actions: [Icon(Icons.more_vert)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Today’s Meals",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Consumer<MealsProvider>(
                builder: (context, provider, child) {
                  return provider.isLoading
                      ? getMealsLoadingUI()
                      : provider.error.isNotEmpty
                          ? getMealsErrorUI(provider.error)
                          : getMealsBodyUI(provider.meals);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Popular Categories",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<CategoryProvide>(
                builder: (context, provider, child) {
                  return provider.isLoading
                      ? getCategoryLoading()
                      : provider.error.isNotEmpty
                          ? getCategoryErrorUI(provider.error)
                          : getCategoryBodyUI(provider.category);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getMealsLoadingUI() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.53,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              color: Colors.black,
              size: 60,
            ),
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getMealsErrorUI(String error) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.53,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          error,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  // Widget getBodyUI(allData meals) {
  //   return Column(
  //     children: [
  //       Text("Today's Special"),
  //       CarouselSlider.builder(
  //         itemCount: meals.meals.length,
  //         itemBuilder: (BuildContext context, int index, _) {
  //           return Column(
  //             children: [
  //               SizedBox(
  //                 height: 5,
  //               ),
  //               Container(
  //                   clipBehavior: Clip.hardEdge,
  //                   decoration:
  //                       BoxDecoration(borderRadius: BorderRadius.circular(15)),
  //                   child: Image.network(meals.meals[index]['strMealThumb'])),
  //             ],
  //           );
  //         },
  //         options: CarouselOptions(
  //           height: 400.0,
  //           enlargeCenterPage: true,
  //           autoPlay: true,
  //           aspectRatio: 16 / 9,
  //           autoPlayCurve: Curves.fastOutSlowIn,
  //           enableInfiniteScroll: true,
  //           autoPlayAnimationDuration: Duration(milliseconds: 800),
  //           viewportFraction: 0.8,
  //         ),
  //       ),
  //     ],
  //   );
  // }
//   Widget getBodyUI(allData meals) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
//           child: Text(
//             "Today's Meal",
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ),
//         SizedBox(height: 20),
//         Padding(
//           padding: const EdgeInsets.only(top: 25, bottom: 25),
//           child: CarouselSlider.builder(
//             itemCount: meals.meals.length,
//             itemBuilder: (BuildContext context, int index, _) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 300,
//                     width: 300,
//                     clipBehavior: Clip.hardEdge,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           meals.meals[index]['strMealThumb'],
//                         ),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     alignment: AlignmentDirectional.bottomCenter,
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 10, top: 10),
//                       child: Container(
//                           color: Colors.amber,
//                           height: 50,
//                           width: 200,
//                           child: Text(meals.meals[index]['strMeal'])),
//                     ),
//                   ),
//                 ],
//               );
//             },
//             options: CarouselOptions(
//               height: 400.0,
//               enlargeCenterPage: true,
//               autoPlay: true,
//               aspectRatio: 16 / 9,
//               autoPlayCurve: Curves.fastOutSlowIn,
//               enableInfiniteScroll: true,
//               autoPlayAnimationDuration: Duration(seconds: 1),
//               viewportFraction: 0.8,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
  Widget getMealsBodyUI(Meals meals) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.40,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.53,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        ),
        itemCount: meals.meals.length,
        itemBuilder: (context, index, realIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 191, 0),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(meals.meals[index]["strMealThumb"]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        meals.meals[index]["strMeal"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getCategoryLoading() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              color: Colors.black,
              size: 60,
            ),
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryErrorUI(String error) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          error,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Widget getCategoryBodyUI(Category category) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.19,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 255, 200, 62),
                        image: DecorationImage(
                          image: NetworkImage(
                              category.categories[index].strCategoryThumb),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        category.categories[index].strCategory,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
