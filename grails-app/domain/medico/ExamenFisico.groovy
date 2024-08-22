package medico

import seguridad.Paciente

class ExamenFisico {

    Historial historial
    Date fecha
    String cabeza
    String cuello
    String torax
    String cardioPulmonar
    String abdomen
    String regionLumbar
    String genitales
    String extremidadesSuperiores
    String extremidadesInferiores
    String neurologico
    double peso
    double talla
    double imc
    double ic
    double temperatura
    double so2
    double fc
    double glucosa
    int sistole1 = 0
    int diastole1 = 0
    int sistole2 = 0
    int diastole2 = 0
    String cabezaCraneo
    String cabezaCara
    String pielFaneras
    double perimetroCefalico = 0

    static mapping = {
        table 'exfs'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'exfs__id'
        id generator: 'identity'
        version false
        columns {
            historial column: 'hscl__id'
            fecha column: 'exfsfcha'
            cabeza column: 'exfscbza'
            cuello column: 'exfscllo'
            torax column: 'exfstrax'
            cardioPulmonar column: 'exfscrpl'
            abdomen column: 'exfsabdm'
            regionLumbar column: 'exfsrglb'
            genitales column: 'exfsgntl'
            extremidadesSuperiores column: 'exfsexsp'
            extremidadesInferiores column: 'exfsexif'
            neurologico column: 'exfsneur'
            peso column: 'exfspeso'
            talla column: 'exfstlla'
            imc column: 'exfs_imc'
            ic column: 'exfs__ic'
            temperatura column: 'exfs___t'
            so2 column: 'exfs_so2'
            fc column: 'exfs__fc'
            glucosa column: 'exfsglcs'
            sistole1 column: 'exfstas1'
            diastole1 column: 'exfstad1'
            sistole2 column: 'exfstas2'
            diastole2 column: 'exfstad2'
            cabezaCraneo column: 'exfscbcn'
            cabezaCara column: 'exfscbca'
            pielFaneras column: 'exfsplfn'
            perimetroCefalico column: 'exfsprcf'
        }
    }

    static constraints = {
        historial(blank: false, nullable: false)
        fecha(blank: false, nullable: false)
        cabeza(size: 0..255, blank: true, nullable: true)
        cuello(size: 0..255, blank: true, nullable: true)
        torax(size: 0..255, blank: true, nullable: true)
        cardioPulmonar(size: 0..255, blank: true, nullable: true)
        abdomen(size: 0..255, blank: true, nullable: true)
        regionLumbar(size: 0..255, blank: true, nullable: true)
        genitales(size: 0..255, blank: true, nullable: true)
        extremidadesSuperiores(size: 0..255, blank: true, nullable: true)
        extremidadesInferiores(size: 0..255, blank: true, nullable: true)
        neurologico(size: 0..255, blank: true, nullable: true)
        peso(blank: true, nullable: true)
        talla(blank: true, nullable: true)
        imc(blank: true, nullable: true)
        ic(blank: true, nullable: true)
        temperatura(blank: true, nullable: true)
        so2(blank: true, nullable: true)
        fc(blank: true, nullable: true)
        glucosa(blank: true, nullable: true)
        sistole1(blank: true, nullable: true)
        diastole1(blank: true, nullable: true)
        sistole2(blank: true, nullable: true)
        diastole2(blank: true, nullable: true)
        cabezaCraneo(size: 0..255, blank: true, nullable: true)
        pielFaneras(size: 0..255, blank: true, nullable: true)
        perimetroCefalico(blank: true, nullable: true)
    }
}
