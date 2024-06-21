package medico

class Examen {

    TipoExamen tipoExamen
    String descripcion


    static mapping = {
        table 'exam'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'exam__id'
            tipoExamen column: 'tpex__id'
            descripcion column: 'examdscr'
        }
    }


    static constraints = {
        tipoExamen(blank: false, nullable: false)
        descripcion(blank: false, nullable: false, size: 0..255)
    }
}
