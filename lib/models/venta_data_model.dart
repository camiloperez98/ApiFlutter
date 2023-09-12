import 'dart:convert';

DataModelVenta dataModelFromJson(String str) => DataModelVenta.fromJson(json.decode(str));

String dataModelToJson(DataModelVenta data) => json.encode(data.toJson());

class DataModelVenta {
    DataModelVenta({
        required this.ventas,
     
    });

    List<Venta> ventas;
   

    factory DataModelVenta.fromJson(Map<String, dynamic> json) => DataModelVenta(
        ventas: List<Venta>.from(json["ventas"].map((x) => Venta.fromJson(x))),
        
    );

    Map<String, dynamic> toJson() => {
        "ventas": List<dynamic>.from(ventas.map((x) => x.toJson())),
      
    };
}

class Venta {
    Venta({
        required this.id,
        required this.numeroVenta,
        required this.nombreCliente,
        required this.subtotal,
        required this.iva,
        required this.estado,
        required this.fecha,
        required this.total
       
    });

    String id;
    int numeroVenta;
    String nombreCliente;
    int subtotal;
    int iva;
    bool estado;
    String fecha;
    int total;

    factory Venta.fromJson(Map<String, dynamic> json) => Venta(
        id: json["_id"],
        numeroVenta: json["numeroVenta"],
        nombreCliente: json["nombreCliente"],
        subtotal: json["subtotal"],
        iva: json["iva"],
        estado: json["estado"],
        fecha: json ["fecha"],
        total: json["totalVenta"]
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "numeroVenta": numeroVenta,
        "nombreCliente": nombreCliente,
        "subtotal": subtotal,
        "iva": iva,
        "estado": estado,
        "fecha": fecha,
        "totalVenta": total
    };
}