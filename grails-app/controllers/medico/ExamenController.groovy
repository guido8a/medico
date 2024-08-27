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
                "where pcnt__id = ${id} and exfs.hscl__id = hscl.hscl__id)"
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
            contentType = "image/${'jpeg'}" // or the appropriate image content type
            outputStream << imagenBytes
            outputStream.flush()
        }
    }

    def getImage2() {
        response.with{
            setHeader('Content-length', imagenBytes.length.toString())
            contentType = "image/${'jpeg'}" // or the appropriate image content type
            outputStream << imagenBytes
            outputStream.flush()
        }
    }
    def getImage3() {
        response.with{
            setHeader('Content-length', imagenBytes.length.toString())
            contentType = "image/${'jpeg'}" // or the appropriate image content type
            outputStream << imagenBytes
            outputStream.flush()
        }
    }
    def getImage4() {
        response.with{
            setHeader('Content-length', imagenBytes.length.toString())
            contentType = "image/${'jpeg'}" // or the appropriate image content type
            outputStream << imagenBytes
            outputStream.flush()
        }
    }
    def getImage5() {
        response.with{
            setHeader('Content-length', imagenBytes.length.toString())
            contentType = "image/${'jpeg'}" // or the appropriate image content type
            outputStream << imagenBytes
            outputStream.flush()
        }
    }
    def getImage6() {
        response.with{
            setHeader('Content-length', imagenBytes.length.toString())
            contentType = "image/${'jpeg'}" // or the appropriate image content type
            outputStream << imagenBytes
            outputStream.flush()
        }
    }

    def getImage7() {
        response.with{
            setHeader('Content-length', imagenBytes.length.toString())
            contentType = "image/${'jpeg'}" // or the appropriate image content type
            outputStream << imagenBytes
            outputStream.flush()
        }
    }

    def getImage8() {
        response.with{
            setHeader('Content-length', imagenBytes.length.toString())
            contentType = "image/${'jpeg'}" // or the appropriate image content type
            outputStream << imagenBytes
            outputStream.flush()
        }
    }

    byte[] im(tipo) {
        println("TIPO " + tipo)

        def path = ''

        def imcNina = "/var/medico/imc_ninas2a20.jpeg"
        def imcNino = "/var/medico/imc_ninos2a20.jpeg"
        def pcNina = "/var/medico/pcefalico_ninas5.jpeg"
        def pcNino = "/var/medico/pcefalico_ninos5.jpeg"
        def pesoNina = "/var/medico/peso_ninas05.jpeg"
        def pesoNino = "/var/medico/peso_ninos05.jpeg"
        def tallaNina = "/var/medico/talla_ninas5.jpeg"
        def tallaNino = "/var/medico/talla_ninos5.jpeg"

        switch (tipo) {
            case "imcNina":
                path = imcNina
                break;
            case 'imcNino':
                path = imcNino
                break;
            case "pcNina":
                path = pcNina
                break;
            case "pcNino":
                path = pcNino
                break;
            case "pesoNina":
                path = pesoNina
                break;
            case "pesoNino":
                path = pesoNino
                break;
            case "tallaNina":
                path = tallaNina
                break;
            case "tallaNino":
                path = tallaNino
                break;
        }


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

    def imcNina_ajax(){
        def paciente = Paciente.get(params.paciente)
        def cn = dbConnectionService.getConnection()
        def id = paciente?.id
        def edad = (new Date() - Paciente.get(id).fechaNacimiento)/365.25
        def sql = "select ((hsclfcha::date - pcntfcna)/365.25)::numeric(4,1) edad, exfspeso, exfstlla * 100 exfstlla, " +
                "exfs_imc from exfs, hscl, pcnt where pcnt.pcnt__id = ${id} and hscl.pcnt__id = pcnt.pcnt__id and " +
                "exfs.hscl__id = hscl.hscl__id order by hsclfcha"
        println "sql: $sql"
//        def data = cn.rows(sql.toString())[0]
        def data = cn.rows(sql.toString())

        println "antes --> edad: $edad"
        edad = (690-108)/18 * (edad - 2) + 108
//        data.exfstlla = Math.floor( (841 - (data.exfstlla - 75.0) / 5 * 31) )
//        data.exfspeso = Math.round( 1028 - (data.exfspeso - 10 ) / 5 * 31 )
        println "--> edad: $edad"

        for (d in data) {
            d.edad = (690-108)/18 * (d.edad - 2) + 108
            d.exfstlla = Math.floor( (841 - (d.exfstlla - 75.0) / 5 * 31) )
            d.exfspeso = Math.round( 1028 - (d.exfspeso - 10 ) / 5 * 31 )
        }
        println "*--> ${data as JSON}"
        imagenBytes = im("imcNina")

        return [paciente: paciente, ancho: ancho, alto: alto, edad: edad, data: data, jdata: data as JSON]
    }

    def imcNino_ajax(){
        def paciente = Paciente.get(params.paciente)
        def cn = dbConnectionService.getConnection()
        def id = paciente?.id
        def edad = (new Date() - Paciente.get(id).fechaNacimiento)/365.25
        def sql = "select ((hsclfcha::date - pcntfcna)/365.25)::numeric(4,1) edad, exfspeso, exfstlla * 100 exfstlla, " +
                "exfs_imc from exfs, hscl, pcnt where pcnt.pcnt__id = ${id} and hscl.pcnt__id = pcnt.pcnt__id and " +
                "exfs.hscl__id = hscl.hscl__id order by hsclfcha"
        println "sql: $sql"
        def data = cn.rows(sql.toString())

        println "antes --> edad: $edad"
        edad = (691-110)/18 * (edad - 2) + 110
        println "--> edad: $edad"

        for (d in data) {
            d.edad = (691-110)/18 * (d.edad - 2) + 110
            d.exfstlla = Math.floor( (841 - (d.exfstlla - 75.0) / 5 * 26) )
            d.exfspeso = Math.round( 1063 - (d.exfspeso - 10 ) / 5 * 31)
        }
        println "*--> ${data as JSON}"
        imagenBytes = im("imcNino")

        return [paciente: paciente, ancho: ancho, alto: alto, edad: edad, data: data, jdata: data as JSON]
    }

    def pcNina_ajax(){
        def paciente = Paciente.get(params.paciente)
        def cn = dbConnectionService.getConnection()
        def id = paciente?.id
        def edad = (new Date() - Paciente.get(id).fechaNacimiento)/365.25
        def sql = "select ((hsclfcha::date - pcntfcna)/365.25)::numeric(4,1) edad, " +
                "exfsprcf from exfs, hscl, pcnt where pcnt.pcnt__id = ${id} and hscl.pcnt__id = pcnt.pcnt__id and " +
                "exfs.hscl__id = hscl.hscl__id order by hsclfcha"
        println "sql: $sql"
        def data = cn.rows(sql.toString())

        println "antes --> edad: $edad"
        edad = (717-68)/18 * (edad - 2) + 68
        println "--> edad: $edad"

        for (d in data) {
            d.edad = (717-68)/5 * (d.edad - 0) + 68
            d.exfsprcf = Math.floor( (1020 - (d.exfsprcf - 32.0) * 40.2) )
        }
        println "*--> ${data as JSON}"
        imagenBytes = im("pcNina")

        return [paciente: paciente, ancho: ancho, alto: alto, edad: edad, data: data, jdata: data as JSON]
    }

    def pcNino_ajax(){
        def paciente = Paciente.get(params.paciente)
        def cn = dbConnectionService.getConnection()
        def id = paciente?.id
        def edad = (new Date() - Paciente.get(id).fechaNacimiento)/365.25
        def sql = "select ((hsclfcha::date - pcntfcna)/365.25)::numeric(4,1) edad, " +
                "exfsprcf from exfs, hscl, pcnt where pcnt.pcnt__id = ${id} and hscl.pcnt__id = pcnt.pcnt__id and " +
                "exfs.hscl__id = hscl.hscl__id order by hsclfcha"
        println "sql: $sql"
        def data = cn.rows(sql.toString())

        println "antes --> edad: $edad"
        edad = (717-70)/5 * (edad - 0) + 70
        println "--> edad: $edad"

        for (d in data) {
            d.edad = (717-70)/5 * (d.edad - 0) + 70
            d.exfsprcf = Math.floor((1060 - (d.exfsprcf - 32.0) * 40.1) )
        }
        println "*--> ${data as JSON}"
        imagenBytes = im("pcNino")

        return [paciente: paciente, ancho: ancho, alto: alto, edad: edad, data: data, jdata: data as JSON]
    }

    def pesoNina_ajax(){
        def paciente = Paciente.get(params.paciente)
        def cn = dbConnectionService.getConnection()
        def id = paciente?.id
        def edad = (new Date() - Paciente.get(id).fechaNacimiento)/365.25
        def sql = "select ((hsclfcha::date - pcntfcna)/365.25)::numeric(4,1) edad, exfspeso " +
                " from exfs, hscl, pcnt where pcnt.pcnt__id = ${id} and hscl.pcnt__id = pcnt.pcnt__id and " +
                "exfs.hscl__id = hscl.hscl__id order by hsclfcha"
        println "sql: $sql"
        def data = cn.rows(sql.toString())

        println "antes --> edad: $edad"
        edad = (715-63)/18 * (edad - 0) + 63
        println "--> edad: $edad"

        for (d in data) {
            d.edad = (715-63)/5 * (d.edad - 0) + 63
            d.exfspeso = Math.round(983 - (d.exfspeso - 2 )  * 35.6 )
        }
        println "*--> ${data as JSON}"
        imagenBytes = im("pesoNina")

        return [paciente: paciente, ancho: ancho, alto: alto, edad: edad, data: data, jdata: data as JSON]
    }

    def pesoNino_ajax(){
        def paciente = Paciente.get(params.paciente)
        def cn = dbConnectionService.getConnection()
        def id = paciente?.id
        def edad = (new Date() - Paciente.get(id).fechaNacimiento)/365.25
        def sql = "select ((hsclfcha::date - pcntfcna)/365.25)::numeric(4,1) edad, exfspeso " +
                " from exfs, hscl, pcnt where pcnt.pcnt__id = ${id} and hscl.pcnt__id = pcnt.pcnt__id and " +
                "exfs.hscl__id = hscl.hscl__id order by hsclfcha"
//        println "sql: $sql"
        def data = cn.rows(sql.toString())

//        println "antes --> edad: $edad"
        edad = (710-65)/5 * (edad - 0) + 65
//        println "--> edad: $edad"

        for (d in data) {
            d.edad = (710-65)/5 * (d.edad - 0) + 65
            d.exfspeso = Math.round(965 - (d.exfspeso - 2 ) * 35.3 )
        }
//        println "*--> ${data as JSON}"
        imagenBytes = im("pesoNino")

        return [paciente: paciente, ancho: ancho, alto: alto, edad: edad, data: data, jdata: data as JSON]
    }

    def tallaNina_ajax(){
        def paciente = Paciente.get(params.paciente)
        def cn = dbConnectionService.getConnection()
        def id = paciente?.id
        def edad = (new Date() - Paciente.get(id).fechaNacimiento)/365.25
        def sql = "select ((hsclfcha::date - pcntfcna)/365.25)::numeric(4,1) edad, exfstlla  " +
                " from exfs, hscl, pcnt where pcnt.pcnt__id = ${id} and hscl.pcnt__id = pcnt.pcnt__id and " +
                "exfs.hscl__id = hscl.hscl__id order by hsclfcha"
        println "sql: $sql"
        def data = cn.rows(sql.toString())

        println "antes --> edad: $edad"
        edad = (695-133)/18 * (edad - 0) + 133
        println "--> edad: $edad"

        for (d in data) {
            d.edad = (695-133)/5 * (d.edad - 0) + 133
            d.exfstlla = Math.floor( (947 - (d.exfstlla * 100 - 45) / 5 * 44) )
        }
        println "*--> ${data as JSON}"
        imagenBytes = im("tallaNina")

        return [paciente: paciente, ancho: ancho, alto: alto, edad: edad, data: data, jdata: data as JSON]
    }

    def tallaNino_ajax(){
        def paciente = Paciente.get(params.paciente)
        def cn = dbConnectionService.getConnection()
        def id = paciente?.id
        def edad = (new Date() - Paciente.get(id).fechaNacimiento)/365.25
        def sql = "select ((hsclfcha::date - pcntfcna)/365.25)::numeric(4,1) edad, exfstlla * 100 exfstlla  " +
                " from exfs, hscl, pcnt where pcnt.pcnt__id = ${id} and hscl.pcnt__id = pcnt.pcnt__id and " +
                "exfs.hscl__id = hscl.hscl__id order by hsclfcha"
        println "sql: $sql"
        def data = cn.rows(sql.toString())

        println "antes --> edad: $edad"
        edad = (717-63)/5 * (edad - 0) + 63
        println "--> edad: $edad"

        for (d in data) {
            d.edad = (717-63)/5 * (d.edad - 0) + 63
            d.exfstlla = Math.floor((990 - (d.exfstlla - 45) / 5 * 53) )
        }
        println "*--> ${data as JSON}"
        imagenBytes = im("tallaNino")

        return [paciente: paciente, ancho: ancho, alto: alto, edad: edad, data: data, jdata: data as JSON]
    }


}
