import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/charachters_model.dart';

class CharacterItem extends StatelessWidget {
  final Results characters;

  const CharacterItem({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          10.0
        ),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            height: 40,
            color: Colors.black54,
            child: Text(
              '${characters.name}',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                color: Colors.white,
                    fontWeight: FontWeight.bold,fontSize: 16.0,height: 2
            ),
            ),
          ),
          child:  characters.image!.isNotEmpty
                ? FadeInImage.assetNetwork(
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/loading.gif',
                    image: characters.image!)
                : Image.network(characters.image!),
        ),
      ),
    );
  }
}
