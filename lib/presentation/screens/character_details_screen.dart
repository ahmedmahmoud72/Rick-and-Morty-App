import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/charachters_model.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Results character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            'assets/images/background_image.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        DraggableScrollableSheet(
            minChildSize: 0.24,
            initialChildSize: 0.35,
            builder: (context, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height),
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.black,
                            child: ClipOval(
                              child: Image.network(
                                '${character.image}',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Hero(
                            tag: character.id!,
                            child: Text(
                              '${character.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          characterDetailedDataComponent(
                              context, 'Gender', character.gender!),
                          const SizedBox(
                            height: 20,
                          ),
                          characterDetailedDataComponent(
                              context, 'Status', character.status!),
                          const SizedBox(
                            height: 15,
                          ),
                          characterDetailedDataComponent(
                              context, 'Specie', character.species!),
                          const SizedBox(
                            height: 15,
                          ),
                          characterDetailedDataComponent(
                              context, 'Location', character.location!.name!),
                          const SizedBox(
                            height: 15,
                          ),
                          character.type!.isEmpty
                              ? const SizedBox()
                              : characterDetailedDataComponent(
                                  context, 'Type', character.type!),
                        ],
                      ),
                    ),
                  ),
                )),
      ],
    ));
  }

  Widget characterDetailedDataComponent(
      BuildContext context, String title, String data) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      text: TextSpan(
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white,
            ),
        children: <TextSpan>[
          TextSpan(
            text: '$title :\t',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: data,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
