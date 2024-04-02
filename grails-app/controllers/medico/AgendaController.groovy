package medico

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

            def sql = "select * from agenda(${semana.id}, ${doctor?.id}, 1)"
            def resp = cn.rows(sql.toString())

            println("sql " + sql)

            return[horario: resp, clases: clases, existe: true, profesor: doctor, horas: horas, dias: dias]
        }else{
            return[existe: false]
        }
    }


}
