package seguridad

import geografia.Canton
import geografia.Provincia
import groovy.io.FileType

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static java.awt.RenderingHints.KEY_INTERPOLATION
import static java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC

class EmpresaController {


    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def dbConnectionService

    def list(){

    }

    def form_ajax(){
        println("id " + params)
        def empresa
        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = new Empresa()
        }

        return [empresa: empresa]
    }

    def tablaEmpresas_ajax(){

        def listaItems = ['empr_ruc', 'emprnmbr']
        def bsca
        def sqlTx = ""

        if(params.buscarPor){
            bsca = listaItems[params.buscarPor?.toInteger()-1]
        }else{
            bsca = listaItems[0]
        }
        def select = "select * from empr "
        def txwh = " where empr__id  is not null and " +
                " $bsca ilike '%${params.criterio}%' "
        sqlTx = "${select} ${txwh} order by emprnmbr ".toString()
        def cn = dbConnectionService.getConnection()
        def datos = cn.rows(sqlTx)

        [datos: datos]
    }

    def canton_ajax () {
        def empresa
        def provincia = Provincia.get(params.provincia)
        def cantones = Canton.findAllByProvincia(provincia).sort{it.nombre}

        if(params.id){
            empresa = Empresa.get(params.id)
        }else{
            empresa = null
        }

        return [empresa: empresa, cantones: cantones]
    }

    def saveEmpresa_ajax() {
        def empresa
        def ruc = false

        if(params.id){
            empresa = Empresa.get(params.id)
            ruc = Empresa.findAllByRucAndIdNotEqual(params.ruc, empresa.id)
        }else{
            ruc = Empresa.findAllByRuc(params.ruc)
            empresa = new Empresa()
            empresa.fechaInicio = new Date()
        }

        if(ruc){
            render "err_El RUC ya se encuentra ingresado"
            return false
        }else{
            empresa.properties = params

            if(!empresa.save(flush: true)){
                println("error al crear la empresa " + empresa.errors)
                render "no_Error al crear la empresa"
            }else{
                render "ok_Empresa guardada correctamente"
            }
        }
    }

    def borrarEmpresa_ajax(){
        def empresa = Empresa.get(params.id)

        try{
            empresa.delete(flush: true)
            render "ok_Empresa borrada correctamente"
        }catch(e){
            println("error al borrar la empresa"  + empresa.errors)
            render "no_Error al borrar la empresa"
        }
    }

    def show_ajax () {
        def empresa = Empresa.get(params.id)
        return [empresa: empresa]
    }

    def imagenesEmpresa_ajax(){
        def empresa = Empresa.get(params.id)
        return[empresa:empresa]
    }

    def tablaImagenesEmp_ajax(){
        def empresa = Empresa.get(params.id)
//        def imagenes = ImagenEmpresa.findAllByEmpresa(empresa)

        def path = "/var/medico/empresa/emp_" + empresa.id + "/"
        new File(path).mkdirs()

        def files = []
        def dir = new File(path)

//        imagenes.each { im ->

        if(empresa?.logo){


            def file = new File(path + empresa.logo)
            def img = ImageIO.read(file)
//            if(file.name.toString() in empresa.ruta){
            if (img) {
                files.add([
//                            id  : im.id,
dir : path,
file: file.name,
w   : img?.getWidth(),
h   : img?.getHeight(),
                ])
            }
//            }
//        }

        }
        return[imagenes: files, empresa: empresa]
    }

    def upload_ajax() {
        println ("params imas emp " +  params)
        def empresa = Empresa.get(params.id)
//        def imagenes = ImagenEmpresa.findAllByEmpresa(empresa)
//        def path = "/var/medico/empresa/emp_" + empresa.id + "/"
        def path = "/var/medico/empresa/emp_" + empresa.id + "/"
        new File(path).mkdirs()

        def f = request.getFile('file')

        def okContents = ['image/png': "png", 'image/jpeg': "jpeg", 'image/jpg': "jpg"]

//        def canti = []
//        def dir = new File(path)
//        dir.eachFileRecurse(FileType.FILES) { file ->
//            def img = ImageIO.read(file)
//
//            if (img) {
//                canti.add([
//                        dir : path,
//                        file: file.name,
//                        w   : img?.getWidth(),
//                        h   : img?.getHeight(),
//                ])
//            }
//        }

        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }

            if (okContents.containsKey(f.getContentType())) {
                ext = okContents[f.getContentType()]
                fileName = fileName.size() < 40 ? fileName : fileName[0..39]
                fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")

                def nombre = fileName + "." + ext
                def pathFile = path + nombre
                def fn = fileName
                def src = new File(pathFile)


                def i = 1
                while (src.exists()) {
                    nombre = fn + "_" + i + "." + ext
                    pathFile = path + nombre
                    src = new File(pathFile)
                    i++
                }
                try {
                    println "---> try:  ${f.getContentType()}"
                    f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
                    println "transferTo --> $pathFile"
//                        def imagenNueva = new ImagenEmpresa()
//                        imagenNueva.empresa = empresa
//                        imagenNueva.ruta = nombre

                    empresa.logo = nombre

//                        imagenNueva.save(flush:true)
                    empresa.save(flush: true)

                } catch (e) {
                    println ("error al subir la imagen " + e)
                }

                def img = ImageIO.read(new File(pathFile))
                def scale = 0.5
                def minW = 1000
                def minH = 500
                def maxW = 1000
                def maxH = 500
                def w = img.width
                def h = img.height

                if (w > maxW || h > maxH || w < minW || h < minH) {
                    def newW = w * scale
                    def newH = h * scale
                    def r = 1
                    if (w > h) {
                        if (w > maxW) {
                            r = w / maxW
                            newW = maxW
                            println "w>maxW:    r=" + r + "   newW=" + newW
                        }
                        if (w < minW) {
                            r = minW / w
                            newW = minW
                            println "w<minW:    r=" + r + "   newW=" + newW
                        }
                        newH = h / r
                        println "newH=" + newH
                    } else {
                        if (h > maxH) {
                            r = h / maxH
                            newH = maxH
                            println "h>maxH:    r=" + r + "   newH=" + newH
                        }
                        if (h < minH) {
                            r = minH / h
                            newH = minH
                            println "h<minxH:    r=" + r + "   newH=" + newH
                        }
                        newW = w / r
                        println "newW=" + newW
                    }
                    println newW + "   " + newH

                    newW = Math.round(newW.toDouble()).toInteger()
                    newH = Math.round(newH.toDouble()).toInteger()

                    println newW + "   " + newH

                    new BufferedImage(newW, newH, img.type).with { j ->
                        createGraphics().with {
                            setRenderingHint(KEY_INTERPOLATION, VALUE_INTERPOLATION_BICUBIC)
                            drawImage(img, 0, 0, newW, newH, null)
                            dispose()
                        }
                        ImageIO.write(j, ext, new File(pathFile))
                    }
                }

                def output = '<html>' +
                        '<body>' +
                        '<script type="text/javascript">' +
                        'Archivo subido correctamente.' +
                        '</script>' +
                        '</body>' +
                        '</html>';
                render output
            } //contenido ok (extension ok
            else {
                def ok = ""
                okContents.each {
                    if (ok != "") {
                        ok += ", "
                    }
                    ok += it.value
                }
                def output = '<html>' +
                        '<body>' +
                        '<script type="text/javascript">' +
                        'Por favor utilice archivos de tipo' + ok +
                        '</script>' +
                        '</body>' +
                        '</html>';
                render output
            }
        }//f not empty
        else {
            def output = '<html>' +
                    '<body>' +
                    '<script type="text/javascript">' +
                    'Por favor seleccione una imagen' +
                    '</script>' +
                    '</body>' +
                    '</html>';
            render output
        }
    }

    def getImage() {
//        println "params get image $params"
        def empresa = Empresa.get(params.id)

        def nombreArchivo = empresa?.logo?.split("\\.")[0]
        def extensionArchivo = empresa?.logo?.split("\\.")[1]

        byte[] imageInBytes = im(nombreArchivo, extensionArchivo , empresa?.id)
        response.with{
            setHeader('Content-length', imageInBytes.length.toString())
            contentType = "image/${extensionArchivo}" // or the appropriate image content type
            outputStream << imageInBytes
            outputStream.flush()
        }
    }

    byte[] im(nombre,ext,empresa) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream()
        ImageIO.write(ImageIO.read(new File("/var/medico/empresa/emp_" + empresa + "/" + nombre + "." + ext)), ext.toString(), baos)
        baos.toByteArray()
    }


