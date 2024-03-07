package medico

class ExamenController {

    def list(){
        def examenes = Examen.list().sort{it.descripcion}
        return [examenes: examenes]
    }

    def form_ajax(){
        def examen

        if(params.id){
            examen = Examen.get(params.id)
        }else{
            examen = new Examen()
        }

        return[examen: examen]
    }


    def save_ajax(){
        def examen

        if(params.id){
            examen = Examen.get(params.id)
        }else{
            examen = new Examen()
        }

        examen.properties = params

        if(!examen.save(flush:true)){
            render "no_Error al guardar el examen"
            println("Error al guardar el examen")
        }else{
            render "ok_Guardado correctamente"
        }
    }

    def delete_ajax(){

        def examen = Examen.get(params.id)

        try{
            examen.delete(flush:true)
            render "ok_Borrado correctamente"
        }catch(e){
            render "no_Error al borrar"
            println("error al borrar el examen")
        }

    }


}
