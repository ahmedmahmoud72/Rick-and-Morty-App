import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      cursorColor: Colors.black,
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
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearch();
          },
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
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
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
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
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacters.length,
        itemBuilder: (BuildContext context, int index) => CharacterItem(
            character: _searchController.text.isEmpty
                ? allCharacters[index]
                : searchedForCharacters[index]),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: _isSearching ? _buildSearchComponent() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return Center(
              child: SvgPicture.asset(
                'assets/images/no_internet.svg',
                height: 400,
                fit: BoxFit.cover,
              ),
            );
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
