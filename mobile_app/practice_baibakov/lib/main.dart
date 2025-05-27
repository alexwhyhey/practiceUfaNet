import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_baibakov/auth/auth.dart';
import 'package:url_launcher/url_launcher.dart';
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
                              return CategoriesList(
                                categories: snapshot.data!,
                              );
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
                    onPressed: () {
                      final Future<List<models.Offer>> offerByCtg =
                          models.ApiService.fetchOffersByCategory(
                              categories[index].id);

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
                              FutureBuilder<List<models.Offer>>(
                            future: offerByCtg,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                    child: Text('An error has occurred!'));
                              } else if (snapshot.hasData) {
                                return OffersByCategory(
                                  offers: snapshot.data!,
                                  categoryName: categories[index].title,
                                );
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
                      padding: WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.all(15)),
                      backgroundColor: WidgetStatePropertyAll<Color>(index == 0
                          ? Color.fromARGB(255, 89, 255, 23)
                          : (index == 1
                              ? Color.fromARGB(255, 255, 150, 38)
                              : Color.fromARGB(255, 255, 250, 237))),
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
                                FutureBuilder<int>(
                                  future:
                                      models.ApiService.countOffersByCategory(
                                          categories[index].id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text(
                                          '...'); // Loading indicator
                                    } else if (snapshot.hasError) {
                                      return const Text(
                                          '0'); // Fallback on error
                                    } else {
                                      return Text(
                                        '${snapshot.data} offers',
                                        style: TextStyle(
                                            color: Color.fromARGB(74, 0, 0, 0)),
                                      );
                                    }
                                  },
                                ),
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

// ---------------------------- OFFERS BY CATEGORY ----------------------------

class OffersByCategory extends StatelessWidget {
  const OffersByCategory(
      {super.key, required this.offers, required this.categoryName});

  final List<models.Offer> offers;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
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
                  categoryName,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 250, 237),
                    fontSize: 24,
                  ),
                ),
                Text(
                  "",
                  style: TextStyle(color: Color.fromARGB(255, 255, 149, 43)),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemCount: offers.length,
              itemBuilder: (context, index) {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      final Future<models.Offer> offer =
                          models.ApiService.fetchOffer(offers[index].id);

                      showModalBottomSheet(
                        backgroundColor: Color.fromARGB(255, 17, 17, 17),
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => DraggableScrollableSheet(
                          expand: false,
                          initialChildSize: 0.9,
                          maxChildSize: 1.0,
                          minChildSize: 0.3,
                          builder: (_, controller) =>
                              FutureBuilder<models.Offer>(
                            future: offer,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                    child: Text('An error has occurred!'));
                              } else if (snapshot.hasData) {
                                return OfferPage(
                                  offer: snapshot.data!,
                                );
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
                          WidgetStatePropertyAll<Size>(Size.fromHeight(250.0)),
                    ),
                    child: Container(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                child: Image.network(
                                    height: 200,
                                    offers[index].backImage.toString()),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(offers[index]
                                        .whatOfferAbout
                                        .toString()),
                                    Text(offers[index].whereToUse.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color.fromARGB(255, 60, 60, 60),
                          )
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

// ---------------------------- OFFERS BY CATEGORY ----------------------------

class OfferPage extends StatelessWidget {
  const OfferPage({super.key, required this.offer});

  final models.Offer offer;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Color.fromARGB(255, 212, 212, 212),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer.whatOfferAbout.toString(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18)),
                          ),
                          Text(
                            offer.whereToUse.toString(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: Image.network(
                        offer.backImage.toString(),
                        height: 250,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  offer.partner.logo.toString(),
                  height: 50,
                ),
                Text(
                  offer.partner.title.toString(),
                  style: TextStyle(color: Color.fromARGB(255, 202, 202, 202)),
                ),
              ],
            ),
          ),
          CupertinoButton(
            color: Color.fromARGB(218, 255, 112, 11),
            onPressed: () => _launchUrl(offer.url.toString()),
            child: Text(
              offer.buttonName.toString(),
              style: TextStyle(color: Color.fromARGB(255, 18, 18, 18)),
            ),
          ),
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Подробнее",
                style: TextStyle(color: Color.fromARGB(102, 171, 171, 171)),
              ),
              Container(
                color: Color.fromARGB(255, 48, 48, 48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Как получить"),
                          Text(offer.howToGet.toString()),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Срок действия"),
                          Text(
                              "${offer.startDate.toString()} - ${offer.endDate.toString()}"),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("О партнере"),
                          Text(offer.partner.about.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ]);
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
