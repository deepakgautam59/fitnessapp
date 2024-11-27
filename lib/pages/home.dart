import 'package:flutter/material.dart';
import 'package:fitness/models/category_model.dart';
import 'package:fitness/models/diet_model.dart';
import 'package:fitness/models/popular_model.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg

class HomePage extends StatelessWidget {
 HomePage({super.key});
 List<DietModel> diets = [];
 List<CategoryModel> categories = [];
 List<PopularDietsModel> popularDiets = [];


 void _getInitialInfo() {
   categories = CategoryModel.getCategories();
   diets = DietModel.getDiets();
   popularDiets = PopularDietsModel.getPopularDiets();

 }
  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(

        children: [
          _searchField(),
          SizedBox(height: 40,),
          _categoriesSection(),
          SizedBox(height: 40,),
          _dietSection(),
          SizedBox(height: 40,),
          _popularSection()

        ],
      ),
    );
  }

  Column _popularSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Popular',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 15,),
            ListView.separated(
              itemCount: popularDiets.length,
              shrinkWrap: true,
              separatorBuilder: (context,index) => const SizedBox(height: 25,),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              itemBuilder: (context,index){
                  return Container(
                    height: 100,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            popularDiets[index].iconPath,
                          height: 65,
                            width: 65,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text(
                              popularDiets[index].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:20),
                              child: Center(
                                child: Text(
                                  popularDiets[index].level + ' | ' + popularDiets[index].duration + ' | ' + popularDiets[index].calorie,
                                  style: TextStyle(
                                    color: Color(0xff7B6F72),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){

                          },
                            child: Padding(
                              padding: const EdgeInsets.only(left:15),
                              child: SvgPicture.asset(
                                'assets/icons/button.svg',
                                width: 20,
                                height: 20,
                              ),
                            )
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color:popularDiets[index].boxIsSelected ?
                          Colors.white : Colors.transparent,
                          offset: Offset(0, 10),
                          blurRadius: 40,
                          spreadRadius: 0,
                        )
                      ]
                    ),

                  );
              },
            )
          ],
        );
  }

  Column _dietSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20),
              child: Text(
                'Recommendation\nFor Diet',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),

              ),
            ),
            SizedBox(height: 15,),
            Container(
              height: 240,
              child: ListView.separated(
                  itemBuilder: (context,index) {
                    return Container(
                      width: 210,
                      decoration: BoxDecoration(
                        color: diets[index].boxColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(diets[index].iconPath),
                          Text(
                            diets[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16
                            ),
                          ),
                          Text(
                            diets[index].level + ' | ' + diets[index].duration + ' | ' + diets[index].calorie,
                            style: TextStyle(
                              color: Color(0xff7B6F72),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),

                          ),
                          Container(
                            height: 45,
                            width: 130,
                            child: Center(
                              child: Text(
                                'View',
                                style: TextStyle(
                                  color: diets[index].viewIsSelected ? Colors.white : Colors.purpleAccent,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  diets[index].viewIsSelected ? Color(0xff9DCEFF) : Colors.transparent,
                                  diets[index].viewIsSelected ? Color(0xff92A3FD) : Colors.transparent,

                                ]
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 25,),
                  itemCount: diets.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20
                ),
              ),
            )
          ],
        );
  }

  Column _categoriesSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Category',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height: 120,
              child: ListView.separated(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20
                ),
                separatorBuilder: (context, index) => SizedBox(width: 25,),
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: categories[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(categories[index].iconpath),
                          ),
                        ),
                        Text(
                          categories[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
              },
              ),
            )

          ],
        );
  }

  Container _searchField() {
    return Container(
          margin: const EdgeInsets.only(top:40,left: 20,right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff1D1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0
              )
            ]
          ),
          child:  TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(15),
                hintText: 'Search Here..',
                hintStyle: TextStyle(
                  color: Color(0xffDDDADA),
                  fontSize: 14
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset('assets/icons/search.svg'),
                ),
                suffixIcon: Container(
                  width: 80,
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        VerticalDivider(
                          color: Colors.black,
                          indent: 10,
                          endIndent: 10,
                          thickness: 0.1,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset('assets/icons/filter.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
              )

            ),
          ),

        );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'BreakFast',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          // Add your action here
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [ // Add the missing comma above
        GestureDetector(
          onTap: () {
            // Add your action here
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 30,
              width: 30,
            ),
          ),
        ),
      ],
    );
  }
}
