package medico

import audita.Auditable

class Dias implements Auditable{

    int numero
    String nombre

    static mapping = {
        table 'dias'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dias__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dias__id'
            numero column: 'diasnmro'
            nombre column: 'diasnmbr'
        }
    }

    static constraints = {
        nombre(size: 1..15, blank: false, nullable: false, attributes: [title: 'nombre'])
        numero(maxSize: 2, blank: false, nullable: false, attributes: [title: 'número'])

    }
}
