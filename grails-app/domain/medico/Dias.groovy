package medico

class Dias {

    String numero
    String nombre

    static mapping = {
        table 'dias'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dias__id'
        id generator: 'identity'
        version false
        columns {
            numero column: 'diasnmro'
            nombre column: 'diasnmbr'
        }
    }

    static constraints = {
        numero(blank: false, nullable: false)
        nombre(size: 0..15, blank: false, nullable: false)
    }
}
