import 'package:flutter/material.dart';

class DataDiri extends StatelessWidget {
  const DataDiri({Key? key}) : super(key: key);

  final String name = 'Syihabudin Rahmat Ramadhan';
  final int age = 20;
  final String hobby = 'Main Game';
  final String kelas = 'IF-B';
  final int nim = 123200081;
  final String imageUrl =
      'https://media.licdn.com/dms/image/D5603AQGbyi90qBrfuQ/profile-displayphoto-shrink_400_400/0/1678707486881?e=1684368000&v=beta&t=WLvLsK6HL92vtu0KFiOK9t1FhpltSuUA6Rrju19oMYI';
  final String ttl = 'Madiun, 16 November 2002';
  final String cita2 = 'Software Engineer in the future';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child:  Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _DetailCard(
                    title: 'NIM',
                    value: '123200081',
                    icon: Icons.format_list_numbered,
                  ),
                  _DetailCard(
                    title: 'Age',
                    value: '20',
                    icon: Icons.cake,
                  ),
                  _DetailCard(
                    title: 'Kelas',
                    value: 'IF-B',
                    icon: Icons.class_,
                  ),
                  _DetailCard(
                    title: 'Hobby',
                    value: 'Main Game',
                    icon: Icons.games,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const _DetailCard(
              title: 'Tempat, Tanggal Lahir',
              value: 'Madiun, 16 November 2002',
              icon: Icons.calendar_today,
            ),
            const SizedBox(height: 30),
            const _DetailCard(
              title: 'Cita-cita',
              value: 'Software Engineer in the future',
              icon: Icons.work,
            ),
               const SizedBox(height: 30),
               
            const _DetailCard(
              title: 'Pesan dan Kesan',
              value: 'Seru dan Menyenangkan',
              icon: Icons.comment,
            ),
          ],
        ),
      ),
  
      ) 
       );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.blueGrey,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}