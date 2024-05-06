package medico

import seguridad.Persona


class DocumentoController {

    def dbConnectionService

    def biblioteca(){
        def usuario = Persona.get(session.usuario.id)
        return [usuario: usuario]
    }


    def tablaBiblioteca_ajax(){

        def usuario = Persona.get(session.usuario.id)

        def bsca
        def sqlTx = ""

        def select = "select * from dcmt "
        def txwh = " where empr__id  = '${usuario.empresa.id}' and " +
                " dcmtdscr ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} order by dcmtdscr limit 100".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]

    }

    def form_ajax(){

        def documentoInstance
        def empresa = Persona.get(session.usuario.id)?.empresa?.id

        if(params.id){
            documentoInstance = Documento.get(params.id)
        }else{
            documentoInstance = new Documento()
        }

        return [documentoInstance: documentoInstance, empresa: empresa]
    }


    def saveDocumento_ajax(){
        def documento

        if(params.id){
            documento = Documento.get(params.id)
        }else{
            documento = new Documento()
        }

        documento.properties = params

        if(!documento.save(flush:true)){
            println("error al guardar el documento")
            render "no_Error al guardar el documento"
        }else{
            render "ok_Documento guardado correctamente"
        }
    }


}
