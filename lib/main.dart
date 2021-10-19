import 'package:flutter/material.dart';
import 'package:flagsmith/flagsmith.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sign in'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final flagsmithClient = FlagsmithClient(
    apiKey: '6VNG3JcwJd84vVaCU8L6oL',
    seeds: [
      Flag.seed('feature', enabled: true),
    ],
  );

  Future<List<Widget>> signInOptions() async {
    await flagsmithClient.getFeatureFlags(reload: true);
    List<Widget> options = <Widget>[];
    bool appleSignIn = await flagsmithClient.hasFeatureFlag("apple_sign_in");
    bool googleSignIn = await flagsmithClient.hasFeatureFlag("google_sign_in");
    bool facebookSignIn =
        await flagsmithClient.hasFeatureFlag("facebook_sign_in");
    if (appleSignIn) {
      options.add(SignInButton(
        Buttons.Apple,
        onPressed: () {},
      ));
    }
    if (googleSignIn) {
      options.add(SignInButton(
        Buttons.GoogleDark,
        onPressed: () {},
      ));
    }
    if (facebookSignIn) {
      options.add(SignInButton(
        Buttons.FacebookNew,
        onPressed: () {},
      ));
    }
    return options;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
            future: signInOptions(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: snapshot.data ?? [const Text("Loading")],
              );
            }),
      ),
    );
  }
}
