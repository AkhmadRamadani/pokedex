import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rama_poke_app/modules/detail/controllers/detail_controller.dart';
import 'package:rama_poke_app/modules/detail/views/sections/detail_app_bar_section.dart';
import 'package:rama_poke_app/modules/detail/views/sections/detail_content_section.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key, required this.id});
  final String id;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final ScrollController _scrollController = ScrollController();
  late DetailController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<DetailController>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          DetailAppBarSection(scrollController: _scrollController),
          DetailContentSection(),
        ],
      ),
    );
  }
}
