package medico

import seguridad.Paciente
import seguridad.Persona

class AgendaController {

    def dbConnectionService

    def agenda(){

    }

    def tabla_ajax(){
        println("tabla_ajax " + params)

        def cn = dbConnectionService.getConnection()

        if(params.semana){
            def semana = Semana.get(params.semana)
            def doctor = Persona.get(params.doctor)
            def clases = []
            def horas = Hora.list([sort: 'numero'])
            def dias  = Dias.list([sort: 'numero'])

            def sql = "select * from agenda(${doctor?.id}, ${semana.id})"
            def resp = cn.rows(sql.toString())

            return[horario: resp, clases: clases, existe: true, profesor: doctor, horas: horas, dias: dias, semana: semana]
        }else{
            return[existe: false]
        }
    }

    def paciente_ajax(){
        def semana = Semana.get(params.semana)
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
        def agenda
        def cita
        def semana = Semana.get(params.semana)
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
                //cita
                cita = new Historial()
                cita.agenda = agenda
                cita.fecha = fecha
                cita.paciente = agenda.paciente
                cita.persona = agenda.persona
                cita.motivo = 'Ingresar el motivo....'
                if(!cita.save(flush:true)){
                    agenda.delete(flush:true)
                    println("error al agendar la cita " + cita.errors)
                    render "no_Error al agendar la cita"
                }else{
                    render "ok_Cita agendada correctamente"
                }
            }
        }
    }

    def borrarCita_ajax(){
        def agenda = Agenda.get(params.id)

        try{
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
        redirect(controller: 'historial', action: 'cita', params:[paciente: paciente?.id, id:cita?.id])
    }


}
