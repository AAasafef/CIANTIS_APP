import 'package:flutter/material.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          'Clients',

          style: TextStyle(
            color: Color(0xFF2B2118),
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8B735B),

        onPressed: () {},

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: ListView(
        physics: const BouncingScrollPhysics(),

        padding: const EdgeInsets.all(20),

        children: [

          _buildClientCard(
            name: 'Jessica Williams',
            service: 'K-Tip Extensions',
            date: 'May 28, 2026',
            amount: '\$1,250',
          ),

          _buildClientCard(
            name: 'Danielle Carter',
            service: 'Luxury Silk Press',
            date: 'May 29, 2026',
            amount: '\$180',
          ),

          _buildClientCard(
            name: 'Brianna Lewis',
            service: 'Tape-In Install',
            date: 'June 1, 2026',
            amount: '\$720',
          ),

          _buildClientCard(
            name: 'Ashley Monroe',
            service: 'Gel-X Manicure',
            date: 'June 3, 2026',
            amount: '\$160',
          ),
        ],
      ),
    );
  }

  Widget _buildClientCard({
    required String name,
    required String service,
    required String date,
    required String amount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),

            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFFF1E7DA),

            child: Text(
              name[0],

              style: const TextStyle(
                color: Color(0xFF8B735B),
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  name,

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2B2118),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  service,

                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  date,

                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFFF1E7DA),

              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: Text(
              amount,

              style: const TextStyle(
                color: Color(0xFF8B735B),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}