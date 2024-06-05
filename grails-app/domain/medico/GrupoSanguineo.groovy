package medico

class GrupoSanguineo {

    String descripcion

    static mapping = {
        table 'grsn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'grsn__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'grsndscr'
        }
    }

    static constraints = {
        descripcion(size: 1..15, blank: false, nullable: false)
    }
}
