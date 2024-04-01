package medico

import seguridad.Paciente
import seguridad.Persona

class Agenda {

    Paciente paciente
    Persona persona
    Dias dias
    Hora hora
    Semana semana
    Date fechaInicio
    Date fechaFin
    String observaciones


    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'agnd'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'agnd__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'agnd__id'
            paciente column: 'pcnt__id'
            persona column: 'prsn__id'
            dias column: 'dias__id'
            hora column: 'hora__id'
            semana column: 'smna__id'
            fechaInicio column: 'agndfcin'
            fechaFin column: 'agndfcfn'
            observaciones column: 'agndobsr'
        }
    }
    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        paciente(blank: false, nullable: false, attributes: [mensaje: 'Paralelo al que pertenece el horario'])
        persona(blank: false, nullable: false, attributes: [mensaje: 'Paralelo al que pertenece el horario'])
        dias(blank: false, nullable: false, attributes: [mensaje: 'Dias que constan en el horario'])
        semana(blank: false, nullable: false, attributes: [mensaje: 'Dias que constan en el horario'])
        hora(blank: false, nullable: false, attributes: [mensaje: 'Hora de la clase'])
        fechaInicio(blank: true, nullable: true, attributes: [mensaje: 'Inicio'])
        fechaFin(blank: true, nullable: true, attributes: [mensaje: 'Fin'])
        observaciones(blank: true, nullable: true, attributes: [mensaje: 'Observaciones'])

    }
}