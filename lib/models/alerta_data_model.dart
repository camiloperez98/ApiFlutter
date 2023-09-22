class DataModelAlerta{
  DataModelAlerta({
    required this.alertas
  });

  List<Alerta> alertas;

  factory DataModelAlerta.fromJson(Map<String, dynamic> json) => DataModelAlerta(
    alertas: List<Alerta>.from(json["alertas"].map((x) => Alerta.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "alertas": List<dynamic>.from(alertas.map((x) => x.toJson())),
  };
}

class Alerta {
    Alerta({
        required this.id,
        required this.enteRegulatorio,
        required this.fechaAlerta,
        required this.mensajeAlerta,
       
    });

    String id;
    String enteRegulatorio;
    String fechaAlerta ;
    String mensajeAlerta;

    factory Alerta.fromJson(Map<String, dynamic> json) => Alerta(
        id: json["_id"],
        enteRegulatorio: json["enteRegulatorio"],
        fechaAlerta: json["fechaAlerta"],
        mensajeAlerta: json["mensajeAlerta"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "enteRegulatorio": enteRegulatorio,
        "fechaAlerta": fechaAlerta,
        "mensajeAlerta": mensajeAlerta,
    };
}