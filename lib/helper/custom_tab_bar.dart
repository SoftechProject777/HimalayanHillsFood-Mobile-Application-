

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:eccomerce/Models/subcategory_model.dart';
import 'package:eccomerce/helper/custom_subcategorygrid.dart';
import 'package:eccomerce/provider/subcategory_provider.dart';

class Custom_Tab_Bar extends StatefulWidget {
  const Custom_Tab_Bar({
    super.key,
  });

  @override
  State<Custom_Tab_Bar> createState() => _Custom_Tab_BarState();
}

class _Custom_Tab_BarState extends State<Custom_Tab_Bar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    print(_tabController.animation);
    fetchSubCategory();
  }

  void fetchSubCategory() async {
    await Provider.of<SubcategoryProvider>(context, listen: false)
        .fetchSubCategory();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubcategoryProvider>(
      builder: (context, value, child) {
        SubcategoryModel subCategory = value.subcategories;

        if (subCategory.data == null || subCategory.data!.isEmpty) {
          return _buildShimmerEffect();
        }

        return Column(
          children: [
            TabBar(
              labelColor: Colors.amber,
              indicatorColor: Colors.amber,
              controller: _tabController,
              tabs: [
                for (int i = 0; i < 3; i++)
                  Tab(
                    child: Text(
                      subCategory.data != null && i < subCategory.data!.length
                          ? subCategory.data![i].title ?? 'No Title'
                          : 'Loading...',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.6,
              width: MediaQuery.sizeOf(context).width,
              child: TabBarView(
                controller: _tabController,
                children: [
                  for (int i = 0; i < 3; i++)
                    Custom_SubcategoryGrid(
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width * 0.1,
                      crossAxisCount: 2,
                      childAspectRatio: 6 / 10.5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 8,
                      axisDirection: Axis.vertical,
                      datas: subCategory.data != null &&
                              i < subCategory.data!.length
                          ? subCategory.data![i]
                          : Data(),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Column(
      children: [
        TabBar(
          labelColor: Colors.amber,
          indicatorColor: Colors.amber,
          controller: _tabController,
          tabs: List.generate(3, (index) => Tab(child: _shimmerText())),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.6,
          width: MediaQuery.sizeOf(context).width,
          child: _shimmerGrid(),
        ),
      ],
    );
  }

  Widget _shimmerText() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 20,
        width: 60,
        color: Colors.white,
      ),
    );
  }

  Widget _shimmerGrid() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 8,
          childAspectRatio: 6 / 10.5,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
