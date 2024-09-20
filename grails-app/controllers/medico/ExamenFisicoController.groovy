package medico

import seguridad.Paciente


class ExamenFisicoController {

    def list(){
        def paciente = Paciente.get(params.id)
        return[paciente: paciente]
    }

    def form_ajax(){
        def historial = Historial.get(params.historial)
        def existe = ExamenFisico.findByHistorial(historial)
        def examen

        if(existe){
            examen = existe
        }else{
            examen = new ExamenFisico()
        }

        return [examen: examen, historial: historial]
    }

    def tablaExamenesFisicos_ajax(){
        def paciente = Paciente.get(params.id)
        def examenes = ExamenFisico.findAllByPaciente(paciente)
        return[paciente: paciente, examenes: examenes]
    }

    def saveExamenFisico_ajax(){
//        def paciente = Paciente.get(params.paciente)
        def historial = Historial.get(params.historial)
        def examen

        if(params.id){
            examen = ExamenFisico.get(params.id)
        }else{
            examen = new ExamenFisico()
            examen.historial = historial
        }

        if(params.fechaExamenFisico){
            params.fecha = new Date().parse("dd-MM-yyyy", params.fechaExamenFisico)
        }

        if(params.peso == '' || !params.peso){
            params.peso = 0
        }

        if(params.talla == '' || !params.talla){
            params.talla = 0
        }

        if(params.imc == '' || !params.imc){
            params.imc = 0
        }

        if(params.ic == '' || !params.ic){
            params.ic = 0
        }

        if(params.temperatura == '' || !params.temperatura){
            params.temperatura = 0
        }

        if(params.s02 == '' || !params.s02){
            params.s02 = 0
        }

        if(params.fc == '' || !params.fc){
            params.fc = 0
        }

        if(params.glucosa == '' || !params.glucosa){
            params.glucosa = 0
        }

        if(params.sistole1 == '' || !params.sistole1){
            params.sistole1 = 0
        }

        if(params.diastole1 == '' || !params.diastole1){
            params.diastole1 = 0
        }

        if(params.sistole2 == '' || !params.sistole2){
            params.sistole2 = 0
        }

        if(params.diastole2 == '' || !params.diastole2){
            params.diastole2 = 0
        }

        if(params.fc == '' || !params.fc){
            params.fc = 0
        }

        if(params.perimetroCefalico == '' || !params.perimetroCefalico){
            params.perimetroCefalico = 0
        }

        params.peso = params.peso.toDouble()
        params.talla = params.talla.toDouble()
        params.temperatura = params.temperatura.toDouble()
        params.imc = params.imc.toDouble()
        params.so2 = params.so2.toDouble()
        params.glucosa = params.glucosa.toDouble()
        params.sistole1 = params.sistole1.toDouble()
        params.diastole1 = params.diastole1.toDouble()
        params.sistole2 = params.sistole2.toDouble()
        params.diastole2 = params.diastole2.toDouble()
        params.fc = params.fc.toDouble()
        params.perimetroCefalico = params.perimetroCefalico.toDouble()


        examen.properties = params

        if(!examen.save(flush:true)){
            println("error al guardar el examen fisico " + examen.errors)
            render"no_Error al guardar el examen fisico"
        }else{
            render "ok_Examen guardado correctamente"
        }
    }

    def borrarExamenFisico_ajax(){
        def examen = ExamenFisico.get(params.id)

        if(examen){
            try{
                examen.delete(flush:true)
                render "ok_Examen borrado correctamente"
            }catch(e){
                println("Error al borrar el examen " + examen.errors)
                render"no_Error al borrar el examen"
            }
        }else{
            render "no_Examen no encontrado"
        }
    }


}
