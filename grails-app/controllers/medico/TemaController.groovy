package medico

class TemaController {

    def list(){

    }

    def form_ajax(){
        def tema
        if(params.id){
            tema = Tema.get(params.id)
        }else{
            tema = new Tema()
        }
        return [tema: tema]
    }

    def tablaTema_ajax() {

        def temas

        if(params.criterio != ''){
            temas = Tema.findAllByNombreIlike('%' + params.criterio + '%')
        }else{
            temas = Tema.list([sort: 'nombre'])
        }

        return [temas: temas]
    }


    def saveTema_ajax(){

        def tema

        if(params.id){
            tema = Tema.get(params.id)
        }else{
            tema = new Tema()
        }

        tema.properties = params

        if(!tema.save(flush:true)){
            render "no_Error al guardar el tema"
            println("Error al guardar el tema " + tema.errors)
        }else{
            render "ok_Tema guardado correctamente"
        }
    }

    def borrarTema_ajax(){
        def tema = Tema.get(params.id)

        if(tema){
            try{
                tema.delete(flush:true)
                render"ok_Tema borrado correctamente"
            }catch(e){
                render "no_Error al borrar el tema"
                println("Error al borrar el tema" + tema.errors)
            }
        }else{
            render "no_Error no existe el tema"
        }
    }

}
