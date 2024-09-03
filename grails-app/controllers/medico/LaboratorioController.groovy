package medico

class LaboratorioController {

    def list(){

        def laboratorios = Laboratorio.list([sort: 'nombre'])
        return [laboratorios: laboratorios]

    }

    def form_ajax(){

        def laboratorio

        if(params.id){
            laboratorio = Laboratorio.get(params.id)
        }else{
            laboratorio = new Laboratorio()
        }

        return [laboratorio: laboratorio]
    }

    def saveLabo_ajax(){

        def laboratorio

        if(params.id){
            laboratorio = Laboratorio.get(params.id)
        }else{
            laboratorio = new Laboratorio()
        }

        laboratorio.properties = params


        if(!laboratorio.save(flush:true)){
            println("Error al guardar el laboratorio " + laboratorio.errors)
            render "no_Error al guardar el laboratorio"
        }else{
            render "ok_Laboratorio guardado correctamente"
        }
    }

    def borrarLabo_ajax(){

        def laboratorio = Laboratorio.get(params.id)

        try{
            laboratorio.delete(flush:true)
            render "ok_Laboratorio correctamente"
        }catch(e){
            println("Error al borrar el laboratorio " + laboratorio.errors)
            render "no_Error al borrar el tipo"
        }
    }


}
