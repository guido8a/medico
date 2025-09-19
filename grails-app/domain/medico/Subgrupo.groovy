package medico

import seguridad.Empresa

class Subgrupo {

    Grupo grupo
    Empresa empresa
    String descripcion
    Integer orden

    static mapping = {
        table 'sbgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'sbgr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'sbgr__id'
            grupo column: 'grpo__id'
            empresa column: 'empr__id'
            descripcion column: 'sbctdscr'
            orden column: 'sbgrordn'
        }
    }

    static constraints = {
        grupo(blank: false, nullable: false)
        empresa(blank: true, nullable: true)
        descripcion(size: 0..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
        orden(blank: true, nullable: true)

    }

}
