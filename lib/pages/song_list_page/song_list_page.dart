import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/domain.dart'; 
import 'dart:io'; 
// import 'widgets/widgets.dart';
import 'package:collection/collection.dart'; 
import 'pages/pages.dart'; 
import '../../providers/providers.dart'; 
// import '../../theme/theme.dart'; 

class PageItem {
  final String pageName; 
  final Widget page;

  PageItem(this.pageName, this.page); 
}

class SongListPage extends StatefulWidget {
  const SongListPage({Key? key}) : super(key: key);

  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  late List<Song> placeholderSongs = AllSongsState.placeholderSongs; 
  late List<SongPlaylist> placeholderPlaylists = AllSongsState.placeholderPlaylists; 
  
  // String? _songsPath; 

  final PageController _pageController = PageController(initialPage: 0); 
  int _activePage = 0; 

  // @override
  // void initState() {
  //   super.initState();
  //   // if (songsBox.isNotEmpty) {
  //   //   clearSongs(); 
  //   //   for (Song song in songsBox.values) {
  //   //     addSong(song); 
  //   //   }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AllSongsState>(); 

    late final Set<PageItem> pages = <PageItem>{
      PageItem(
        "Playlist",
        SongsPlaylistPage(songs: appState.allSongs,), 
      ),
      PageItem(
        "Folders",
        const SongFoldersPage(), 
      ),
      PageItem(
        "All Songs",
        AllSongsPage(), 
      ),
      PageItem(
        "Albums",
        const AlbumsPage(), 
      ),
    }; 

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SongCategoryTabs(
            pages: pages, 
            pageController: _pageController, 
            activePage: _activePage
          ), 
          Expanded(
            child: PageView(
              scrollBehavior: AppScrollBehavior(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _activePage = page; 
                });
              },
              children: [
                for (PageItem pageItem in pages) 
                  pageItem.page, 
              ],
            ),
          ),
        ]
      ),
    );
  }
}


class _SongCategoryTabs extends StatelessWidget {
  const _SongCategoryTabs({
    Key? key,
    required Set<PageItem> pages,
    required PageController pageController,
    required int activePage,
  }) : _pages = pages, _pageController = pageController, _activePage = activePage, super(key: key);

  final Set<PageItem> _pages;
  final PageController _pageController;
  final int _activePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30, 
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColorLight
          )
        )
      ),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List<Widget>.generate(
              _pages.length, 
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    _pageController.animateToPage(
                      index, 
                      duration: const Duration(milliseconds: 300), 
                      curve: Curves.easeIn, 
                    ); 
                  },
                  child: Text(
                    _pages.elementAt(index).pageName, 
                    style: _activePage == index ? 
                      Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold) : 
                      Theme.of(context).textTheme.titleSmall
                    ,
                  ),
                ),
              )
            )
          ),
        ),
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}