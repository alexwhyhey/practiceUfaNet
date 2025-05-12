import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_baibakov/auth/auth.dart';
import 'models.dart' as models;
import 'settings.dart' as settings;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 26, 75)),
        useMaterial3: true,
      ),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => AuthPage(),
        '/home': (context) => MyHomePage(title: "hui"),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<models.Offer>> futureOffers;
  late Future<List<models.Category>> futureCategory;

  @override
  void initState() {
    super.initState();

    futureOffers = models.ApiService.fetchOffers();
    futureCategory = models.ApiService.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 26, 75),
          title: Text(widget.title),
          foregroundColor: Color.fromARGB(255, 215, 215, 215),
        ),
        body: Container(
            padding: EdgeInsetsDirectional.all(15),
            child: Center(
              child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Color.fromARGB(255, 0, 26, 75),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => DraggableScrollableSheet(
                        expand: false,
                        initialChildSize: 0.9,
                        maxChildSize: 1.0,
                        minChildSize: 0.3,
                        builder: (_, controller) =>
                            FutureBuilder<List<models.Category>>(
                          future: futureCategory,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text('An error has occurred!'));
                            } else if (snapshot.hasData) {
                              return CategoriesList(categories: snapshot.data!);
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          const Color.fromARGB(255, 0, 201, 201)),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(20),
                        alignment: Alignment.centerLeft,
                        constraints:
                            BoxConstraints(maxWidth: 250, maxHeight: 150),
                        child: Text(
                          "Скидки, подарки и мобильная связь",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          constraints:
                              BoxConstraints(maxWidth: 100, maxHeight: 100),
                          child: Image.network(
                            "https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExeHZhNDRtZTc4eW04Nnd6bDRicmc3cG1jb2M4Y3NpMzkxdnpoenNwaSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/HIh3Bjd9edbvzPnOYg/giphy.gif",
                            width: 75,
                            height: 75,
                          ))
                    ],
                  )),
            )));
  }
}

// --------------------------- LIST OF OFFERS ---------------------------------

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.categories});

  final List<models.Category> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(15),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 255, 250, 237),
                ),
                Text(
                  "Скидки от партнеров",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 250, 237),
                    fontSize: 24,
                  ),
                ),
                Text(
                  "г. Уфа",
                  style: TextStyle(color: Color.fromARGB(255, 255, 149, 43)),
                ),
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 15),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          Color.fromARGB(50, 0, 0, 0))),
                  child: Text(
                    "Поиск",
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Center(
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.all(15)),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          Color.fromARGB(255, 255, 250, 237)),
                      foregroundColor: WidgetStatePropertyAll<Color>(
                          Color.fromARGB(255, 0, 0, 0)),
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                      fixedSize:
                          WidgetStatePropertyAll<Size>(Size.square(180.0)),
                    ),
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            child: Image.network(
                                categories[index].logo.toString()),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(categories[index].title.toString()),
                                Text("data")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// -------------------------- AUTHENTIFICATION PAGE ----------------------------

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController login = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Authorization"),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 400,
            alignment: Alignment.center,
            padding: EdgeInsetsDirectional.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network("${settings.host}/${settings.logoPath}"),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(55),
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CupertinoTextField(
                        controller: login,
                        placeholder: "login",
                        suffix: Icon(Icons.person),
                      ),
                      CupertinoTextField(
                        obscureText: true,
                        controller: password,
                        placeholder: "password",
                        suffix: Icon(Icons.lock),
                      ),
                    ],
                  ),
                ),
                CupertinoButton(
                  color: Color.fromARGB(255, 50, 50, 50),
                  child: Text(
                    "Войти",
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                  onPressed: () async {
                    try {
                      final authService = AuthService();
                      await authService.login(
                        login.text.trim(),
                        password.text.trim(),
                      );

                      // Токены уже сохранены в AuthService.login()
                      // Можно проверить их наличие
                      if (await SecureTokenStorage.hasTokens()) {
                        Navigator.pushNamed(context, '/home');
                      } else {
                        Navigator.of(context).restorablePush(_dialogBuilder);
                      }
                    } catch (e) {
                      Navigator.of(context).restorablePush(_dialogBuilder);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

@pragma('vm:entry-point')
Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
  return CupertinoDialogRoute<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text('Ошибка авторизации'),
        content: const Text('Неверный лоигин или пароль'),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ОК'),
          ),
        ],
      );
    },
  );
}
