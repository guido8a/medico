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
    String alergias
    String habitosAlimentario
    int habitosUrinario
    int habitosDefecatorio
    String habitosFumador
    String habitosTomador
    String numeroHistorial
    String ocupacion
    String residenciaHabitual
    String residenciaOcasional
    String path
    String facturar

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
            alergias column: 'pcntalrg'
            habitosAlimentario column: 'pcntalmn'
            habitosUrinario column: 'pcnturin'
            habitosDefecatorio column: 'pcntdefc'
            habitosFumador column: 'pcntfuma'
            habitosTomador column: 'pcnttoma'
            numeroHistorial column: 'pcnthscl'
            ocupacion column: 'pcntocpc'
            residenciaHabitual column: 'pcntrdhb'
            residenciaOcasional column: 'pcntrdoc'
            path column: 'pcntpath'
            facturar column: 'pcntfctr'
        }
    }

    static constraints = {
        empresa(blank: true, nullable: true)
        parroquia(blank: true, nullable: true)
        grupoSanguineo(blank: true, nullable: true)
        estadoCivil(blank: true, nullable: true)
        cedula(size:0..10,blank: true, nullable: true)
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
        alergias(size: 0..255, blank: true, nullable: true)
        habitosAlimentario(size: 0..255, blank: true, nullable: true)
        habitosUrinario(blank: true, nullable: true)
        habitosDefecatorio(blank: true, nullable: true)
        habitosFumador(size: 0..255, blank: true, nullable: true)
        habitosTomador(size: 0..255, blank: true, nullable: true)
        numeroHistorial(size: 0..6, blank: true, nullable: true)
        ocupacion(size: 0..255, blank: true, nullable: true)
        residenciaHabitual(size: 0..255, blank: true, nullable: true)
        residenciaOcasional(size: 0..255, blank: true, nullable: true)
        path(size: 0..255, blank: true, nullable: true)
        facturar(size: 0..255, blank: true, nullable: true)
    }

// no funciona Sql en el dominio
// def dataSource
//
//    def getConnection(){
//        Sql sql = new Sql(dataSource)
//        return sql
//    }


    def getEdad() {
        return Math.round( (new Date() - this.fechaNacimiento)/365.25.toDouble() *10 ) /10
//
//        def select = "select replace( replace(replace(age(now()::date, pcntfcna)::text, 'years', 'años'), 'mons','meses'), " +
//                "'days', 'dias') edad from pcnt where pcnt__id = ${this.id} "
//        def cn = getConnection()
//        def edad = cn.rows( select.toString() )[0].edad
//        return edad
    }

    def getObstetricia() {
        println "obstetricia: ${(new Date() - this.fechaNacimiento)/365.25 >= 6 && (this.sexo == 'F')}"
        return ( (new Date() - this.fechaNacimiento)/365.25 >= 6 && (this.sexo == 'F') )
    }

    def getNino() {
        return ( (new Date() - this.fechaNacimiento)/365.25 < 17 ) 
    }

    def getNinoNina() {
        if(this.nino){
            return this.sexo == 'M' ? 'Niño' : 'Niña'
        } else {
            return ''
        }
    }

}
