package sri

import seguridad.Persona


class PeriodoController {

    def list(){

    }

    def tablaPeriodos_ajax(){
        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa
        def contabilidad = Contabilidad.findByInstitucion(empresa)
        def periodos = Periodo.findAllByContabilidad(contabilidad).sort{it.numero}
        return [periodos: periodos]
    }

    def form_ajax() {

        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa
        def contabilidad = Contabilidad.findByInstitucion(empresa)
        def periodos = Periodo.findAllByContabilidad(contabilidad)
        def ultimoNumero = (periodos?.last()?.numero ?: 0) + 1
        def periodo

        if(params.id){
            periodo = Periodo.get(params.id)
        }else{
            periodo = new Periodo()
        }

        return [periodo: periodo, ultimoNumero: ultimoNumero]
    }

    def create() {
        [periodoInstance: new Periodo(params)]
    }

    def save_ajax() {
        println "save periodo " + params
        def usuario = Persona.get(session.usuario.id)
        def empresa = usuario.empresa
        def contabilidad = Contabilidad.findByInstitucion(empresa)
        def periodos = Periodo.findAllByContabilidad(contabilidad)
        def ultimoNumero = (periodos?.last()?.numero ?: 0) + 1
        def periodoInstance

        if (params.fechaFin) {
            params.fechaFin = new Date().parse("dd-MM-yyyy", params.fechaFin)
        }

        if (params.fechaInicio) {
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }


        if(params.fechaFin && params.fechaInicio){

            if(params.fechaInicio < contabilidad.fechaInicio){
                render "er_La fecha de inicio ingresada es menor a la fecha de inicio de la contabilidad actual"
            }else{

                if(params.fechaFin > contabilidad.fechaCierre){
                    render "er_la fecha de fin ingresada es mayor a la fecha de cierre de la contabilidad actual"
                }else{

                    if(params.fechaInicio > params.fechaFin){
                        render "er_La fecha ingresada de inicio es mayor a la fecha de finalización"
                    }else{

                        if (params.id) {
                            periodoInstance = Periodo.get(params.id)
                        }else{
                            periodoInstance = new Periodo(params)
                            periodoInstance.contabilidad = contabilidad
                            periodoInstance.numero = ultimoNumero
                        }

                        periodoInstance.properties = params

                        if (!periodoInstance.save(flush: true)) {
                            render "no_Error al guardar el período"
                        }else{
                            render "ok_Período guardado correctamente"
                        }
                    }
                }
            }
        }else{
            render "no_Ingrese las fechas"
        }
    }


    def borrarPeriodo_ajax() {
        def periodoInstance = Periodo.get(params.id)

        if (!periodoInstance) {
            return true
        }

        try {
            periodoInstance.delete(flush: true)
            render "ok_Período borrado correctamente"
        }
        catch (e) {
            println("error al borrar el periodo " + e)
            render "no_Error al borrar el período "
        }
    }

    def revisarFecha_ajax() {
        println("params revisar fecha " + params)
        if(params.inicio && params.fin){
            def desde = new Date().parse("dd-MM-yyyy", params.inicio)
            def hasta = new Date().parse("dd-MM-yyyy", params.fin)

            if(desde > hasta){
                render "no"
            }else{
                render "ok"
            }
        }else{
            render "ok"
        }
    }



}
