import 'package:grocerygo/utility/export.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: ListView.separated(
            padding: const EdgeInsets.all(15),
            itemBuilder: ((context, index) => SizedBox(
                  width: context.screenWidth,
                  height: 40,
                  child: Text("Haha${index + 1}"),
                )),
            separatorBuilder: ((context, index) => const SizedBox(
                  height: 12,
                )),
            itemCount: 50));
  }
}
