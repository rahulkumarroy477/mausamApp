// import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mausam_app/worker/worker.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  final Map<String, dynamic> data;
  const Home({Key? key, required this.data}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool load = false;
  final TextEditingController _textFieldController = TextEditingController();
  Map<String, dynamic> newData = {};
  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> updateData(Map<String, dynamic> newData) async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      widget.data.addAll(newData);
    });
  }

  overLay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return Container(
        color: const Color.fromRGBO(0, 0, 255, 0.2),
        child: const Center(
          child: SpinKitCircle(
            color: Colors.white54,
            size: 100.0,
          ),
        ),
      );
    });
    overlayState.insert(overlayEntry);
    load = true;
    print(_textFieldController.text);
    Worker x = Worker(_textFieldController.text);
    // print(_textFieldController.text.runtimeType);
    await x.getData();
    updateData(x.data);
    // newData = x.data;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.purple,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.2, 0.7],
              colors: [
                Colors.blue,
                Colors.purple,
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: screenWidth,
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onTap: () {
                        overLay(context);
                      },
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        controller: _textFieldController,
                        decoration: const InputDecoration(
                          hintText: "Search any city name ..",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  height: 0.15 * screenHeight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black45, spreadRadius: 1, blurRadius: 5)
                    ],
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.black45,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.network(
                          "https://openweathermap.org/img/wn/${widget.data['icon']}@2x.png",
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '${widget.data['desc']} ',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              Text(
                                'I am in ${widget.data['city']}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ])),
              Container(
                  height: 0.3 * screenHeight,
                  width: screenWidth,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black45, spreadRadius: 1, blurRadius: 5)
                    ],
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.black45,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          WeatherIcons.thermometer,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${widget.data['temp'].toStringAsFixed(1)}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 70),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'C',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 30),
                            ),
                          ],
                        ),
                      ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 0.4 * screenWidth,
                    height: 0.2 * screenHeight,
                    margin: const EdgeInsets.only(left: 30, top: 5),
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black45,
                            spreadRadius: 1,
                            blurRadius: 5)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          WeatherIcons.day_windy,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          // margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: <Widget>[
                              Text(
                                '${widget.data['airspeed']}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 40),
                              ),
                              const Text(
                                "Km/hr",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: 0.4 * screenWidth,
                      height: 0.2 * screenHeight,
                      margin: const EdgeInsets.only(right: 30, top: 5),
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black45,
                              spreadRadius: 1,
                              blurRadius: 5)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Icon(
                            WeatherIcons.humidity,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            // margin: const EdgeInsets.only(left: 20),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '${widget.data['humidity']}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 40),
                                ),
                                const Text(
                                  "Percent",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(children: const <Widget>[
                  Text(
                    'MADE BY RAHUL',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'DATA PROVIDED BY OPENWEATHER API',
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
