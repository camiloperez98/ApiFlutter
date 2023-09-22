import 'dart:convert';

DataModelCliente dataModelFromJson(String str) => DataModelCliente.fromJson(json.decode(str));

String dataModelToJson(DataModelCliente data) => json.encode(data.toJson());

class DataModelCliente {
    DataModelCliente({
        required this.clientes,
     
    });

    List<Cliente> clientes;
   

    factory DataModelCliente.fromJson(Map<String, dynamic> json) => DataModelCliente(
        clientes: List<Cliente>.from(json["clientes"].map((x) => Cliente.fromJson(x))),
        
    );

    Map<String, dynamic> toJson() => {
        "clientes": List<dynamic>.from(clientes.map((x) => x.toJson())),
    };
}

class Cliente {
    Cliente({
        required this.id,
        required this.nombre,
        required this.cedula,
        required this.email,
        required this.telefono,
        required this.estado,
       
    });

    String id;
    String nombre;
    int cedula;
    String email;
    int telefono;
    bool estado;

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["_id"],
        nombre: json["nombre"],
        cedula: json["cedula"],
        email: json["email"],
        telefono: json["telefono"],
        estado: json["estado"]
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "cedula": cedula,
        "email": email,
        "telefono": telefono,
        "estado": estado,
    };
}