package medico


class SubtemaController {

    def list(){

    }

    def form_ajax(){
        def subTema
        if(params.id){
            subTema = Subtema.get(params.id)
        }else{
            subTema = new Subtema()
        }
        return [subTema: subTema]
    }

    def tablaSubtema_ajax() {

        def subTemas

        if(params.tema == 'null'){
            if(params.critero == ''){
                subTemas = Subtema.list([sort: 'nombre'])
            }else{
                subTemas = Subtema.findAllByNombreIlike('%' + params.criterio + '%')
            }
        }else{
            def tema = Tema.get(params.tema)
            if(params.critero == ''){
                subTemas = Subtema.findAllByTema(tema).sort{it.nombre}
            }else{
                subTemas = Subtema.findAllByNombreIlikeAndTema('%' + params.criterio + '%', tema)
            }
        }

        return [subTemas: subTemas]
    }


    def saveSubTema_ajax(){

        def subtema

        if(params.id){
            subtema = Subtema.get(params.id)
        }else{
            subtema = new Subtema()
        }

        subtema.properties = params

        if(!subtema.save(flush:true)){
            render "no_Error al guardar el Subtema"
            println("Error al guardar el Subtema " + subtema.errors)
        }else{
            render "ok_Subtema guardado correctamente"
        }
    }

    def borrarSubTema_ajax(){
        def subtema = Subtema.get(params.id)

        if(subtema){
            try{
                subtema.delete(flush:true)
                render"ok_Subtema borrado correctamente"
            }catch(e){
                render "no_Error al borrar el Subtema"
                println("Error al borrar el Subtema" + subtema.errors)
            }
        }else{
            render "no_Error no existe el Subtema"
        }
    }

}
