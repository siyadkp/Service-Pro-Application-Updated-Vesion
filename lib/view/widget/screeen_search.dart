import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/search/search_provider.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/core/naming.dart';
import 'package:service_manager/view/customer_view.dart/widget/customer_view_singlewidget.dart';
import 'package:service_manager/view/widget/search_bar_widget.dart';
import '../../controller/provider/search/const_search_objects.dart';
import '../service_calls/widget/service_call_view_single_widget.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch(
      {super.key,
      required this.collectionOfDatas,
      required this.collectionOfDatasKeys,
      required this.screenName});
  final Map<String, QueryDocumentSnapshot> collectionOfDatas;
  final List<String> collectionOfDatasKeys;
  final String screenName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: KColors.clrDarkBlue,
                  size: 35,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 25),
              child: SearchBarWidget(
                  keyValues: collectionOfDatasKeys,
                  screenName: screenName,
                  searchingDatas: collectionOfDatas),
            ),
            const SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 20, left: 8),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Consumer<TrieNotifier>(
              builder: (context, trieNotifier, _) {
                if (screenName == allScreenNames[8]) {
                  if (serviceCallViewScreenSearchNotifierObject
                      .collectionOfDatas.isEmpty) {
                    return const Center(
                        child: Text(
                      'No matching results found',
                      style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    ));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.only(left: 10, right: 12),
                          itemBuilder: (context, index) {
                            return ServicallViewSingleWidget(
                              serviceCallData:
                                  serviceCallViewScreenSearchNotifierObject
                                          .collectionOfDatas[
                                      serviceCallViewScreenSearchNotifierObject
                                          .collectionOfDatsKeys[index]],
                            );
                          },
                          itemCount: serviceCallViewScreenSearchNotifierObject
                              .collectionOfDatas.length),
                    );
                  }
                } else if (screenName == allScreenNames[7]) {
                  if (customerViewScreenSearchNotifierObject
                      .collectionOfDatas.isEmpty) {
                    return const Center(
                        child: Text(
                      'No matching results found',
                      style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                    ));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return CustomerViewSingleWidget(
                                customerData:
                                    customerViewScreenSearchNotifierObject
                                            .collectionOfDatas[
                                        customerViewScreenSearchNotifierObject
                                            .collectionOfDatsKeys[index]]);
                          },
                          itemCount: customerViewScreenSearchNotifierObject
                              .collectionOfDatas.length),
                    );
                  }
                }
                return const Text('');
              },
            )
          ],
        ),
      ),
    );
  }
}
