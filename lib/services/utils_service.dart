import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class UtilsService {

  formatarData(consulta) {
    DateTime dataConsulta = (consulta as Timestamp).toDate();
    String novaData = DateFormat('dd MMMM yyyy').format(dataConsulta);
    return novaData;
  }
  
}
