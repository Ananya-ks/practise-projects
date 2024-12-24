import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/blocs/home/home_bloc.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/pages/signup.dart';
import 'package:ecommerce_dearch_firebase/features/product/presentation/widgets/wrapper_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCWUKdIKjJBICIuSYFHBS5Gz2hcajqrkvA",
            authDomain: "e-commerce-c4b0a.firebaseapp.com",
            projectId: "e-commerce-c4b0a",
            storageBucket: "e-commerce-c4b0a.firebasestorage.app",
            messagingSenderId: "938572410570",
            appId: "1:938572410570:web:574c188720132fd7eece33",
            measurementId: "G-S2E1ZZ66GG"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeBloc()..add(HomePageInitialEvent())),
        BlocProvider(
            create: (context) => AuthBloc()..add(AuthUserGoogleCheckEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: LandingPage(),
        initialRoute: '/',
        routes: {
          '/': (context) => const WrapperAuth(),
          '/signup': (context) => SignUp(),
        },
      ),
    );
  }
}
