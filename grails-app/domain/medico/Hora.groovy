package medico

import audita.Auditable

class Hora implements Auditable{


    int numero
    String descripcion

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'hora'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'hora__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'hora__id'
            numero column: 'horanmro'
            descripcion column: 'horadscr'
        }
    }
    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        numero(blank: false, nullable: false, attributes: [mensaje: 'Hora de clases'])
        descripcion(blank: false, nullable: false, attributes: [mensaje: 'Horas'])
    }
}