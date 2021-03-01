import 'package:google_api_availability/google_api_availability.dart';
import 'package:flutter/material.dart';

class GoogleApiAvailabilityPage extends StatelessWidget {
  String googleAvailabilityDescription(
      GooglePlayServicesAvailability availability) {
    switch (availability) {
      case GooglePlayServicesAvailability.notAvailableOnPlatform:
        return 'Los servicios de Google no están disponibles en esta plataforma';
      case GooglePlayServicesAvailability.serviceDisabled:
        return 'Los servicios de Google están desactivados en este dispositivo';
      case GooglePlayServicesAvailability.serviceInvalid:
        return 'Los servicios de Google instalados no son "auténticos"';
      case GooglePlayServicesAvailability.serviceMissing:
        return 'No hay servicios de Google en este dispositivo';
      case GooglePlayServicesAvailability.serviceUpdating:
        return 'Los servicios de Google se están actualizando';
      case GooglePlayServicesAvailability.serviceVersionUpdateRequired:
        return 'Los servicios de Google están obsoletos';
      case GooglePlayServicesAvailability.success:
        return 'Los servicios de Google están instalados y listos para usarse';
      case GooglePlayServicesAvailability.unknown:
        return 'No se pudo determinar si los servicios de Google están instalados';
      default:
        return '¿Descripción no disponible?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios de Google'),
      ),
      body: Center(
        child: FutureBuilder<GooglePlayServicesAvailability>(
          future: GoogleApiAvailability.instance
              .checkGooglePlayServicesAvailability(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var availability = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$availability',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(googleAvailabilityDescription(availability)),
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text('${snapshot.error}')
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
