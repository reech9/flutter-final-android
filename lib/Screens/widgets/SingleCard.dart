import 'package:flutter/material.dart';

import '../../utils/url.dart';

class SingleCard extends StatelessWidget {
  SingleCard(
      {Key? key,
      required this.id,
      required this.title,
      this.image,
      required this.price})
      : super(key: key);
  String title;
  String? image;
  String price;
  String id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("single-product", arguments: id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(2, 2), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            image == null || image == ""
                ? Image.asset(
                    "assets/images/logo.png",
                    height: 130,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    image!.contains("http://localhost")
                        ? baseUrl + image!.split("90/")[1]
                        : image.toString(),
                    height: 130,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title + "\n",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Rs $price",
                    maxLines: 1,
                    style: TextStyle(
                      color: Color(0xffDD8560),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SingleCardList extends StatelessWidget {
  SingleCardList(
      {Key? key,
      required this.id,
      required this.title,
      this.image,
      required this.price,
      this.quantity, required this.onPressed})
      : super(key: key);
  String title;
  String? image;
  String price;
  String? quantity;
  String id;
  Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("single-product", arguments: id);
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: Offset(2, 2), // Shadow position
              ),
            ],
          ),
          child: ListTile(
            leading: image == null || image == ""
                ? Image.asset(
                    "assets/images/logo.png",
                    width: 100,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    image!.contains("http://localhost")
                        ? baseUrl + image!.split("90/")[1]
                        : image.toString(),
                    width: 100,
                    fit: BoxFit.cover,
                  ),
            subtitle: Text( "Quantity : "+ (quantity == null ? 'N/A' : quantity.toString())),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title + "\n",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Rs $price",
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0xffDD8560),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: (){
                onPressed();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          )),
    );
  }
}
