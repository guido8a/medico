package medico

import audita.Auditable

class Cargo implements Auditable{

    static auditable = true
    String descripcion

    static mapping = {
        table 'crgo'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        control sort: ['ctrlNombre': 'asc']
        columns {
            id column: 'crgo__id'
            descripcion column: 'crgodscr'
        }
    }


    static constraints = {
        descripcion(blank: false, size: 0..50)
    }

    String toString() {
        "${this.descripcion}"
    }
}
