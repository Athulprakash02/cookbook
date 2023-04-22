import 'package:flutter/material.dart';

Widget viewCard() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
    child: Container(
      height: 200,
      
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage(
            'assets/images/pizza-386717__340.jpg',
            
          ),fit: BoxFit.fill),

          color: const Color.fromARGB(255, 5, 4, 2), 
          borderRadius: BorderRadius.circular(20)
          ),
          
      width: double.maxFinite,
      child: Stack(
        children: [

          
          Positioned(
            right: 15,
            top: 10,
            child: Container(
            width: 70,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 196, 192, 192)
            ),
          )),
          Positioned(
            right: 10,
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          ),
          Positioned(
            right: 40,
              child: InkWell(
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            onTap: () {
              
            },
          )),
           Positioned(
            bottom: 20,
            left: 30,
            child: Container(
              decoration: BoxDecoration(
                color:  const Color.fromARGB(255, 196, 192, 192),
                borderRadius: BorderRadius.circular(10)
              ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CHICKEN GOLDEN DELIGHT',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                  Row(
                    children: const [
                      Icon(Icons.watch_later_outlined, size: 16,),
                      SizedBox(width: 5,),
                      Text('35 mins'),
                    ],
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    ),
  );
}




Widget userCard() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
    child: Container(
      height: 200,
      
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage(
            'assets/images/pizza-386717__340.jpg',
            
          ),fit: BoxFit.fill),

          color: const Color.fromARGB(255, 5, 4, 2), 
          borderRadius: BorderRadius.circular(20)
          ),
          
      width: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:  const Color.fromARGB(255, 196, 192, 192),
                    borderRadius: BorderRadius.circular(10)
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('CHICKEN GOLDEN DELIGHT',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                      Row(
                        children: const [
                          Icon(Icons.watch_later_outlined, size: 16,),
                          SizedBox(width: 5,),
                          Text('35 mins'),
                        ],
                      )
                    ],
                  ),
                ),
          ),
          Container(
            decoration: BoxDecoration(
                    color:  const Color.fromARGB(255, 196, 192, 192),
                    borderRadius: BorderRadius.circular(30)
                  ),
            child: IconButton(onPressed: () {
              
            }, icon: Icon(Icons.favorite_outline,size: 25,)),
          )
              ],
            ))

          
          
        ],
      ),
    ),
  );
}
