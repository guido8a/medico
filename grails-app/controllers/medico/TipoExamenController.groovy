package medico

class TipoExamenController {

    def list(){

    }

    def form_ajax(){

        def tipo

        if(params.id){
            tipo = TipoExamen.get(params.id)
        }else{
            tipo = new TipoExamen()
        }

        return [tipo: tipo]
    }

    def tablaTipoExamen_ajax(){

        def tipos

        if(params.grupo == 'null'){
            tipos = TipoExamen.findAllByDescripcionIlike('%' + params.criterio + '%', [sort: 'descripcion']).sort{a,b -> a.grupoExamen?.descripcion <=> b.grupoExamen?.descripcion ?: a.descripcion <=> b.descripcion}
        }else{
            def grupo = GrupoExamen.get(params.grupo)
            tipos = TipoExamen.findAllByGrupoExamenAndDescripcionIlike(grupo, '%' + params.criterio + '%', [sort: 'descripcion']).sort{a,b -> a.grupoExamen?.descripcion <=> b.grupoExamen?.descripcion ?: a.descripcion <=> b.descripcion}
        }

        return [tipos: tipos]
    }

    def save_ajax(){
        def tipo

        if(params.id){
            tipo = TipoExamen.get(params.id)
        }else{
            tipo = new TipoExamen()
        }

        tipo.properties = params

        if(!tipo.save(flush:true)){
            render "no_Error al guardar el tipo"
            println("Error al guardar el tipo " + tipo.errors)
        }else{
            render "ok_Guardado correctamente"
        }
    }

    def delete_ajax(){
        def tipo = TipoExamen.get(params.id)

        try{
            tipo.delete(flush:true)
            render "ok_Borrado correctamente"
        }catch(e){
            render "no_Error al borrar"
            println("error al borrar el tipo " + tipo.errors)
        }
    }

}
