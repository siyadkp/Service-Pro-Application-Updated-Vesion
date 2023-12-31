import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import 'package:service_manager/controller/provider/billing_provider/billing_provider.dart';
import '../../../controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import '../../../core/colors.dart';
import '../../../core/naming.dart';

class DropdownTextFormField extends StatefulWidget {
  const DropdownTextFormField(
      {super.key,
      required this.screenName,
      required this.suggestion,
      required this.text});

  final String screenName;
  final String text;
  final List<String> suggestion;

  @override
  State<DropdownTextFormField> createState() => _DropdownTextFormFieldState();
}

class _DropdownTextFormFieldState extends State<DropdownTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        Container(
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: KColors.clrGrey),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Autocomplete(
              fieldViewBuilder: (BuildContext context, textEditingController,
                  FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                return TextFormField(
                  onChanged: (value) {
                    if (widget.screenName == allScreenNames[2]) {
                      Provider.of<AddNewServiceCallNotifier>(context,
                              listen: false)
                          .customer
                          .text = value;
                    } else {
                      Provider.of<BillingNotifier>(context, listen: false)
                          .customer
                          .text = value;
                      Provider.of<BillingNotifier>(context, listen: false)
                          .validation(context);
                    }
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.text.isNotEmpty
                          ? 'Please enter ${widget.text} Name'
                          : 'Please enter Customer Name'),
                  controller: textEditingController,
                  focusNode: fieldFocusNode,
                );
              },
              optionsBuilder: (
                TextEditingValue textEditingValue,
              ) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                } else {
                  List<String> matches = <String>[];
                  matches.addAll(widget.suggestion);

                  matches.retainWhere((s) {
                    return s
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                  return matches;
                }
              },
              onSelected: (String selection) {
                if (widget.screenName == allScreenNames[2]) {
                  Provider.of<AddNewServiceCallNotifier>(context, listen: false)
                      .customer
                      .text = selection;
                } else if (widget.screenName == allScreenNames[9]) {
                  Provider.of<BillingNotifier>(context, listen: false)
                      .customer
                      .text = selection;
                  Provider.of<BillingNotifier>(context, listen: false)
                      .cusomerDataLoading(selection, context);
                } else {
                  AddProductToBillNotif addProductToBillNotifObj =
                      Provider.of<AddProductToBillNotif>(context,
                          listen: false);
                  addProductToBillNotifObj.product.text = selection;
                  addProductToBillNotifObj.productDataLoading(
                      selection, context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