//    def getFoto(){
//        println "getFoto: $params"
//        def empresa
//        def path = "/var/medico/empresas/${params.ruta}"
//        def fileext = path.substring(path.indexOf(".")+1, path.length())
//
//        println "ruta: $path"
//
//        BufferedImage imagen = ImageIO.read(new File(path));
//        ByteArrayOutputStream baos = new ByteArrayOutputStream();
//        ImageIO.write( imagen, fileext, baos );
//        baos.flush();
//        byte[] img = baos.toByteArray();
//        baos.close();
//        response.setHeader('Content-length', img.length.toString())
//        response.contentType = "image/"+fileext // or the appropriate image content type
//        response.outputStream << img
//        response.outputStream.flush()
//    }

    def uploadFile() {
//        println "upload "+params

        def acceptedExt = ["jpg", "png", "jpeg"]

        def empresa = Empresa.get(params.empresa)
        def path = "/var/medico/empresa/emp_" + empresa.id + "/"
        new File(path).mkdirs()

        def f = request.getFile('file')  //archivo = name del input type file
        if (f && !f.empty) {
            def fileName = f.getOriginalFilename() //nombre original del archivo
            def ext
            def parts = fileName.split("\\.")
            fileName = ""
            parts.eachWithIndex { obj, i ->
                if (i < parts.size() - 1) {
                    fileName += obj
                } else {
                    ext = obj
                }
            }
            if (acceptedExt.contains(ext.toLowerCase())) {
                fileName = fileName + "." + ext
                def pathFile = path + fileName
                def file = new File(pathFile)
                println "subiendo archivo: $fileName"

                f.transferTo(file)

                def old = empresa.logo
                if (old && old.trim() != "") {
                    def oldPath = "/var/medico/empresa/emp_" + empresa.id + "/" + old
                    def oldFile = new File(oldPath)
                    if (oldFile.exists()) {
                        oldFile.delete()
                    }
                }

                empresa.logo = fileName
                empresa.save(flush: true)

            } else {
                flash.clase = "alert-error"
                flash.message = "Error: Los formatos permitidos son: JPG, JPEG, PNG"
            }
        } else {
            flash.clase = "alert-error"
            flash.message = "Error: Seleccione un archivo JPG, JPEG, PNG"
        }

        redirect(action: "list")
        return
    }

    def logoEmpresa_ajax () {
         def empresa = Empresa.get(params.id)
        return[empresa: empresa]
    }

    def deleteImagen_ajax() {
        println "deleteImagen_ajax params $params"
        def empresa = Empresa.get(params.id)
        def path = "/var/medico/empresa/emp_" + empresa.id + "/${empresa.logo}"

        try{
            empresa.logo = null
            empresa.save(flush: true)
            def file = new File(path).delete()
            render "ok"
        }catch(e){
            println("error al borrar la imagen " + e)
            render "no"
        }
    }


}
