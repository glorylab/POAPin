import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/pages/home/components/wrapper.bottomsheet.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class CountriesView extends StatelessWidget {
  const CountriesView({Key? key}) : super(key: key);

  List<Widget> _buildCountries(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    List<Widget> countries = [];
    controller.countries.value.forEach(
      (country, value) {
        countries.add(
          RawMaterialButton(
            onPressed: () {
              controller.setFilterByCountry(country);
              Get.back();
            },
            child: Container(
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8),
                      child: Text(
                        '$country',
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.courierPrime(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      '$value',
                      style: GoogleFonts.epilogue(
                        fontSize: 18,
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
    return countries;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      content: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Countries',
              style: GoogleFonts.epilogue(fontSize: 16, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 16),
          ..._buildCountries(context),
        ],
      ),
    );
  }
}
