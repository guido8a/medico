package seguridad

class TipoPersona {

    String codigo
    String descripcion

    static auditable = true

    static mapping = {
        table 'tppr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'

        columns {
            id column: 'tppr__id'
            codigo column: 'tpprcdgo'
            descripcion column: 'tpprdscr'
        }
    }

    static constraints = {
        codigo(blank: false, nullable: false, size: 0..4)
        descripcion(blank: false, nullable: false, size: 0..63)
    }
}
