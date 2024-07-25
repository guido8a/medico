package medico

import seguridad.Paciente
import seguridad.Persona
import seguridad.TipoPersona

class AgendaController {

    def dbConnectionService

    def agenda(){
        def usuario = Persona.get(session.usuario.id)
        def tipoPersona = TipoPersona.findAllByCodigoInList(['E', 'M'])
        def consultorio = usuario.empresa
        [paciente: params.paciente, consultorio: consultorio, usuario: usuario, tipo: tipoPersona]
    }

    def tabla_ajax(){
        println("tabla_ajax " + params)
        def fcha = new Date().parse("dd-MM-yyyy", params.fecha)
        def cn = dbConnectionService.getConnection()
        def smna = buscaSemana(params.fecha)
        def sql = ""
        println "semana --> $smna"

        if(smna){
            def semana = Semana.get(smna)
            def doctor = Persona.get(params.doctor)
            def horas = Hora.list([sort: 'numero'])
            def dias  = Dias.list([sort: 'numero'])

            sql = "select * from agenda(${doctor?.id}, ${smna})"
            def resp = cn.rows(sql.toString())

            return[horario: resp, existe: true, horas: horas, dias: dias, semana: semana, indice: (fcha - semana.fechaInicio)]
        }else{
            return[existe: false]
        }
    }

    def paciente_ajax(){
        println "paciente_ajax: $params"
        def semana = Semana.get( buscaSemana(params.fecha) )
        def doctor = Persona.get(params.doctor)
        def agenda

        if(params.id){
            agenda = Agenda.get(params.id)
            return[semana: semana, persona: doctor, dia: agenda?.dias, hora: agenda?.hora, agenda: agenda]
        }else{
            def dia = Dias.get(params.dia)
            def hora = Hora.get(params.hora)
            agenda = new Agenda();
            return[semana: semana, persona: doctor, dia: dia, hora: hora, agenda: agenda]
        }
    }

    def saveAgenda_ajax(){
        def semana = Semana.get(params.semana)

        def agenda
        def cita
        def hora = Hora.get(params.hora)
        def dias = Dias.get(params.dias)
        def fecha = semana.fechaInicio + (dias.numero - 1)

        def parte = hora.descripcion.split("-")
        def parte2 = parte[0].split(":")

        fecha.setMinutes(parte2[1]?.toInteger())
        fecha.setHours(parte2[0]?.toInteger())

        if(params.id){
            agenda = Agenda.get(params.id)
        }else{
            agenda = new Agenda()
            agenda.fechaInicio = new Date();
        }

        agenda.properties = params

        if(!agenda.save(flush: true)){
            println("error al agendar la cita " + agenda.errors)
            render "no_Error al agendar la cita"
        }else{
            if(params.id){
                render "ok_Cita agendada correctamente"
            }else{

                def consultorio = Persona.get(agenda.persona.id)?.empresa
                def numeroActual = consultorio?.numero

                //cita
                cita = new Historial()
                cita.agenda = agenda
                cita.fecha = fecha
                cita.hora = fecha.format('HH:mm')
                cita.paciente = agenda.paciente
                cita.persona = agenda.persona
                cita.motivo = 'Cita médica agendada'
                cita.numero = numeroActual + 1
                if(!cita.save(flush:true)){
                    agenda.delete(flush:true)
                    println("error al agendar la cita " + cita.errors)
                    render "no_Error al agendar la cita"
                }else{
                    if(!params.id){
                        consultorio.numero = numeroActual + 1
                        consultorio.save(flush:true)
                    }
                    render "ok_Cita agendada correctamente"
                }
            }
        }
    }

    def borrarCita_ajax(){
        def agenda = Agenda.get(params.id)
        def cita = Historial.findByAgenda(agenda)

        try{
            cita.delete(flush:true)
            agenda.delete(flush: true)
            render "ok_Borrado correctamente"
        }catch(e){
            println("error al borrar la cita " + agenda.errors)
            render "no_Error al borrar la cita"
        }
    }

    def nombre_ajax(){
        def doctor = Persona.get(params.id)
        render "" + doctor?.apellido + " " + doctor?.nombre
    }

    def redireccion_ajax(){
        def agenda = Agenda.get(params.id)
        def cita = Historial.findByAgenda(agenda)
        def paciente = agenda.paciente
//        redirect(controller: 'historial', action: 'cita', params:[paciente: paciente?.id, id:cita?.id])
        redirect(controller: 'paciente', action: 'historial', params:[id: paciente?.id, cita:cita?.id])
    }

    def buscaSemana(fecha) {
        def cn = dbConnectionService.getConnection()
        def fcha = new Date().parse("dd-MM-yyyy", fecha)
        def sql = "select smna__id from smna where '${fcha.format('yyyy-MM-dd')}' between smnafcin and smnafcfn"
        def smna = cn.rows(sql.toString())[0].smna__id
        return smna
    }

    def agendaNuevo(){

    }

    def tablaAgendamiento_ajax(){
        def datos
        if(params.tipo == '1'){
            datos = 1
        }else{
            datos = null
        }

        return [datos: datos]
    }

    def agnd_semana(){
        def usuario = Persona.get(session.usuario.id)
        def consultorio = usuario.empresa
        [consultorio: consultorio, usuario: usuario]
    }

    def tabla_agnd_ajax(){
        println("tabla_agnd_ajax " + params)
        def fcha = new Date().parse("dd-MM-yyyy", params.fecha)
        def cn = dbConnectionService.getConnection()
        def smna = buscaSemana(params.fecha)
        def usuario = Persona.get(session.usuario.id)
        def consultorio = usuario.empresa
        def sql = ""
        println "semana --> $smna"

        if(smna){
            def semana = Semana.get(smna)
            def doctor = Persona.get(params.doctor)
            def horas = Hora.list([sort: 'numero'])
            def dias  = Dias.list([sort: 'numero'])

            sql = "select * from agnd_semana(${consultorio?.id}, ${smna})"
            println "sql: $sql"
            def resp = cn.rows(sql.toString())

            return[horario: resp, existe: true, horas: horas, dias: dias, semana: semana, indice: (fcha - semana.fechaInicio)]
        }else{
            return[existe: false]
        }
    }

    def citasMedico_ajax () {

        def arreglo = params.citas.split(",")
        def citas = []

        arreglo.each {
            citas.add(Agenda.get(it))
        }

        return [citas: citas]
    }

}
