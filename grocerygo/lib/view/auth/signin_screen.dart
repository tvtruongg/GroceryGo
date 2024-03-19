import 'package:grocerygo/utility/export.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              imgSignup,
              width: context.screenWidth,
              fit: BoxFit.cover,
            ),
          ],
        ));
  }
}
