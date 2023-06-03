import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          color: Colors.grey[200],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 150,
                    height: 150,
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                    )
                ),
                SizedBox(height: 8,),
                Container(
                  child: Text(
                    'MANGAGAN',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 10,
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  child: Text(
                    'MANGAGAN adalah aplikasi pencarian manga',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: 32,),

                Container(
                  child: Text(
                    '123190121 - M. PATTY AMAL MADANI',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Saran : Semoga kedepannya mata kuliah Teknologi Pemrograman '
                        'Mobile dapat berkembang lebih baik dan dapat menyesuaikan dengan '
                        'perkembangan zaman dan semoga urusan nilai dipermudah ya pak :v',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Kesan :Selama kuliah Teknologi Pemrograman Mobil ini adalah sangat menyenangkan, perkuliahan nya asik, bapak dosennya'
                        'juga baik cuma materi nya aja yang cukup sulit',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}