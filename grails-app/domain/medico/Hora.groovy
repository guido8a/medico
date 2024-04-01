package medico

class Hora {

    String numero
    String descripcion

    static mapping = {
        table 'hora'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'hora__id'
        id generator: 'identity'
        version false
        columns {
            numero column: 'horanmro'
            descripcion column: 'horadscr'
        }
    }

    static constraints = {
        numero(blank: false, nullable: false)
        descripcion(size: 0..15, blank: false, nullable: false)
    }
}
