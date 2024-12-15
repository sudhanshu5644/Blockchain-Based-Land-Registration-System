import 'package:flutter/material.dart';
import '../constant/utils.dart';

Widget landWid(isverified, area, address, price, isForSell, makeforSellFun) =>
    Container(
      padding: const EdgeInsets.all(15),
      width: 400,
      height: 400,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 400,
            color: Colors.lightGreenAccent,
            child: Image.asset(
              'assets/landimg.jpg',
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            isverified ? 'Verified Land' : 'Yet to be Verified',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            area + ' Sq.Ft',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Address: ' + address,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Price: Rs' + price,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isForSell
                  ? MaterialButton(
                      color: Colors.red,
                      onPressed: null,
                      child: const Text('On Sale'),
                    )
                  : MaterialButton(
                      color: Colors.red,
                      onPressed: isverified ? makeforSellFun : null,
                      child: const Text('Make it for Sell'),
                    ),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {},
                child: const Text('View Details'),
              )
            ],
          )
        ],
      ),
    );
Widget landWid2(isverified, area, address, price, isMyLand, isForSell,
        sendRequestFun, viewDetailsFun) =>
    Container(
      padding: const EdgeInsets.all(15),
      width: 400,
      height: 400,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white10,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
          color: Colors.white10,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 400,
            color: Colors.lightGreen,
            child: Image.asset(
              'assets/landimg.jpg',
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            isverified ? 'Verified Land' : 'Yet to be Verified',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Area: ' + area + ' Sq.Ft',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Address: ' + address,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Price: Rs ' + price,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isMyLand
                  ? MaterialButton(
                      color: Colors.red,
                      onPressed: null,
                      child: const Text('Send Request To Buy'),
                    )
                  : MaterialButton(
                      color: Colors.red,
                      onPressed: isForSell ? sendRequestFun : null,
                      child: isForSell
                          ? Text('Send Request To Buy')
                          : Text('Not for sale yet'),
                    ),
              MaterialButton(
                color: Colors.blue,
                onPressed: viewDetailsFun,
                child: const Text('View Details'),
              )
            ],
          )
        ],
      ),
    );

Widget landWid3(
        owneraddress, area, address, price, propertyPID, surveyNumber, docu) =>
    Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: width,
      height: 400,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
          color: Colors.white10,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Land Information",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 13,
          ),
          const Text(
            'Verified Land',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(
            height: 13,
          ),
          textCustom("Land Owner(Seller) Address: ", ''),
          textCustom("", owneraddress),
          const SizedBox(
            height: 13,
          ),
          textCustom("Land Address: ", ''),
          textCustom('', address),
          const SizedBox(
            height: 13,
          ),
          textCustom("Area: ", area + ' Sqft'),
          const SizedBox(
            height: 13,
          ),
          textCustom("Property ID: ", propertyPID),
          const SizedBox(
            height: 13,
          ),
          textCustom("Contact Details: ", surveyNumber),
          const SizedBox(
            height: 13,
          ),
          textCustom("Price: Rs ", price),
          const SizedBox(
            height: 13,
          ),
          TextButton(
            onPressed: () {
              launchUrl(docu.toString());
            },
            child: const Text(
              'View Document',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );

Widget textCustom(text1, text2) => Row(
      children: [
        Text(
          text1,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          text2,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
