package medico

import seguridad.Empresa

class MarcaController {

    def form_ajax(){
        println("params marca " + params)

        def empresa = Empresa.get(params.empresa)
        def marca

        if(params.id){
            marca = Marca.get(params.id)
        }else{
            marca = new Marca()
        }

        return [marca: marca, empresa: empresa]
    }

    def saveMarca_ajax(){

        def marca

        if(params.id){
            marca = Marca.get(params.id)
        }else{
            marca = new Marca()
        }

        marca.properties = params

        if(!marca.save(flush:true)){
            println("Error al guardar la marca " + marca.errors)
            render "no_Error al guardar la marca"
        }else{
            render "ok_Marca guardada correctamente"
        }
    }

}
