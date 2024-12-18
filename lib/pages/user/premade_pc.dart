import 'package:built_your_pc/pages/components/content_container.dart';
import 'package:built_your_pc/pages/user/pc_info.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/pc_provider.dart';

class PremadePCPage extends StatefulWidget {
  const PremadePCPage({super.key});

  @override
  State<PremadePCPage> createState() => _PremadePCPageState();
}

class _PremadePCPageState extends State<PremadePCPage> {
  @override
  Widget build(BuildContext context) {
    final pc = Provider.of<PCProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: appbarcolor,
        centerTitle: true,
        title: CostumText(
          data: "For You Page",
          color: const Color.fromARGB(255, 43, 43, 43),
          size: 16,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
          child: FutureBuilder(
            future: pc.fetchPC(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: const Color.fromARGB(255, 53, 48, 48),
                ));
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error loading PCs'));
              }
              final item = pc.pcList;
              return item.isEmpty
                  ? Center(child: Text('No PCs available'))
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: item.length,
                      itemBuilder: (context, index) {
                        final i = item[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => PcInfo(model: i))),
                            child: Container(
                              decoration: BoxDecoration(
                                color: contentBg,
                                border: Border.all(color: bg),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        child: Image.network(
                                          "https://rjkgsarcxukfiomccvrq.supabase.co/storage/v1/object/public/profile/${i.pcCase['pic_url']}",
                                          width: 120,
                                          height: 120,
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    CostumText(
                                      data: i.name,
                                      size: 13,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
