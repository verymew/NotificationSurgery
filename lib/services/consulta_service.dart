import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConsultaService {
  final _firestore = FirebaseFirestore.instance;

  gravarConsulta(String nome, DateTime data, String tipo) {
    User? user = FirebaseAuth.instance.currentUser;
    return _firestore
        .collection('consultas')
        .add({'nome': nome, 'data': data, 'tipo': tipo, 'userId': user!.uid});
  }

  listarTodosPorId(userId) {
    return _firestore
        .collection('consultas')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  Future<void> excluir(String id) {
    final documentRef = _firestore.collection('consultas').doc(id);
    return documentRef.delete();
  }

  Future<void> editar(
      String id, String nome, String tipo, DateTime data) async {
    final documentRef = _firestore.collection('consultas').doc(id);
    return await documentRef.update({'nome': nome, 'tipo': tipo, 'data': data});
  }
}
