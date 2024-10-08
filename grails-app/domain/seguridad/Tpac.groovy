package seguridad

import audita.Auditable

class Tpac implements Auditable{

    static auditable = true
    String tipo

    static mapping = {
        table 'tpac'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'tpac__id'
            tipo column: 'tpacdscr'
        }
    }

    static constraints = {
        tipo(blank: false, size: 0..31)
    }

    String toString() {
        "${this.tipo}"
    }

}
