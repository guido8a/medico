package medico

import seguridad.Paciente
import seguridad.Persona

class Agenda {

    Dias dias
    Hora hora
    Paciente paciente
    Persona persona
    Date fechaInicio
    Date fechaFin
    String observaciones

    static mapping = {
        table 'agnd'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'agnd__id'
        id generator: 'identity'
        version false
        columns {
            dias column: 'dias__id'
            hora column: 'hora__id'
            paciente column: 'pcnt__id'
            persona column: 'prsn__id'
            fechaInicio column: 'agndfcin'
            fechaFin column: 'agndfcfn'
            observaciones column: 'agndobsr'
        }
    }

    static constraints = {
        dias(blank: false, nullable: false)
        hora(blank: false, nullable: false)
        paciente(blank: true, nullable: true)
        persona(blank: true, nullable: true)
        fechaInicio(blank: true, nullable: true)
        fechaFin(blank: true, nullable: true)
        observaciones(size: 0..255, blank: true, nullable: true)
    }
}
