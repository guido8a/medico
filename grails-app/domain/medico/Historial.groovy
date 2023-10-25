package medico

import seguridad.Paciente
import seguridad.Persona

class Historial {

    Persona persona
    Paciente paciente
    Diagnostico diagnostico
    Date fecha
    String motivo
    String actual
    String tratamiento
    String examenes
    Date proximaCita
    String observaciones

    static mapping = {
        table 'hscl'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'hscl__id'
        id generator: 'identity'
        version false
        columns {
            persona column: 'prsn__id'
            paciente column: 'pcnt__id'
            diagnostico column: 'diag__id'
            fecha column: 'hsclfcha'
            motivo column: 'hsclmotv'
            actual column: 'hsclactl'
            tratamiento column: 'hscltrtm'
            examenes column: 'hsclexmn'
            proximaCita column: 'hsclpxct'
            observaciones column: 'hsclobsr'
        }
    }

    static constraints = {
        persona(blank: false, nullable: false)
        paciente(blank: false, nullable: false)
        diagnostico(blank: true, nullable: true)
        fecha(blank: false, nullable: false)
        motivo(size:0..255,blank: true, nullable: true)
        actual(size:0..255,blank: true, nullable: true)
        tratamiento(size:0..255,blank: true, nullable: true)
        examenes(size:0..255,blank: true, nullable: true)
        proximaCita(blank: true, nullable: true)
        observaciones(size:0..255,blank: true, nullable: true)
    }
}
