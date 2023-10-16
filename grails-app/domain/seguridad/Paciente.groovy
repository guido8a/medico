package seguridad

import geografia.Parroquia
import medico.EstadoCivil
import medico.GrupoSanguineo

class Paciente {

    Empresa empresa
    Parroquia parroquia
    GrupoSanguineo grupoSanguineo
    EstadoCivil estadoCivil
    String cedula
    String nombre
    String apellido
    Date fechaInicio
    Date fechaFin
    String titulo
    String mail
    int activo = 1
    Date fechaNacimiento
    String telefono
    String sexo
    String direccion
    String referencia
    String foto
    String responsable
    String antecedentes
    String antecedentesPatologicosFam
    String antecedentesGinecobstreticos
    String habitos
    String antecedentesOcupacionales
    String antecedentesAntesdeNacer
    String antecedentesDespuesdeNacer

    static mapping = {
        table 'pcnt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'pcnt__id'
        id generator: 'identity'
        version false
        columns {
            empresa column: 'empr__id'
            parroquia column: 'parr__id'
            grupoSanguineo column: 'grsn__id'
            estadoCivil column: 'edcv__id'
            cedula column: 'pcntcdla'
            nombre column: 'pcntnmbr'
            apellido column: 'pcntapll'
            fechaInicio column: 'pcntfcin'
            fechaFin column: 'pcntfcfn'
            titulo column: 'pcnttitl'
            mail column: 'pcntmail'
            activo column: 'pcntactv'
            fechaNacimiento column: 'pcntfcna'
            telefono column: 'pcnttelf'
            sexo column: 'pcntsexo'
            direccion column: 'pcntdire'
            referencia column: 'pcntrefe'
            antecedentes column: 'pcntantc'
            antecedentesPatologicosFam column: 'pcntanfm'
            antecedentesGinecobstreticos column: 'pcntango'
            habitos column: 'pcnthbto'
            foto column: 'pcntfoto'
            responsable column: 'pcbtrspn'
            antecedentesOcupacionales column: 'pcntocup'
            antecedentesAntesdeNacer column: 'pcntannc'
            antecedentesDespuesdeNacer column: 'pcntnacm'
        }
    }

    static constraints = {
        empresa(blank: true, nullable: true)
        parroquia(blank: true, nullable: true)
        grupoSanguineo(blank: true, nullable: true)
        estadoCivil(blank: true, nullable: true)
        cedula(size:0..10,blank: false, nullable: false)
        nombre(size: 0..31, blank: false, nullable: false)
        apellido(size: 0..31, blank: false, nullable: false)
        fechaInicio(blank: true, nullable: true)
        fechaFin(blank: true, nullable: true)
        titulo(size: 0..4, blank: true, nullable: true)
        mail(size: 0..63, blank: true, nullable: true)
        activo(size: 0..1, blank: false, nullable: false)
        fechaNacimiento(blank: true, nullable: true)
        telefono(size: 0..31, blank: true, nullable: true)
        sexo(size: 0..1, blank: true, nullable: true)
        direccion(size: 0..255,  blank: true, nullable: true)
        referencia(size: 0..255,  blank: true, nullable: true)
        antecedentes(size: 0..255,  blank: true, nullable: true)
        antecedentesPatologicosFam(size: 0..255,  blank: true, nullable: true)
        antecedentesGinecobstreticos(size: 0..255,  blank: true, nullable: true)
        foto(size: 0..255, blank: true, nullable: true)
        responsable(size: 0..63, blank: true, nullable: true)
        habitos(size: 0..255, blank: true, nullable: true)
        antecedentesAntesdeNacer(size: 0..255, blank: true, nullable: true)
        antecedentesDespuesdeNacer(size: 0..255, blank: true, nullable: true)
        antecedentesOcupacionales(size: 0..255, blank: true, nullable: true)
    }
}
