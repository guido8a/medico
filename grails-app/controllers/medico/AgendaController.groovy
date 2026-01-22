package medico

import seguridad.Empresa
import seguridad.Paciente
import seguridad.Persona
import seguridad.TipoMedico

class AgendaController {

    def dbConnectionService

    def agenda() {
        println "agenda"
        def usuario = Persona.get(session.usuario?.id)
        def tipoPersona = TipoMedico.findAllByCodigoInList(['E', 'M'])
        def consultorio = usuario.empresa
        println "tpmd: ${tipoPersona.id}"
        [paciente: params.paciente, consultorio: consultorio, usuario: usuario, tipo: tipoPersona, cita_actual: params.cita]
    }

    def tabla_ajax() {
        println("tabla_ajax " + params)
        def fcha = new Date().parse("dd-MM-yyyy", params.fecha)
        def cn = dbConnectionService.getConnection()
        def smna = buscaSemana(params.fecha)
        def sql = ""
        println "semana --> $smna"

        if (smna) {
            def semana = Semana.get(smna)
            def doctor = Persona.get(params.doctor)
            def horas = Hora.list([sort: 'numero'])
            def dias = Dias.list([sort: 'numero'])

            sql = "select * from agenda(${doctor?.id}, ${smna})"
            println "sql: $sql"
            def resp = cn.rows(sql.toString())

            return [horario: resp, existe: true, horas: horas, dias: dias, semana: semana, indice: (fcha - semana.fechaInicio)]
        } else {
            return [existe: false]
        }
    }

    def paciente_ajax() {
        println "paciente_ajax: $params"
        def semana = Semana.get(buscaSemana(params.fecha))
        def doctor = Persona.get(params.doctor)
        def agenda

        if (params.id) {
            agenda = Agenda.get(params.id)
            return [semana: semana, persona: doctor, dia: agenda?.dias, hora: agenda?.hora, agenda: agenda]
        } else {
            def dia = Dias.get(params.dia)
            def hora = Hora.get(params.hora)
            agenda = new Agenda();
            return [semana: semana, persona: doctor, dia: dia, hora: hora, agenda: agenda]
        }
    }

    def saveAgenda_ajax() {

        println("params " + params)

        def existe
        def semana = Semana.get(params.semana)
        def agenda
        def cita
        def hora = Hora.get(params.hora)
        def dias = Dias.get(params.dias)
        def fecha = semana.fechaInicio + (dias.numero - 1)
        def paciente = Paciente.get(params.paciente)

        if(!paciente){
            render "no_Seleccione un paciente"
            return false
        }

        def parte = hora.descripcion.split("-")
        def parte2 = parte[0].split(":")

        fecha.setMinutes(parte2[1]?.toInteger())
        fecha.setHours(parte2[0]?.toInteger())

        if (params.id) {
            agenda = Agenda.get(params.id)
        } else {
            existe = Agenda.findByDiasAndHoraAndPacienteAndSemana(dias, hora, paciente, semana)

            if (existe) {
                render "no_El día y horario ya se encuentran agendados para ese paciente"
                return
            } else {
                agenda = new Agenda()
                agenda.fechaInicio = new Date();
            }
        }

        agenda.properties = params

        if (!agenda.save(flush: true)) {
            println("error al agendar la cita " + agenda.errors)
            render "no_Error al agendar la cita"
        } else {
            if (params.id) {
                cita = Historial.get(params.idCita)
                cita.motivo = params.motivo
                if(!cita.save(flush:true)){
                    println("error al agendar la cita " + cita.errors)
                    render "no_Error al agendar la cita"
                }else{
                    render "ok_Cita agendada correctamente"
                }
            } else {

                def consultorio = Persona.get(agenda.persona.id)?.empresa
                def numeroActual = consultorio?.numero

                //cita
                cita = new Historial()
                cita.agenda = agenda
                cita.fecha = fecha
                cita.hora = fecha.format('HH:mm')
                cita.paciente = agenda.paciente
                cita.persona = agenda.persona
                cita.motivo = params.motivo
                cita.numero = numeroActual + 1
                if (!cita.save(flush: true)) {
                    agenda.delete(flush: true)
                    println("error al agendar la cita " + cita.errors)
                    render "no_Error al agendar la cita"
                } else {
                    if (!params.id) {
                        consultorio.numero = numeroActual + 1
                        consultorio.save(flush: true)
                    }
                    render "ok_Cita agendada correctamente"
                }
            }
        }
    }

