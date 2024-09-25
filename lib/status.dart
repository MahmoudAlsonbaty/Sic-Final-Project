import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sic_project/bloc/status_bloc.dart';
import 'package:sic_project/extras.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  int _selectedIndex = 1;
  final double _disBetweenBoxes = 15;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: AlignmentGeometry.lerp(
              Alignment.topCenter, Alignment.center, 0.5)!,
          colors: [
            MyHexColor.fromHex("0C1821"),
            MyHexColor.fromHex("324A5F"),
            MyHexColor.fromHex("000000"),
          ],
          stops: const [0.0, 0.2, 0.6],
          radius: 3,
        ),
      ),
      child: Stack(children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: BlocConsumer<StatusBloc, StatusState>(
              listener: (context, state) {
                if (state is StatusUpdate) {
                  print("Wind Speed: ${state.windSpeed}");
                  print("Head Lights: ${state.headLights}");
                  print("Temperature: ${state.temperature}");
                  print("Battery Temperature: ${state.mq}");
                  print("Fan Speed: ${state.rainData}");
                  print("Air Quality: ${state.airQuality}");
                  print("Humidity: ${state.Humidity}");
                  print("UV: ${state.uv}");
                }
              },
              builder: (context, state) {
                switch (state) {
                  case StatusInitial():
                    // TODO: Handle this case.
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 50),
                          //! STATUS TEXT
                          Expanded(
                            child: Align(
                              alignment: FractionalOffset.topCenter,
                              child: Text(
                                'Status',
                                style: GoogleFonts.ibmPlexSans(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: MyHexColor.fromHex("D9D9D9"),
                                    shadows: [
                                      const Shadow(
                                        color: Colors
                                            .black, // Choose the color of the shadow
                                        blurRadius:
                                            20.0, // Adjust the blur radius for the shadow effect
                                        offset: Offset(0.0,
                                            5.0), // Set the horizontal and vertical offset for the shadow
                                      ),
                                    ]),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),
                          const CircularProgressIndicator(),
                          Expanded(
                            child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Image.asset(
                                "assets/front_cr.png",
                              ),
                            ),
                          )
                        ]);
                  case StatusUpdate():
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 50),
                        //! STATUS TEXT
                        Text(
                          'Status',
                          style: GoogleFonts.ibmPlexSans(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: MyHexColor.fromHex("D9D9D9"),
                              shadows: [
                                const Shadow(
                                  color: Colors
                                      .black, // Choose the color of the shadow
                                  blurRadius:
                                      20.0, // Adjust the blur radius for the shadow effect
                                  offset: Offset(0.0,
                                      5.0), // Set the horizontal and vertical offset for the shadow
                                ),
                              ]),
                        ),
                        SizedBox(height: 10),
                        SizedBox(height: _disBetweenBoxes),
                        //! FIRST ROW === WIND SPEED AND LIGHTS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.020,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyHexColor.fromHex("EFEFEF"),
                                    width: 1),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(150, 239, 239, 239),
                                    Color.fromARGB(20, 239, 239, 239),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Flexible(
                                    flex: 1,
                                    child: Icon(
                                      Icons.air,
                                      size: 40,
                                      color: MyHexColor.fromHex("E8EAED"),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    flex: 10,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Wind Speed:',
                                            style: GoogleFonts.ibmPlexSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyHexColor.fromHex(
                                                    "D9D9D9"),
                                                shadows: [
                                                  const Shadow(
                                                    color: Colors
                                                        .black, // Choose the color of the shadow
                                                    blurRadius:
                                                        10.0, // Adjust the blur radius for the shadow effect
                                                    offset: Offset(0.0,
                                                        3.0), // Set the horizontal and vertical offset for the shadow
                                                  ),
                                                ]),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "${state.windSpeed.toString()} km/h",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.ibmPlexSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: MyHexColor.fromHex(
                                                      "D9D9D9"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyHexColor.fromHex("EFEFEF"),
                                    width: 1),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(150, 239, 239, 239),
                                    Color.fromARGB(20, 239, 239, 239),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Flexible(
                                    flex: 1,
                                    child: Icon(
                                      Icons.highlight,
                                      size: 40,
                                      color: MyHexColor.fromHex("E8EAED"),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    flex: 10,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'HEAD LIGHT:',
                                            style: GoogleFonts.ibmPlexSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyHexColor.fromHex(
                                                    "D9D9D9"),
                                                shadows: [
                                                  const Shadow(
                                                    color: Colors
                                                        .black, // Choose the color of the shadow
                                                    blurRadius:
                                                        10.0, // Adjust the blur radius for the shadow effect
                                                    offset: Offset(0.0,
                                                        3.0), // Set the horizontal and vertical offset for the shadow
                                                  ),
                                                ]),
                                          ),
                                          Switch(
                                              value: state.headLights,
                                              activeColor:
                                                  MyHexColor.fromHex("CCC9DC"),
                                              inactiveThumbColor:
                                                  MyHexColor.fromHex("0C1821"),
                                              onChanged: (value) {
                                                context.read<StatusBloc>().add(
                                                    StatusUpdateFirebaseEvent(
                                                        headLights: value));
                                                context.read<StatusBloc>().add(
                                                    StatusDataChanged(
                                                        headLights: value));
                                              }),
                                          // Text(
                                          //   state.headLights.toString(),
                                          //   overflow: TextOverflow.ellipsis,
                                          //   style: GoogleFonts.ibmPlexSans(
                                          //     fontSize: 16,
                                          //     fontWeight: FontWeight.normal,
                                          //     color:
                                          //         MyHexColor.fromHex("D9D9D9"),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.020,
                            ),
                          ],
                        ),
                        SizedBox(height: _disBetweenBoxes),
                        //! SECOND ROW === TEMPERATURE AND BATTERY TEMP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.020,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyHexColor.fromHex("EFEFEF"),
                                    width: 1),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(150, 239, 239, 239),
                                    Color.fromARGB(20, 239, 239, 239),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Flexible(
                                    flex: 1,
                                    child: Icon(
                                      Icons.thermostat,
                                      size: 40,
                                      color: MyHexColor.fromHex("E8EAED"),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    flex: 10,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Temperature',
                                            style: GoogleFonts.ibmPlexSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyHexColor.fromHex(
                                                    "D9D9D9"),
                                                shadows: [
                                                  const Shadow(
                                                    color: Colors
                                                        .black, // Choose the color of the shadow
                                                    blurRadius:
                                                        10.0, // Adjust the blur radius for the shadow effect
                                                    offset: Offset(0.0,
                                                        3.0), // Set the horizontal and vertical offset for the shadow
                                                  ),
                                                ]),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "${state.temperature.toString()} °C",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.ibmPlexSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: MyHexColor.fromHex(
                                                      "D9D9D9"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyHexColor.fromHex("EFEFEF"),
                                    width: 1),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(150, 239, 239, 239),
                                    Color.fromARGB(20, 239, 239, 239),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Flexible(
                                    flex: 1,
                                    child: Icon(
                                      Icons.gas_meter,
                                      size: 40,
                                      color: MyHexColor.fromHex("E8EAED"),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    flex: 10,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Gas Sensor',
                                            style: GoogleFonts.ibmPlexSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyHexColor.fromHex(
                                                    "D9D9D9"),
                                                shadows: [
                                                  const Shadow(
                                                    color: Colors
                                                        .black, // Choose the color of the shadow
                                                    blurRadius:
                                                        10.0, // Adjust the blur radius for the shadow effect
                                                    offset: Offset(0.0,
                                                        3.0), // Set the horizontal and vertical offset for the shadow
                                                  ),
                                                ]),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                getSmokeStatus(state.mq),
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.ibmPlexSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: MyHexColor.fromHex(
                                                      "D9D9D9"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.020,
                            ),
                          ],
                        ),
                        SizedBox(height: _disBetweenBoxes),
                        //! THIRD ROW === RAIN AND AIR QUALITY
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.020,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyHexColor.fromHex("EFEFEF"),
                                    width: 1),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(150, 239, 239, 239),
                                    Color.fromARGB(20, 239, 239, 239),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Flexible(
                                    flex: 1,
                                    child: Icon(
                                      Icons.cloud,
                                      size: 40,
                                      color: MyHexColor.fromHex("E8EAED"),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    flex: 10,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Rain',
                                            style: GoogleFonts.ibmPlexSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyHexColor.fromHex(
                                                    "D9D9D9"),
                                                shadows: [
                                                  const Shadow(
                                                    color: Colors
                                                        .black, // Choose the color of the shadow
                                                    blurRadius:
                                                        10.0, // Adjust the blur radius for the shadow effect
                                                    offset: Offset(0.0,
                                                        3.0), // Set the horizontal and vertical offset for the shadow
                                                  ),
                                                ]),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                getRainStatus(state.rainData),
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.ibmPlexSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: MyHexColor.fromHex(
                                                      "D9D9D9"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyHexColor.fromHex("EFEFEF"),
                                    width: 1),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(150, 239, 239, 239),
                                    Color.fromARGB(20, 239, 239, 239),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Flexible(
                                      flex: 3,
                                      child: SvgPicture.asset(
                                        "assets/SVG/earth.svg",
                                        width: 40,
                                        height: 40,
                                        color: MyHexColor.fromHex("E8EAED"),
                                      )),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    flex: 10,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Air Quality',
                                            style: GoogleFonts.ibmPlexSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyHexColor.fromHex(
                                                    "D9D9D9"),
                                                shadows: [
                                                  const Shadow(
                                                    color: Colors
                                                        .black, // Choose the color of the shadow
                                                    blurRadius:
                                                        10.0, // Adjust the blur radius for the shadow effect
                                                    offset: Offset(0.0,
                                                        3.0), // Set the horizontal and vertical offset for the shadow
                                                  ),
                                                ]),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "${state.airQuality.toString()} mg/m3",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.ibmPlexSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: MyHexColor.fromHex(
                                                      "D9D9D9"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.020,
                            ),
                          ],
                        ),
                        SizedBox(height: _disBetweenBoxes),
                        //! FOURTH ROW === HUMIDITY AND UV RAYS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.020,
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyHexColor.fromHex("EFEFEF"),
                                    width: 1),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(150, 239, 239, 239),
                                    Color.fromARGB(20, 239, 239, 239),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Flexible(
                                      flex: 3,
                                      child: SvgPicture.asset(
                                        "assets/SVG/humidity.svg",
                                        width: 40,
                                        height: 40,
                                      )),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    flex: 10,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Humidity',
                                            style: GoogleFonts.ibmPlexSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyHexColor.fromHex(
                                                    "D9D9D9"),
                                                shadows: [
                                                  const Shadow(
                                                    color: Colors
                                                        .black, // Choose the color of the shadow
                                                    blurRadius:
                                                        10.0, // Adjust the blur radius for the shadow effect
                                                    offset: Offset(0.0,
                                                        3.0), // Set the horizontal and vertical offset for the shadow
                                                  ),
                                                ]),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                "${state.Humidity.toString()} %",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.ibmPlexSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: MyHexColor.fromHex(
                                                      "D9D9D9"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyHexColor.fromHex("EFEFEF"),
                                    width: 1),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(150, 239, 239, 239),
                                    Color.fromARGB(20, 239, 239, 239),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Flexible(
                                    flex: 1,
                                    child: Icon(
                                      Icons.sunny,
                                      size: 40,
                                      color: MyHexColor.fromHex("E8EAED"),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Flexible(
                                    flex: 10,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'UV Rays',
                                            style: GoogleFonts.ibmPlexSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyHexColor.fromHex(
                                                    "D9D9D9"),
                                                shadows: [
                                                  const Shadow(
                                                    color: Colors
                                                        .black, // Choose the color of the shadow
                                                    blurRadius:
                                                        10.0, // Adjust the blur radius for the shadow effect
                                                    offset: Offset(0.0,
                                                        3.0), // Set the horizontal and vertical offset for the shadow
                                                  ),
                                                ]),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                state.uv.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.ibmPlexSans(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: MyHexColor.fromHex(
                                                      "D9D9D9"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.020,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Image.asset(
                              "assets/front_cr.png",
                            ),
                          ),
                        )
                      ],
                    );
                }
              },
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            backgroundColor: MyHexColor.fromHex("0C1821"),
            currentIndex: _selectedIndex,
            onTap: (int index) => {
              setState(() {
                _selectedIndex = index;
                if (index == 1) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/status', (route) => false);
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                }
              })
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Overview',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: 'Status',
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

String getRainStatus(double rain) {
  if (rain >= 300) {
    return "Raining";
  } else {
    return "No Rain";
  }
}

String getSmokeStatus(int smoke) {
  if (smoke >= 150) {
    return "Smoke";
  } else {
    return "No Smoke";
  }
}
