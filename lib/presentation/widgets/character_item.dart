import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/charachters_model.dart';
import 'package:rick_and_morty_app/presentation/constants/strings.dart';

class CharacterItem extends StatelessWidget {
  final Results character;

  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(4, 8),
        ),
      ], borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.charactersDetailsScreen,
                arguments: character,
              ),
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/stars.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.white,
                  child: Hero(
                    tag: character.id!,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          '${character.name}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black,
                        spreadRadius: 2,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                child: CircleAvatar(
                  radius: 50.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: FadeInImage.assetNetwork(
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: 'assets/images/loading_static.jpeg',
                      image: character.image!,
                    ),
                  ),
                ),
              ),
            ),
          ])),
    );
  }
}
