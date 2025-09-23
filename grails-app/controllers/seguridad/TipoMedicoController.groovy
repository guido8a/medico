package seguridad

class TipoMedicoController {

    def list(){
        def tipos = TipoMedico.list().sort{it.descripcion}
        return [tipos: tipos]
    }

    def form_ajax(){
        def tipo

        if(params.id){
            tipo = TipoMedico.get(params.id)
        }else{
            tipo = new TipoMedico()
        }

        return [tipo: tipo]
    }

    def saveTipo_ajax(){

        def tipo

        if(params.id){
            tipo = TipoMedico.get(params.id)
        }else{
            tipo = new TipoMedico()
        }

        params.codigo = params.codigo.toUpperCase();

        tipo.properties = params


        if(!tipo.save(flush:true)){
            println("Error al guardar el tipo " + tipo.errors)
            render "no_Error al guardar el tipo"
        }else{
            render "ok_Tipo guardado correctamente"
        }
    }

    def borrarTipo_ajax(){

        def tipo = TipoMedico.get(params.id)

        try{
            tipo.delete(flush:true)
            render "ok_Borrado correctamente"
        }catch(e){
            println("Error al borrar el tipo " + tipo.errors)
            render "no_Error al borrar el tipo"
        }
    }

}
