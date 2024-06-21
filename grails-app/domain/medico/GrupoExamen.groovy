package medico

class GrupoExamen {

    String descripcion

    static mapping = {
        table 'grex'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'grex__id'
            descripcion column: 'grexdscr'
        }
    }


    static constraints = {
        descripcion(blank: false, nullable: false, size: 0..63)
    }
}
