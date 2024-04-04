import 'dart:math';

import 'package:budget_app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //align the settings to the right 
              children: [
                Row(
                  
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow[700]
                          ),
                        ),
                      Icon(
                        CupertinoIcons.person_fill,
                        color: Colors.yellow[800]
                        )
                      ],
                    ),
                  const SizedBox(width: 8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.outline
                        ),
                        ),
                      Text("Thierry Jones",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground
                        ),
                      ),
                    ],
                  ),
                  ],
                ),
                IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.settings))
              ],
            ),
            const SizedBox(height: 20,),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ],
                  transform: const GradientRotation( pi /4),
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Colors.grey.shade300,
                    offset: const Offset(5,5)

                  )
                ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      const Text("Total Balance",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                      ),
                      const SizedBox(height:10),
                      const Text('\$ 1000.00',
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          color: Colors.white
                        ),
                      ),
                      // const SizedBox(height: 24,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white30,
                                    shape: BoxShape.circle
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      CupertinoIcons.arrow_up,
                                      size: 12,
                                      color: Colors.greenAccent,
                                      )  
                                  ,),
                                ),
                                const SizedBox(width: 8),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Income',
                                        style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                      ),
                                    ),
                                    Text('\$ 2500.00',
                                        style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white
                                      ),
                                    )
                                  ],
                                )
                              ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: Colors.white30,
                                      shape: BoxShape.circle
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        CupertinoIcons.arrow_down,
                                        size: 12,
                                        color: Colors.redAccent,
                                        )  
                                    ,),
                                  ),
                                  const SizedBox(width: 8),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Expenses',
                                          style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white
                                        ),
                                      ),
                                      Text('\$ 1000.00',
                                          style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white
                                        ),
                                      )
                                    ],
                                  )
                                ],
                                ),
                          ],
                        ),
                      )
                ],),
              ),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transactions',
                      style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground
                    ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                  child: Text(
                      'View All',
                      style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.outline
                    ),
                  )
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                  itemCount: myTransactions.length,
                  itemBuilder: (context, int i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: myTransactions[i]['color'],
                                          shape: BoxShape.circle
                                        ),
                                      ),
                                      myTransactions[i]['icon']
                                      
                                    ],
                                  ),
                                  const SizedBox(width: 12,),
                                  Text(
                                    myTransactions[i]['name'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.onBackground
                                    ),
                                  ),
                                  
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        myTransactions[i]['TotalAmount'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.onBackground
                                        ),
                                      ),
                                      Text(
                                        myTransactions[i]['date'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.outline
                                        ),
                                      ),
                                    ],
                                  )
                            ],
                          ),
                        )
                      ),
                    );
                  }
                  
                  ),
              )
          ],
        ),
      ),
    );
  }
}