package medico

class Examen {

    String descripcion
    String tipo

    static mapping = {
        table 'exam'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'exam__id'
            descripcion column: 'examdscr'
            tipo column: 'examtipo'
        }
    }


    static constraints = {
        descripcion(blank: false, nullable: false, size: 0..255)
        tipo(blank: false, nullable: false, size: 0..255)
    }
}
