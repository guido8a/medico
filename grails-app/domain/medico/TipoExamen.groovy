package medico

class TipoExamen {

    GrupoExamen grupoExamen
    String descripcion

    static mapping = {
        table 'tpex'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'tpex__id'
            grupoExamen column: 'grex__id'
            descripcion column: 'tpexdscr'
        }
    }


    static constraints = {
        grupoExamen(blank: false, nullable: false)
        descripcion(blank: false, nullable: false, size: 0..63)
    }
}
