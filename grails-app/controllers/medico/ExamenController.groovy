package medico

import grails.converters.JSON
import seguridad.Empresa
import seguridad.Paciente

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

class ExamenController {

    def ancho = 0
    def alto = 0
    byte[] imagenBytes

    def dbConnectionService

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
        def examenes = Examen.findAllByTipoExamen(tipo).sort{it.numero}
        def examen = ExamenComplementario.get(params.examen)
        def chequeados = DetalleExamen.findAllByExamenComplementario(examen)

        return [examenes:examenes, examenComplementario: examen, chequeados: chequeados?.examen]
    }

    def prueba() {
        def cn = dbConnectionService.getConnection()
        def id = 4
        def edad = (new Date() - Paciente.get(id).fechaNacimiento)/365.25
        def sql = "select exfspeso, exfstlla * 100 exfstlla, exfs_imc from exfs, hscl where pcnt__id = ${id} and " +
                "exfs.hscl__id = hscl.hscl__id and exfsfcha = (select max(exfsfcha) from exfs, hscl " +
                "where pcnt__id = 4 and exfs.hscl__id = hscl.hscl__id)"
        def data = cn.rows(sql.toString())[0]
        println "--> $data , edad: $edad"

        edad = (690-108)/18 * (edad - 2) + 108
//        data.exfstlla = Math.floor( 841 - (data.exfstlla - 70) / 5 * 24 )
        data.exfstlla = Math.floor( (841 - (data.exfstlla - 75.0) / 5 * 31) )

        data.exfspeso = Math.round( 1028 - (data.exfspeso - 10 ) / 5 * 31 )
        println "*--> $data , edad: $edad"
        imagenBytes = im()
        [ancho: ancho, alto: alto, edad: edad, data: data, jdata: data as JSON]
    }

    def getImage() {
        response.with{
            setHeader('Content-length', imagenBytes.length.toString())
            contentType = "image/${'png'}" // or the appropriate image content type
            outputStream << imagenBytes
            outputStream.flush()
        }
    }

    byte[] im() {
        def path = "/var/medico/ninos2a20.png"
        BufferedImage imagen = ImageIO.read(new File(path));
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        def fileext = path.substring(path.indexOf(".")+1, path.length())
        ancho = imagen.getWidth()
        alto = imagen.getHeight()
        println "carga imagen y define tamaños $ancho, $alto"
        ImageIO.write( imagen, fileext, baos );
        baos.flush();

        params.ancho = ancho
        baos.toByteArray()
    }

    def graficoNina_ajax(){
        def paciente = Paciente.get(params.paciente)

        def cn = dbConnectionService.getConnection()
        def id = paciente?.id
        def edad = (new Date() - Paciente.get(id).fechaNacimiento)/365.25
        def sql = "select exfspeso, exfstlla * 100 exfstlla, exfs_imc from exfs, hscl where pcnt__id = ${id} and " +
                "exfs.hscl__id = hscl.hscl__id and exfsfcha = (select max(exfsfcha) from exfs, hscl " +
                "where pcnt__id = ${id} and exfs.hscl__id = hscl.hscl__id)"
        def data = cn.rows(sql.toString())[0]
        println "--> $data , edad: $edad"

        edad = (690-108)/18 * (edad - 2) + 108
        data.exfstlla = Math.floor( (841 - (data.exfstlla - 75.0) / 5 * 31) )

        data.exfspeso = Math.round( 1028 - (data.exfspeso - 10 ) / 5 * 31 )
        println "*--> ${data as JSON} , edad: ${[edad]}"
        imagenBytes = im()

        return [paciente: paciente, ancho: ancho, alto: alto, edad: edad, data: data, jdata: data as JSON]
    }


}
