import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/data/models/charachters_model.dart';
import 'package:rick_and_morty_app/data/web_services/dio_helper.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Results> allCharacters = [];
  List<Results> searchedForCharacters = [];
  bool _isSearching = false;
  final _searchController = TextEditingController();

  Widget _buildSearchComponent() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: 'Search Character ...',
        border: InputBorder.none,
      ),
      onChanged: (searchedCharacter) {
        _addSearchedItemToSearchedList(searchedCharacter);
      },
    );
  }

  void _addSearchedItemToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearch();
          },
          icon: const Icon(Icons.search),
        ),
      ];
    }
  }

  void _startSearch() {
    setState(() {
      ModalRoute.of(context)!
          .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    DioHelper.init();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildCharactersList(),
        ],
      ),
    );
  }

  Widget buildCharactersList() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        itemBuilder: (BuildContext context, int index) => CharacterItem(
            characters: _searchController.text.isEmpty
                ? allCharacters[index]
                : searchedForCharacters[index]),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text('Characters');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchComponent() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
