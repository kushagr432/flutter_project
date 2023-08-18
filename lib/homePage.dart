// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'googleAPI.dart';
import 'dart:async';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  TextEditingController noteController = TextEditingController();

    void initState() {
      super.initState();
      noteController.addListener(() {
        setState(() {});
      });
    }

    void startLoading() {
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (GoogleAPI.loading == false) {
          setState(() {});
          timer.cancel();
        }
      });
    }

    void _addNote() {
      GoogleAPI().insert(noteController.text);
      noteController.clear();
    }


// void _deleteNote(){
//       GoogleAPI().deleteNote( );
// }
    @override
    Widget build(BuildContext context) {
      if (GoogleAPI.loading == true) {
        startLoading();
      }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'N O T E S',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu Icon',
          onPressed: () {},
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: GoogleAPI.numberOfNotes,
                  itemBuilder: (context, index) {


                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),

                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xffd7dede),
                              borderRadius: BorderRadius.circular(15)),
                          child:Row(
                            children: [
                              SizedBox(
                                width: 60,
                              ),
                           Center(

                                child: Text(
                                  GoogleAPI.currentNotes[index],
                                  style: const TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w400), textAlign: TextAlign.start,
                                ),
                              ),
                              // const SizedBox(
                              //   width: 12.0,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              //   child: Container(
                              //     color: Colors.grey,
                              //     height: 20.0,
                              //     width: 2.0,
                              //   ),
                              // ),
                              // GestureDetector(
                              //   // onTap: ,
                              //     child: Icon(Icons.delete_outline , color: Colors.black,)),

                        ],

                        ),
                        ),

                    );



                  })),
      GoogleAPI.loading ?
          Padding(
            padding: const EdgeInsets.only(bottom: 220),
            child: Lottie.asset("assets/lottie/99297-loading-files.json"),
          ) :
      Container(
      height: 0,
        width: 0,
      ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: noteController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.notes),
                  suffixIcon: noteController.text.isEmpty
                      ? const SizedBox(
                    height: 0,
                    width: 0,
                  )
                      : IconButton(
                      onPressed: () {
                        noteController.clear();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: GestureDetector(
              onTap: _addNote,
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade900),
                child: const Center(
                  child: Text(
                    'POST',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
