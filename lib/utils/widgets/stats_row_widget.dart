import 'package:flutter/material.dart';

class StatsRowWidget extends StatelessWidget {
  const StatsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            buildStat(context, '120', 'Words Learnt'),
            buildDivider(context),
            buildStat(context, '112', 'High Score'),
            buildDivider(context),
            buildStat(context, '12', 'Followers')
        ],
      ),
    );
  }

  Widget buildStat(BuildContext context, String value, String type){
    return MaterialButton(
      onPressed: (){},
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(value,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
          const SizedBox(height: 2,),
          Text(type, style: const TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
  Widget buildDivider(BuildContext context)=> const SizedBox (height: 24 ,child:  Divider(color: Colors.green,)); 
}