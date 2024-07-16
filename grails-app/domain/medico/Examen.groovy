package medico

class Examen {

    TipoExamen tipoExamen
    String descripcion
    int numero


    static mapping = {
        table 'exam'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'exam__id'
            tipoExamen column: 'tpex__id'
            descripcion column: 'examdscr'
            numero column: 'examnmro'
        }
    }


    static constraints = {
        tipoExamen(blank: false, nullable: false)
        descripcion(blank: false, nullable: false, size: 0..255)
        numero(blank: false, nullable: false)
    }
}