    def borrarCita_ajax() {
        def agenda = Agenda.get(params.id)
        def cita = Historial.findByAgenda(agenda)

        try {
            cita.delete(flush: true)
            agenda.delete(flush: true)
            render "ok_Borrado correctamente"
        } catch (e) {
            println("error al borrar la cita " + agenda.errors)
            render "no_Error al borrar la cita"
        }
    }

    def nombre_ajax() {
        def doctor = Persona.get(params.id)
        render "" + doctor?.apellido + " " + doctor?.nombre
    }

    def redireccion_ajax() {
        def agenda = Agenda.get(params.id)
        def cita = Historial.findByAgenda(agenda)
        def paciente = agenda.paciente
//        redirect(controller: 'historial', action: 'cita', params:[paciente: paciente?.id, id:cita?.id])
        redirect(controller: 'paciente', action: 'historial', params: [id: paciente?.id, cita: cita?.id])
    }

    def buscaSemana(fecha) {
        def cn = dbConnectionService.getConnection()
        def fcha = new Date().parse("dd-MM-yyyy", fecha)
        def sql = "select smna__id from smna where '${fcha.format('yyyy-MM-dd')}' between smnafcin and smnafcfn"
        def smna = cn.rows(sql.toString())[0].smna__id
        return smna
    }

    def agendaNuevo() {

    }

    def tablaAgendamiento_ajax() {
        def datos
        if (params.tipo == '1') {
            datos = 1
        } else {
            datos = null
        }

        return [datos: datos]
    }

    def agnd_semana() {
        def usuario = Persona.get(session.usuario?.id)
        def consultorio = usuario.empresa
        def paciente = Paciente.get(params.paciente)
        [consultorio: consultorio, usuario: usuario, paciente: paciente]
    }

    def tabla_agnd_ajax() {
        println("tabla_agnd_ajax " + params)
        def fcha = new Date().parse("dd-MM-yyyy", params.fecha)
        def cn = dbConnectionService.getConnection()
        def smna = buscaSemana(params.fecha)
        def usuario = Persona.get(session.usuario?.id)
        def consultorio = usuario.empresa
        def sql = ""
        println "semana --> $smna"

        if (smna) {
            def semana = Semana.get(smna)
            def doctor = Persona.get(params.doctor)
            def horas = Hora.list([sort: 'numero'])
            def dias = Dias.list([sort: 'numero'])

            sql = "select * from agnd_semana(${consultorio?.id}, ${smna})"
            println "sql: $sql"
            def resp = cn.rows(sql.toString())

            return [horario: resp, existe: true, horas: horas, dias: dias, semana: semana, indice: (fcha - semana.fechaInicio)]
        } else {
            return [existe: false]
        }
    }

    def citasMedico_ajax() {

        def arreglo = params.citas.split(",")
        def citas = []

        arreglo.each {
            citas.add(Agenda.get(it))
        }

        return [citas: citas]
    }

    def buscarPaciente_ajax() {

    }

