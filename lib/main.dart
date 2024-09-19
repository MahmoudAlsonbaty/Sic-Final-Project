import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sic_project/bloc/overview_bloc.dart';
import 'package:sic_project/bloc/status_bloc.dart';
import 'package:sic_project/bloc/update_bloc.dart';
// import 'package:lottie/lottie.dart';
import 'package:sic_project/extras.dart';
import 'package:sic_project/firebase_options.dart';
import 'package:sic_project/status.dart';
import 'package:wave_blob/wave_blob.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => OverviewBloc()),
      BlocProvider(create: (context) => StatusBloc()),
      BlocProvider(create: (context) => UpdateBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sic Final Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomeScreen(),
        '/status': (context) => StatusScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int battery = 0;

  @override
  void initState() {
    battery =
        (context.read<OverviewBloc>().state as OverviewBatteryStatus).battery;
    super.initState();
  }

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
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    'Overview',
                    style: GoogleFonts.ibmPlexSans(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: MyHexColor.fromHex("D9D9D9"),
                        shadows: [
                          const Shadow(
                            color:
                                Colors.black, // Choose the color of the shadow
                            blurRadius:
                                20.0, // Adjust the blur radius for the shadow effect
                            offset: Offset(0.0,
                                5.0), // Set the horizontal and vertical offset for the shadow
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    //DON'T MAKE IT A CONST
                    child: BlocConsumer<UpdateBloc, UpdateState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return WaveBlob(
                          blobCount: 4,
                          amplitude: 8500,
                          scale: 10,
                          speed: 10,
                          centerCircle: false,
                          overCircle: false,
                          colors: const [
                            /// If you don't want use Gradient, set just one color
                            // MyHexColor.fromHex("0C1821"),
                            Color.fromARGB(60, 97, 97, 97),
                            Color.fromARGB(20, 41, 41, 41),
                          ],
                          child: Center(
                            child: BlocConsumer<OverviewBloc, OverviewState>(
                              listener: (context, state) {
                                battery =
                                    (state as OverviewBatteryStatus).battery;
                              },
                              builder: (context, state) {
                                return Text(
                                  "${battery}%",
                                  style: GoogleFonts.ibmPlexSans(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: MyHexColor.fromHex("b5b1b1"),
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
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  getOverviewMessage(Status.warning, context),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/top_cr_30.png",
                  )
                ],
              ),
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

enum Status { ok, warning, danger }

Widget getOverviewMessage(Status status, BuildContext context) {
  switch (status) {
    case Status.warning:
      return Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(color: MyHexColor.fromHex("FFD15B"), width: 1),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(179, 255, 209, 91),
              Color(0x19FFD15B),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black,
          //     blurRadius: 20,
          //     offset: const Offset(0, 10),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: Icon(
                Icons.warning,
                size: 40,
                color: MyHexColor.fromHex("FFD15B"),
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              flex: 3,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Warning:',
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: MyHexColor.fromHex("FFD15B"),
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
                    Text(
                      'Exccesive amount of UV rays',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: MyHexColor.fromHex("FFD15B"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    case Status.ok:
      return Text('Warning');
    case Status.danger:
      return Text('Danger');
  }
}
