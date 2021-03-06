import 'package:amb_sc/src/models/evento_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class EventosProvider {
  final geo = Geoflutterfire();
  List<EventoModel> eventos = [];
  final _firestore = FirebaseFirestore.instance;

  Future<List<EventoModel>> cargarEventos() async {
    // List<EventoModel> eventos;
    _firestore
        .collection('notificacion')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        num nlt = doc["coordenadas"].latitude;
        num nlg = doc["coordenadas"].longitude;

        GeoPoint ngp = new GeoPoint(nlt, nlg);

        EventoModel e1 = new EventoModel(
            descripcion: doc["descripcion"],
            id: doc.id,
            titulo: doc["titulo"],
            coordenadas: ngp);
        this.eventos.add(e1);

        print(eventos.length);
        print("========");
      });
    });
  }

  void addNewPoint() {
    GeoFirePoint myLocation =
        geo.point(latitude: -38.757639, longitude: -72.633563);
    _firestore
        .collection('notificacion')
        .add({'name': 'ubicacion didier', 'position': myLocation.data});
  }

  void getClosest2() {
    // num lat = evento.coordenadas.latitude;
    // num lng = evento.coordenadas.longitude;
    num lat = -38.740971;
    num lng = -72.597225;
    GeoPoint g = new GeoPoint(lat, lng);

    FirebaseFirestore.instance
        .collection('notificacion')
        .where("coordenadas", isEqualTo: g)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print("==========");
        print(doc.data());
        print("==========");
      });
    });
  }

  Future<Stream> getClosest() async {
    GeoFirePoint myLocation =
        geo.point(latitude: -38.756705, longitude: -72.632047);

    var collectionReference = _firestore.collection("notificaciones");

    double radius = 0.1;
    String field = 'position';

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: myLocation, radius: radius, field: field);

    return stream;
  }
}

  // void agregarNotificacion() {
  //   GeoFirePoint ubicacion =
  //       geo.point(latitude: -38.74001, longitude: -72.590076);
  //   _firestore.collection('notificaciones').add({
  //     'titulo': 'Plaza De Armas Anibal Pinto',
  //     'descripcion': 'Plaza principal de Temuco',
  //     'position': ubicacion.data
  //   });

  //   GeoFirePoint ubicacion2 =
  //       geo.point(latitude: -38.724188, longitude: -72.588426);
  //   _firestore.collection('notificaciones').add({
  //     'titulo': 'Cerro ??ielol',
  //     'descripcion':
  //         ':hojas: Martes a Viernes de 08:30 :reloj830: a 16:00 :reloj4: hrs.  :hojas: Aforo: 200 personas. Ingreso por orden de llegada.',
  //     'position': ubicacion2.data
  //   });

  //   GeoFirePoint ubicacion3 =
  //       geo.point(latitude: -38.74612, longitude: -72.617498);
  //   _firestore.collection('notificaciones').add({
  //     'titulo': 'YoMeVacuno: Gimnasio Ol??mpico UFRO',
  //     'descripcion':
  //         'Hoy martes 18 de mayo (08.30 a 17.00 hrs. Horario continuado)  :diamante_azul_peque??o: 1a dosis personas de 32 y 33 a??os :diamante_azul_peque??o: 2a dosis vacunados 19 al 25 de abril  :diamante_azul_peque??o: Rezagados de 35 o m??s a??os :diamante_azul_peque??o: Vacunaci??n embarazadas (con Formulario de Consejer??a)',
  //     'position': ubicacion3.data
  //   });

  //   GeoFirePoint ubicacion4 =
  //       geo.point(latitude: -38.712919, longitude: -72.622438);
  //   _firestore.collection('notificaciones').add({
  //     'titulo': 'YoMeVacuno:Gimnasio Pedro de Valdivia',
  //     'descripcion':
  //         'Hoy martes 18 de mayo (08.30 a 17.00 hrs. Horario continuado)  :diamante_azul_peque??o: 1a dosis personas de 32 y 33 a??os :diamante_azul_peque??o: 2a dosis vacunados 19 al 25 de abril  :diamante_azul_peque??o: Rezagados de 35 o m??s a??os :diamante_azul_peque??o: Vacunaci??n embarazadas (con Formulario de Consejer??a)',
  //     'position': ubicacion4.data
  //   });

  //   GeoFirePoint ubicacion5 =
  //       geo.point(latitude: -38.757639, longitude: -72.633563);
  //   _firestore.collection('notificaciones').add({
  //     'titulo': 'Juzgado de Policia Local de Temuco',
  //     'descripcion':
  //         'Es un Tribunal especial que tiene por objeto administrar justicia en conformidad a las normas establecidas en la Ley N?? 15.231, Org??nica de los Juzgados de Polic??a Local. El Juzgado de Polic??a Local depende administrativamente de la Municipalidad, estando directamente sujeto a la supervigilancia directiva, correccional y econ??mica de la respectiva Corte de Apelaciones integrante del Poder Judicial.',
  //     'position': ubicacion5.data
  //   });

  //   GeoFirePoint ubicacion6 =
  //       geo.point(latitude: -38.753919, longitude: -72.609205);
  //   _firestore.collection('notificaciones').add({
  //     'titulo': 'Salida Sur Temuco',
  //     'descripcion': 'Salida Sur Temuco',
  //     'position': ubicacion6.data
  //   });
  // }