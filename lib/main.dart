import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meet_doctor_training/provider/authentication.dart';
import 'package:meet_doctor_training/provider/profile_provider.dart';
import 'package:meet_doctor_training/provider/sign_up_provider.dart';
import 'package:meet_doctor_training/screens/home/doctor/doctor_profile.dart';
import 'package:meet_doctor_training/screens/home/doctor/patient_list.dart';
import 'package:meet_doctor_training/screens/home/patient/categorized_doctor_list.dart';
import 'package:meet_doctor_training/screens/home/patient/doctor_details.dart';
import 'package:meet_doctor_training/screens/home/patient/home.dart';
import 'package:meet_doctor_training/screens/home/patient/profile.dart';
import 'package:meet_doctor_training/screens/home/wait_for_data.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/doctor_or_patient.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/password_reset.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/sign_in.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/sign_up.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/sign_up_doctor.dart';
import 'package:meet_doctor_training/screens/sign_in_sign_up/varification.dart';
import 'package:provider/provider.dart';
import 'constant/constant.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(414, 837),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meet Doctor',
          theme: ThemeData(
            textTheme: GoogleFonts.rubikTextTheme(
              Theme.of(context).textTheme,
            ),
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Exception(
                  massage: "Error",
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return const MiddleOfHomeAndSignIn();
              }
              return const Exception(
                massage: "Loading",
              );
            },
          ),
          routes: {
            "SignIn": (ctx) => const SignIn(),
            "DoctorOrPatient": (ctx) => const DoctorOrPatient(),
            "SignUp": (ctx) => const SignUp(),
            "SignUpDoctor":(ctx) => const SignUpDoctor(),
            "PasswordReset": (ctx) => const PasswordReset(),
            "MiddleOfHomeAndSignIn": (ctx) => const MiddleOfHomeAndSignIn(),
            "Profile": (ctx) => const Profile(),
            "DoctorProfile": (ctx) => const DoctorProfile(),
            "CategorizedDoctorList": (ctx) => const CategorizedDoctorList(),
            "PatientList": (ctx) => const PatientList(),
            "DoctorDetails": (ctx) => const DoctorDetails(),
            "Home": (ctx) => const Home(),
          },
        ),
      ),
    );
  }
}

class Exception extends StatelessWidget {
  const Exception({Key? key, required this.massage}) : super(key: key);
  final String massage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: massage == "Error"
            ? const Text("An error occur")
            : const CircularProgressIndicator(backgroundColor: Colors.red,),
      ),
    );
  }
}

class MiddleOfHomeAndSignIn extends StatefulWidget {
  const MiddleOfHomeAndSignIn({Key? key}) : super(key: key);

  @override
  _MiddleOfHomeAndSignInState createState() => _MiddleOfHomeAndSignInState();
}

class _MiddleOfHomeAndSignInState extends State<MiddleOfHomeAndSignIn> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Provider.of<Authentication>(context, listen: false)
          .authStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black87),
          );
        }

        if (snapshot.data != null && snapshot.data!.emailVerified) {
          return const WaitForData();
        }
        return snapshot.data == null
            ? const SignIn()
            : const VerificationAndHomeScreen();
      },
    );
  }
}