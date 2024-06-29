package medico

import seguridad.Empresa

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

class ExamenController {

    def ancho = 0
    def alto = 0

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

    def tipoExamen_ajax(){
        def grupo = GrupoExamen.get(params.grupo)
        def tipos = TipoExamen.findAllByGrupoExamen(grupo)
        def examen = ExamenComplementario.get(params.examen)
        return [tipos:tipos, examenComplementario: examen]
    }

    def examen_ajax(){
        def tipo = TipoExamen.get(params.tipo)
        def examenes = Examen.findAllByTipoExamen(tipo)
        def examen = ExamenComplementario.get(params.examen)
        def chequeados = DetalleExamen.findAllByExamenComplementario(examen)

        return [examenes:examenes, examenComplementario: examen, chequeados: chequeados?.examen]
    }

    def prueba() {

    }

    def getImage() {
        byte[] imageInBytes = im()
        params.ancho = ancho
        params.alto = alto
        response.with{
            setHeader('Content-length', imageInBytes.length.toString())
            contentType = "image/${'png'}" // or the appropriate image content type
            outputStream << imageInBytes
            outputStream.flush()
        }
    }

    def gettamano() {
        def data = "${ancho}_${alto}"
        response.with{
            setHeader('Content-length', data.size())
            contentType = "text" // or the appropriate image content type
            outputStream << data
            outputStream.flush()
        }
    }

    byte[] im() {
//        ByteArrayOutputStream baos = new ByteArrayOutputStream()
//        ImageIO.write(ImageIO.read(new File("/var/medico/ninos2a20.png")), 'png'.toString(), baos)
//        baos.toByteArray()


        def path = "/var/medico/ninos2a20.png"
        BufferedImage imagen = ImageIO.read(new File(path));
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        def fileext = path.substring(path.indexOf(".")+1, path.length())
        ancho = imagen.getWidth()
        alto = imagen.getHeight()
        ImageIO.write( imagen, fileext, baos );
        baos.flush();

        params.ancho = ancho
        baos.toByteArray()
    }


}
