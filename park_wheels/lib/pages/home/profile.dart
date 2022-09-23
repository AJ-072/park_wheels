import 'package:flutter/material.dart';

import '../../main.dart';
import '../../service/auth.dart';
import '../../widgets/common/loading.dart';
import '../auth/sign_in.dart';

class Profile extends StatefulWidget {
  static String name = 'Profile';

  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final Auth auth = getIt<Auth>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          'assets/background/profile.jpeg',
          fit: BoxFit.fitHeight,
          height: size.height,
        ),
        Positioned(
          top: 120,
          left: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                auth.client?.name ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white70),
              ),
              Text(
                auth.client?.email ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              )
            ],
          ),
        ),
        Positioned(
          top: 190,
          right: 40,
          child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey),
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/icons/profile/profile.png')),
        ),
        Positioned(
          top: size.height / 2.3,
          bottom: 0,
          width: size.width,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: size.width / 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Text("data"),
                info(
                    icon: 'assets/icons/profile/email.png',
                    label: "Email",
                    value: auth.client?.email ?? ""),
                info(
                    icon: 'assets/icons/profile/phone.png',
                    label: "Phone",
                    value: auth.client?.phone??""),
                // info(icon: 'assets/icons/home/profile.png', label: 'Password',trailing: Icon(Icons.arrow_forward_ios)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset('assets/icons/profile/lock.png'),
                    ),
                    title: const Text(
                      'Password',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: Colors.blue[300]),
                  child: ListTile(
                    title: const Text(
                      'Log Out',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    trailing: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 18,
                    ),
                    onTap: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Text("Are You Sure?"),
                              actions: [
                                TextButton(
                                    onPressed: (){
                                      setState(()=>isLoading = true);
                                      auth.signOut().then((value) {
                                        setState(()=>isLoading = false);
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>SignIn()));
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Yes")),
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("No"))
                              ],
                            )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: 40,
            right: 10,
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white70,
              ),
              onPressed: () {},
            )),
        if (isLoading) const FullPageLoadingBar()
      ],
    );
  }

  Widget info(
      {required String icon,
      required String label,
      required String value,
      Widget? trailing}) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Image.asset(icon),
      ),
      title: Text(
        label,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[600]),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 18, color: Colors.grey),
      ),
      trailing: trailing,
    );
  }
}
