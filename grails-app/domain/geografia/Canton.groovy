package geografia

class Canton   {

    Provincia provincia
    Integer numero
    String nombre
    double longitud
    double latitud

    static mapping = {
        table 'cntn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cntn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'cntn__id'
            provincia column: 'prov__id'
            numero column: 'cntnnmro'
            nombre column: 'cntnnmbr'
            longitud column: 'cntnlong'
            latitud column: 'cntnlatt'
        }
    }

    static constraints = {
        provincia(blank: false, nullable: false, attributes: [mensaje: 'Provincia a la que pertenece el cantón'])
        numero(blank: true, nullable: true, attributes: [mensaje: 'Número del cantón'])
        nombre(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Nombre del cantón'])
        longitud(blank: true, nullable: true, attributes: [mensaje: 'Longitud'])
        latitud(blank: true, nullable: true, attributes: [mensaje: 'Latitud'])
    }

    String toString() {
        return this.nombre
    }
}