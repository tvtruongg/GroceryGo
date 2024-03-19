import 'package:grocerygo/utility/export.dart';

class FilterRow extends StatelessWidget {
  final Map fObj;
  final bool isSelect;
  final VoidCallback onPressed;
  const FilterRow(
      {super.key,
      required this.fObj,
      required this.isSelect,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          Image.asset(
           isSelect ? icCheckboxColor :  icCheckbox,
            width: 25,
            height: 25,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              fObj["name"],
              style: TextStyle(
                  color: isSelect ? primary : primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]),
      ),
    );
  }
}
