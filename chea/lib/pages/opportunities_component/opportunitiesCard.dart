import 'package:chea/pages/opportunities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class OpportunitiesCard extends StatefulWidget {
  final Opportunity opportunity;
  final VoidCallback onTap;

  OpportunitiesCard({
    super.key,
    required this.onTap,
    required this.opportunity,
  });

  @override
  State<OpportunitiesCard> createState() => _OpportunitiesCardState();
}

class _OpportunitiesCardState extends State<OpportunitiesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xff201f1f),
              borderRadius: BorderRadius.circular(40)),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.opportunity.title,
                        style: GoogleFonts.nunitoSans(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Stipend: ${widget.opportunity.stipend}',
                        style: GoogleFonts.montserrat(
                            color: const Color(0xff7a7878),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      ),
                      Text('Location: ${widget.opportunity.location}',
                          style: GoogleFonts.montserrat(
                              color: const Color(0xff7a7878),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic)),
                      Row(
                        children: [
                          const Icon(Icons.alarm_rounded,
                              color: Color(0xff7a7878), size: 20),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Apply by: ',
                            style: GoogleFonts.montserrat(
                                color: Color(0xff7a7878),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            widget.opportunity.lastDateOfApply,
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    widget.opportunity.isFavourite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: widget.opportunity.isFavourite ? Colors.red : Colors.white,
                    size: 40,
                  ),
                  onPressed: () async {
                    await toggleFavorite(widget.opportunity);
                    setState(() {});
                  }
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}