    def tablaListaPacientes_ajax() {
//        def listaItems = ['pcntnmbr', 'pcntappl', 'pcntcdla']
//        def bsca
//        def sqlTx = ""
//
//        if(params.buscarPor){
//            bsca = listaItems[params.buscarPor?.toInteger()-1]
//        }else{
//            bsca = listaItems[0]
//        }
//
//        def select = "select * from pcnt "
//        def txwh = " where pcnt__id  is not null and " +
//                " $bsca ilike '%${params.criterio}%' "
//        sqlTx = "${select} ${txwh} order by pcntapll limit 100".toString()
//        def cn = dbConnectionService.getConnection()
//        def datos = cn.rows(sqlTx)
//
//        [datos: datos]


        def empresa

        if (params.empresa != '0') {
            empresa = Empresa.get(params.empresa)
        } else {
            empresa = null
        }

        def listaItems = ['pcntcdla', 'pcntapll', 'pcntnmbr']
        def bsca
        def sqlTx = ""
        def bscaEmp = empresa ? " and empr__id = ${empresa?.id}" : " "

        if (params.buscarPor) {
            bsca = listaItems[params.buscarPor?.toInteger() - 1]
        } else {
            bsca = listaItems[0]
        }

//        def select = "select pcnt__id, pcntcdla, pcntapll, pcntpath, pcntnmbr, " +
//                "replace( replace( replace(replace(age(now()::date, pcntfcna)::text, 'year', 'año'), 'mons','meses'), " +
//                "'day', 'dia'), 'mon', 'mes') edad, " +
//                "grsndscr, pcntmail, pcntantc from pcnt, grsn "
        def select = "select pcnt__id, pcntcdla, pcntapll, pcntnmbr from pcnt, grsn "

        def criterio = params.criterio

        def txwh = ""
        try {
            criterio = params.criterio.toInteger()
            txwh = " where grsn.grsn__id = pcnt.grsn__id and " +
                    "pcntcdla ilike '%${params.criterio}%'"
        } catch (e) {
            txwh = " where grsn.grsn__id = pcnt.grsn__id and " +
                    "(pcntnmbr ilike '%${criterio}%' or pcntapll ilike '%${criterio}%')"
        }
        sqlTx = "${select} ${txwh} ${bscaEmp} order by pcntapll limit 50 ".toString()
        println "sql: ${sqlTx}"
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)
//        println datos

        [datos: datos]
    }

    def calendario() {

        println("params calen " + params)

        def anio =  new Date().format('yyyy').toInteger()
        def paciente = Paciente.get(params.paciente)
//        def agendas = Agenda.findAllByPaciente(paciente)
        def citas = Historial.findAllByPaciente(paciente)
        def anios = []

        if(citas){
//            def citas = Historial.findAllByAgendaInList(agendas)
            citas.each {
                anios +=  it.fecha.format("yyyy")
            }
        }

        if (!params.anio) {
            params.anio = anio
        }

        return [anio: anio, params: params, paciente: paciente, anios: anios?.unique()]
    }



    def tablaCalendario_ajax() {

        println("params calen " + params)

        def cn = dbConnectionService.getConnection()
        def anio =  new Date().format('yyyy').toInteger()
        def paciente = Paciente.get(params.paciente)

        if (!params.anio) {
            params.anio = anio
        }

        def meses = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
        def fcin = new Date().parse("dd-MM-yyyy", "01-01-${params.anio}")
        def fcfn = new Date().parse("dd-MM-yyyy", "31-12-${params.anio}")

        def dias = []
        def fecha = fcin
        def hoy = new Date()
        def cont = 1
        def fds = ["sat", "sun"]
        def fmt = new java.text.SimpleDateFormat("EEE", new Locale("en"))
//        def sql = "select hsclfcha fecha, hscl.hscl__id id from agnd, hscl " +
//                "where agnd.agnd__id = hscl.agnd__id and agnd.pcnt__id = '${paciente?.id}' " +
//                "order by 1"
        def sql = "select hsclfcha fecha, hscl__id id, hsclmotv motivo, hsclhora hora " +
                "from hscl where pcnt__id = '${paciente?.id}' order by 1"

        def citas = [:]
        def dd = [:]
        def motivos = [:]
        cn.eachRow(sql.toString()) { d ->
            citas[d.fecha?.format("yyyy-MM-dd")] = "HORA: "  + d.hora + '\n'  + "MOTIVO: " +d.motivo
            dd[d.fecha?.format("yyyy-MM-dd")] = d.id
        }

        def diasSem = ["mon": 1, "tue": 2, "wed": 3, "thu": 4, "fri": 5, "sat": 6, "sun": 0]
        def dia = 0, obsr = ""
        while (fecha <= fcfn) {
            dia = fmt.format(fecha).toLowerCase()
            dias.add(id: citas[],
                    fecha: fecha,
                    dia: diasSem[dia],
                    idH: dd[fecha.format('yyyy-MM-dd')]?:'',
                    obsr: '',
                    cita: citas[fecha.format('yyyy-MM-dd')]?:'',
                    titl: citas[fecha.format('yyyy-MM-dd')]?:'')
            fecha++
            cont++
        }

        cn.close()
        return [anio: anio, dias: dias, meses: meses, params: params, hoy: hoy, paciente: paciente]
    }


}
