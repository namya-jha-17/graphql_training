import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:untitled5/model/characters/characters.dart';

import 'characters_state.dart';
import 'fetch_characters_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'graphql Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:ProviderScope (child:const MyHomePage(),),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
HttpLink httpLink=HttpLink("https://rickandmortyapi.com");
ValueNotifier<GraphQLClient> client=ValueNotifier<GraphQLClient>(
  GraphQLClient(link: httpLink as Link,
      cache: GraphQLCache()
  )
);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("graphql demo "),
      ),
      body: GraphqlListing()
      //GraphQLProvider(client: client,child: GraphqlListing(),)
    );
  }

}
final fetchCharacterProvider=StateNotifierProvider<FetchCharacterProvider,FetchcharactersState>(
        (ref)=> FetchCharacterProvider(FetchcharactersState.initial())..fetchcharacters()
);
class GraphqlListing extends ConsumerStatefulWidget {
  const GraphqlListing({super.key});

  @override
  ConsumerState<GraphqlListing> createState() => _GraphqlListingState();
}

class _GraphqlListingState extends ConsumerState<GraphqlListing> {
  late FetchCharacterProvider fetchCharacterProviders;



  @override
  Widget build(BuildContext context) {
    final charaterprovider = ref.watch(fetchCharacterProvider);
    return charaterprovider.when(fetched:
        (charaterprovider) {
     List<Character> products = charaterprovider.map((e) => e).toList();
      return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, int index) {
            return ListTile(
              title: Text(products[index].name ?? "no response"),);
          });
    },
        initial: () {
          return CircularProgressIndicator();
        },
        fetching: () {
          return CircularProgressIndicator();
        },


        failed: (String error) {
          return Text("oops something went wrong");
        });
  }
}