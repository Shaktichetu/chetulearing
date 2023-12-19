import 'dart:convert';
//import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51ONaA1SAOUalysFgPppRBVnh6NUl0g4s1FEX8Mdkej7LTcCDe730TStsHmysWRO1UAn7rYGfs33R8heONRnK3Il700VrlzudGu';
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';
   await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String,dynamic>? paymentIntent;
     
   Future<void>  makePayment() async{
     try {
       paymentIntent = await createPaymentIntent();
       var gPay = const PaymentSheetGooglePay(merchantCountryCode: "US",
       currencyCode: "US",
       testEnv: true
       );
       await Stripe.instance.initPaymentSheet(paymentSheetParameters:  SetupPaymentSheetParameters(
    //    setupIntentClientSecret: "sk_test_51ONaA1SAOUalysFg1bqRoeU92qVqWshgJYkUVyis16lzmwdU8IbVlIu8s3pHntwT2ZaNqX58kd9Fs5abPZ63zD9p00ldvCP2xh",
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        customFlow: true,
        style: ThemeMode.dark,

        merchantDisplayName: "chetu",
        googlePay: gPay
       )).then((value) => print("value 1 - $value"));
       displayPaymentSheet();
     } catch (e) {
       print(e);
     }
  }
  
  void displayPaymentSheet() async{
      try {
     await Stripe.instance.presentPaymentSheet().then((value) {
       print('payment intent${paymentIntent!['id']}');
        print(
            'payment intent${paymentIntent!['client_secret']}');
        print('payment intent${paymentIntent!['amount']}');
        print('payment intent$paymentIntent');
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
     });    
    
      debugPrint("paid");
      } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    }  on Exception catch (e) {
       debugPrint("${e}failed");   
      }
  }

     createPaymentIntent() async{
          try{
        Map<String,dynamic> body = {
           "amount":"1000",
           "currency":"USD",
           "payment_method":"pm_card_visa",
            'payment_method_types[]': 'card',
        }; 
        print(body);
        http.Response response = await http.post(Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {"Authorization":'Bearer ' 'sk_test_51ONaA1SAOUalysFg1bqRoeU92qVqWshgJYkUVyis16lzmwdU8IbVlIu8s3pHntwT2ZaNqX58kd9Fs5abPZ63zD9p00ldvCP2xh',
        'Content-Type': 'application/x-www-form-urlencoded',
        });
        print('Create Intent reponse ===> ${response.body.toString()}');
         return jsonDecode(response.body);
          }catch(e){
            throw Exception(e.toString());
          }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: () async
       { await makePayment();}, child: const Text("pay") ),),
    );
  }
}

