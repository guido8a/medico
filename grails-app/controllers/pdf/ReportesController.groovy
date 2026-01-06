package pdf


import com.lowagie.text.Document
import com.lowagie.text.Element
import com.lowagie.text.Image
import com.lowagie.text.PageSize
import com.lowagie.text.Paragraph
import com.lowagie.text.Phrase
import com.lowagie.text.Rectangle
import com.lowagie.text.pdf.PdfContentByte
import com.lowagie.text.pdf.PdfImportedPage
import com.lowagie.text.pdf.PdfPCell
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfReader
import com.lowagie.text.pdf.PdfWriter
import jxl.WorkbookSettings
import jxl.write.Label
import jxl.write.WritableCellFormat
import jxl.write.WritableFont
import jxl.write.WritableSheet
import jxl.write.WritableWorkbook
import medico.DetalleExamen
import medico.DiagnosticoxHistorial
import medico.ExamenComplementario
import medico.GrupoExamen
import medico.Historial
import medico.TipoExamen
import medico.Tratamiento
import org.apache.poi.hssf.usermodel.HSSFClientAnchor
import org.apache.poi.hssf.usermodel.HSSFPatriarch
import org.apache.poi.hssf.usermodel.HSSFSimpleShape
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.ss.usermodel.*
import seguridad.Empresa
import seguridad.Paciente
import seguridad.Persona
import medico.NumberToLetterConverter

import javax.swing.text.StyleConstants
import java.text.SimpleDateFormat


class ReportesController {

    def dbConnectionService

    def reportes(){

    }


    def circulo () {

//        Workbook wb = new HSSFWorkbook()
//        OutputStream os = new FileOutputStream("Javatpoint.xls")
//        Sheet sheet = wb.createSheet("Sheet");
//        Row row = sheet.createRow(4); // Creating a row
//        Cell cell = row.createCell(1); // Creating a cell
//        HSSFPatriarch patriarch = (HSSFPatriarch) sheet.createDrawingPatriarch();
//        HSSFClientAnchor  a = new HSSFClientAnchor( 0, 0, 1023, 255, (short) 1, 0, (short) 1, 0 );
//        HSSFSimpleShape shape = patriarch.createSimpleShape(a);
//        shape.setShapeType(HSSFSimpleShape.OBJECT_TYPE_OVAL);
//                wb.write(os);



        Workbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("Data Validation");
        HSSFPatriarch patriarch = (HSSFPatriarch) sheet.createDrawingPatriarch();
        HSSFClientAnchor a = new HSSFClientAnchor( 0, 0, 1023, 255, (short) 1, 0, (short) 2, 1 );
        HSSFSimpleShape shape1 = patriarch.createSimpleShape(a);
        shape1.setShapeType(HSSFSimpleShape.OBJECT_TYPE_OVAL);
        shape1.setLineStyleColor(10,10,10);
        shape1.setFillColor(90,10,200);
//            shape1.setLineWidth(HSSFShape.LINEWIDTH_ONE_PT * 3);
//            shape1.setLineStyle(HSSFShape.LINESTYLE_DOTSYS);
        FileOutputStream fileOut = new FileOutputStream("XLDrawingShape.xls");
        try {
            workbook.write(fileOut);
            fileOut.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    def reporteFincaExcel(){

        def fincas = Finca.list().sort{it.nombre}

        //excel
        WorkbookSettings workbookSettings = new WorkbookSettings()
        workbookSettings.locale = Locale.default

        def file = File.createTempFile('myExcelDocument', '.xls')
        file.deleteOnExit()

        WritableWorkbook workbook = jxl.Workbook.createWorkbook(file, workbookSettings)
        WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
        WritableCellFormat formatXls = new WritableCellFormat(font)

        def row = 0
        WritableSheet sheet = workbook.createSheet('finca', 0)
        WritableSheet sheet2 = workbook.createSheet('areasProduccion', 1)
        WritableSheet sheet3 = workbook.createSheet('trabajoFamiliar', 2)
        WritableSheet sheet4 = workbook.createSheet('manejoCultivos', 3)
        WritableSheet sheet5 = workbook.createSheet('manejoEnfermedades', 4)
        WritableSheet sheet6 = workbook.createSheet('controlPlagas', 5)
        WritableSheet sheet7 = workbook.createSheet('manejoForestal', 6)
        WritableSheet sheet8 = workbook.createSheet('manejoAnimales', 7)
        WritableSheet sheet9 = workbook.createSheet('cargos', 8)
        WritableSheet sheet10 = workbook.createSheet('obras', 9)
        WritableSheet sheet11 = workbook.createSheet('infraestructura', 10)
        WritableSheet sheet12 = workbook.createSheet('capacitacion', 11)
//        sheet.setRowView(4,34)


        //DATOS FINCA

        // fija el ancho de la columna
        sheet.setColumnView(0,30)
        sheet.setColumnView(1,30)
        sheet.setColumnView(2,30)
        sheet.setColumnView(3,30)
        sheet.setColumnView(4,30)
        sheet.setColumnView(5,30)
        sheet.setColumnView(6,30)
        sheet.setColumnView(7,30)
        sheet.setColumnView(8,30)
        sheet.setColumnView(9,30)
        sheet.setColumnView(10,30)
        sheet.setColumnView(11,30)
        sheet.setColumnView(12,30)
        sheet.setColumnView(13,30)
        sheet.setColumnView(14,30)
        sheet.setColumnView(15,30)
        sheet.setColumnView(16,30)
        sheet.setColumnView(17,30)
        sheet.setColumnView(18,30)
        sheet.setColumnView(19,30)
        sheet.setColumnView(20,30)
        sheet.setColumnView(21,30)
        sheet.setColumnView(22,30)
        sheet.setColumnView(23,30)
        sheet.setColumnView(24,30)
        sheet.setColumnView(25,30)
        sheet.setColumnView(26,30)
        sheet.setColumnView(27,30)
        sheet.setColumnView(28,30)
        sheet.setColumnView(29,30)
        sheet.setColumnView(30,30)
        sheet.setColumnView(31,30)
        sheet.setColumnView(32,30)
        sheet.setColumnView(33,30)
        sheet.setColumnView(34,30)
        sheet.setColumnView(35,30)
        sheet.setColumnView(36,30)
        sheet.setColumnView(37,30)
        sheet.setColumnView(38,30)
        sheet.setColumnView(39,30)
        sheet.setColumnView(40,30)
        sheet.setColumnView(41,30)
        sheet.setColumnView(42,30)
        sheet.setColumnView(43,30)
        sheet.setColumnView(44,30)
        sheet.setColumnView(45,30)
        sheet.setColumnView(46,30)
        sheet.setColumnView(47,30)
        sheet.setColumnView(48,30)
        sheet.setColumnView(49,30)
        sheet.setColumnView(50,30)
        sheet.setColumnView(51,30)
        sheet.setColumnView(52,30)

        WritableFont times16font = new WritableFont(WritableFont.TIMES, 11, WritableFont.BOLD, false);
        WritableFont times16fontNormal = new WritableFont(WritableFont.TIMES, 11, WritableFont.NO_BOLD, false);
        WritableCellFormat times16format = new WritableCellFormat(times16font);
        WritableCellFormat times16Normal = new WritableCellFormat(times16fontNormal);

//        autoSizeColumns(sheet, 10)

        def label
        def number
        def fila = 4;

        label = new Label(0, 1, "DATOS DE LA FINCA", times16format); sheet.addCell(label);
        label = new Label(0, 2, "", times16format); sheet.addCell(label);
        label = new Label(0, 3, "NOMBRE", times16format); sheet.addCell(label);
        label = new Label(1, 3, "CANTÓN", times16format); sheet.addCell(label);
        label = new Label(2, 3, "PARROQUIA", times16format); sheet.addCell(label);
        label = new Label(3, 3, "COMUNIDAD", times16format); sheet.addCell(label);
        label = new Label(4, 3, "ORGANIZACIÓN", times16format); sheet.addCell(label);
        label = new Label(5, 3, "INSTITUCIÓN DE APOYO", times16format); sheet.addCell(label);
        label = new Label(6, 3, "FECHA", times16format); sheet.addCell(label);
        label = new Label(7, 3, "PROPIETARIO", times16format); sheet.addCell(label);
        label = new Label(8, 3, "DELEGADO", times16format); sheet.addCell(label);
        label = new Label(9, 3, "PROMOTOR", times16format); sheet.addCell(label);
        label = new Label(10, 3, "DIRECCIÓN", times16format); sheet.addCell(label);
        label = new Label(11, 3, "ALTITUD", times16format); sheet.addCell(label);
        label = new Label(12, 3, "LONGITUD", times16format); sheet.addCell(label);
        label = new Label(13, 3, "LATITUD", times16format); sheet.addCell(label);
        label = new Label(14, 3, "ZONA", times16format); sheet.addCell(label);
        label = new Label(15, 3, "PLAN DE MANEJO", times16format); sheet.addCell(label);
        label = new Label(16, 3, "ACTIVIDAD AGRICOLA (%)", times16format); sheet.addCell(label);
        label = new Label(17, 3, "ACTIVIDAD PECUARIA (%)", times16format); sheet.addCell(label);
        label = new Label(18, 3, "JORNALEROS PERMANENTES", times16format); sheet.addCell(label);
        label = new Label(19, 3, "JORNALEROS TEMPORALES", times16format); sheet.addCell(label);
        label = new Label(20, 3, "ENTREVISTADOR", times16format); sheet.addCell(label);
        label = new Label(21, 2, "MANEJO DE SUELOS", times16format); sheet.addCell(label);
        label = new Label(21, 3, "PREPARACIÓN DEL SUELO", times16format); sheet.addCell(label);
        label = new Label(22, 3, "FERTILIZACIÓN DEL SUELO", times16format); sheet.addCell(label);
        label = new Label(23, 3, "FERTILIZACIÓN COMPLEMENTARIA", times16format); sheet.addCell(label);
        label = new Label(24, 3, "MANEJO DE RASTROJOS", times16format); sheet.addCell(label);
        label = new Label(25, 2, "MANEJO DE CULTIVOS", times16format); sheet.addCell(label);
        label = new Label(25, 3, "HACE ASOCIACIÓN DE CULTIVOS", times16format); sheet.addCell(label);
        label = new Label(26, 3, "HACE ROTACIÓN DE CULTIVOS", times16format); sheet.addCell(label);
        label = new Label(27, 3, "HACE SELECCIÓN DE SEMILLAS", times16format); sheet.addCell(label);
        label = new Label(28, 3, "USA SEMILLAS PROPIAS", times16format); sheet.addCell(label);
        label = new Label(29, 3, "USA SEMILLAS COMPRADAS", times16format); sheet.addCell(label);
        label = new Label(30, 3, "USA SEMILLAS DE INTERCAMBIO", times16format); sheet.addCell(label);
        label = new Label(31, 3, "REALIZA CALENDARIZACIÓN DE CULTIVOS", times16format); sheet.addCell(label);
        label = new Label(32, 3, "ÁREA DE INVERNADERO (M2)", times16format); sheet.addCell(label);

        label = new Label(33, 2, "MANEJO DEL AGUA", times16format); sheet.addCell(label);

        label = new Label(33, 3, "TIENE AGUA DE  RIEGO", times16format); sheet.addCell(label);
        label = new Label(34, 3, "PERTENECE A JUNTA RIEGO", times16format); sheet.addCell(label);
        label = new Label(35, 3, "FUENTE DE AGUA", times16format); sheet.addCell(label);
        label = new Label(36, 3, "INFR. DE RIEGO", times16format); sheet.addCell(label);

        label = new Label(37, 2, "MANEJO FORESTAL", times16format); sheet.addCell(label);
        label = new Label(37, 3, "ESPECIES FORESTALES", times16format); sheet.addCell(label);
        label = new Label(38, 3, "PÁRAMO O MONTE", times16format); sheet.addCell(label);

        label = new Label(39, 2, "MANEJO DE ANIMALES", times16format); sheet.addCell(label);
        label = new Label(39, 3, "FINCA PASTO", times16format); sheet.addCell(label);
        label = new Label(40, 3, "ABONA PASTOS CON", times16format); sheet.addCell(label);
        label = new Label(41, 3, "MANEJO DE PASTOS", times16format); sheet.addCell(label);
        label = new Label(42, 3, "INSALACIONES", times16format); sheet.addCell(label);
        label = new Label(43, 3, "SANITARIO", times16format); sheet.addCell(label);
        label = new Label(44, 3, "USA PRÁCTICAS ANCESTRALES", times16format); sheet.addCell(label);

        label = new Label(45, 2, "MANEJO DE AMBIENTE Y PRODUCCIÓN", times16format); sheet.addCell(label);
        label = new Label(45, 3, "BASURA %", times16format); sheet.addCell(label);
        label = new Label(46, 3, "AUTOCONSUMO %", times16format); sheet.addCell(label);
        label = new Label(47, 3, "VENTA %", times16format); sheet.addCell(label);
        label = new Label(48, 3, "DONDE VENDE", times16format); sheet.addCell(label);
        label = new Label(49, 3, "CADA QUE TIEMPO VENDE", times16format); sheet.addCell(label);

        label = new Label(50, 2, "PARTICIPACIÓN", times16format); sheet.addCell(label);
        label = new Label(50, 3, "MIEMBRO ACTIVO DE ORGANIZACIÓN", times16format); sheet.addCell(label);
        label = new Label(51, 2, "CRITERIO DEL PROMOTOR", times16format); sheet.addCell(label);
        label = new Label(51, 3, "LA FINCA SE CONSIDERA", times16format); sheet.addCell(label);


        fincas.each { f ->

            label = new Label(0, fila, (f?.nombre ? f?.nombre : ''), times16Normal); sheet.addCell(label);
            label = new Label(1, fila, (f?.parroquia?.canton?.nombre ? f?.parroquia?.canton?.nombre : ''), times16Normal); sheet.addCell(label);
            label = new Label(2, fila, (f?.parroquia?.nombre ? f?.parroquia?.nombre : ''), times16Normal); sheet.addCell(label);
            label = new Label(3, fila, (f?.comunidad ? f?.comunidad : ''), times16Normal); sheet.addCell(label);
            label = new Label(4, fila, (f?.organizacion ? f?.organizacion : ''), times16Normal); sheet.addCell(label);
            label = new Label(5, fila, (f?.institucion?.nombre ? f?.institucion?.nombre : ''), times16Normal); sheet.addCell(label);
            label = new Label(6, fila, (f?.fecha ? f?.fecha?.format("dd-MM-yyyy") : ''), times16Normal); sheet.addCell(label);
            label = new Label(7, fila, (f?.propietario ? f?.propietario : ''), times16Normal); sheet.addCell(label);
            label = new Label(8, fila, (f?.delegado ? f?.delegado : ''), times16Normal); sheet.addCell(label);
            label = new Label(9, fila, (f?.promotor ? f?.promotor : ''), times16Normal); sheet.addCell(label);
            label = new Label(10, fila, (f?.direccion ? f?.direccion : ''), times16Normal); sheet.addCell(label);
            number = new jxl.write.Number(11, fila, f?.altura ? f?.altura : 0); sheet.addCell(number);
            number = new jxl.write.Number(12, fila, f?.longitud ? f?.longitud : 0); sheet.addCell(number);
            number = new jxl.write.Number(13, fila, f?.latitud ? f?.latitud : 0); sheet.addCell(number);
            label = new Label(14, fila, (f?.zona ? f?.zona : ''), times16Normal); sheet.addCell(label);
            label = new Label(15, fila, (f?.plan ? f?.plan : ''), times16Normal); sheet.addCell(label);
            number = new jxl.write.Number(16, fila, f?.actvAgricola ? f?.actvAgricola : 0); sheet.addCell(number);
            number = new jxl.write.Number(17, fila, f?.actvPecuaria ? f?.actvPecuaria : 0); sheet.addCell(number);
            number = new jxl.write.Number(18, fila, f?.jornalerosPermanentes ? f?.jornalerosPermanentes : 0); sheet.addCell(number);
            number = new jxl.write.Number(19, fila, f?.jornalerosTemporales ? f?.jornalerosTemporales : 0); sheet.addCell(number);
            label = new Label(20, fila, (f?.entrevista ? f?.entrevista : ''), times16Normal); sheet.addCell(label);
            label = new Label(21, fila, (f?.preparacionSuelo ? f?.preparacionSuelo : ''), times16Normal); sheet.addCell(label);
            label = new Label(22, fila, (f?.fertilizantes ? f?.fertilizantes : ''), times16Normal); sheet.addCell(label);
            label = new Label(23, fila, (f?.fertilizacionComplementaria ? f?.fertilizacionComplementaria : ''), times16Normal); sheet.addCell(label);
            label = new Label(24, fila, (f?.manejoRastrojos ? f?.manejoRastrojos : ''), times16Normal); sheet.addCell(label);
            label = new Label(25, fila, (f?.asociacionCultivos ? f?.asociacionCultivos : ''), times16Normal); sheet.addCell(label);
            label = new Label(26, fila, (f?.rotacionCultivos ? f?.rotacionCultivos : ''), times16Normal); sheet.addCell(label);
            label = new Label(27, fila, (f?.seleccionSemillas ? f?.seleccionSemillas : ''), times16Normal); sheet.addCell(label);
            label = new Label(28, fila, (f?.semillaPropia ? f?.semillaPropia : ''), times16Normal); sheet.addCell(label);
            label = new Label(29, fila, (f?.semillaComprada ? f?.semillaComprada : ''), times16Normal); sheet.addCell(label);
            label = new Label(30, fila, (f?.semillaIntercambio ? f?.semillaIntercambio : ''), times16Normal); sheet.addCell(label);
            label = new Label(31, fila, (f?.calendarizacion ? f?.calendarizacion : ''), times16Normal); sheet.addCell(label);
            number = new jxl.write.Number(32, fila, f?.invernadero ? f?.invernadero : 0); sheet.addCell(number);

            label = new Label(33, fila, (f?.aguaRiego ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(34, fila, (f?.juntaAgua ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(35, fila, (f?.aguaFuente ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(36, fila, (f?.aguaInfraestructura ?: ''), times16Normal); sheet.addCell(label);

            label = new Label(37, fila, (f?.forestal ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(38, fila, (f?.monte ?: ''), times16Normal); sheet.addCell(label);

            label = new Label(39, fila, (f?.pasto ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(40, fila, (f?.pastoAbono ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(41, fila, (f?.manejoPasto ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(42, fila, (f?.instalaciones ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(43, fila, (f?.sanitario ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(44, fila, (f?.ancestrales ?: ''), times16Normal); sheet.addCell(label);

            label = new Label(45, fila, (f?.basura ?: ''), times16Normal); sheet.addCell(label);
            number = new jxl.write.Number(46, fila, f?.autoconsumo ? f?.autoconsumo : 0); sheet.addCell(number);
            number = new jxl.write.Number(47, fila, f?.venta ? f?.venta : 0); sheet.addCell(number);
            label = new Label(48, fila, (f?.lugarVenta ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(49, fila, (f?.fecuencia ?: ''), times16Normal); sheet.addCell(label);

            label = new Label(50, fila, (f?.estaoOrganizacion ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(51, fila, (f?.calificacion == 'P' ? 'En Proceso': f?.calificacion == 'T' ? 'En Transición' :
                    f?.calificacion == 'I' ? 'Inicio' : 'A'), times16Normal); sheet.addCell(label);
            fila++
        }

        //areas de produccion

        sheet2.setColumnView(0,30)
        sheet2.setColumnView(1,30)
        sheet2.setColumnView(2,30)
        sheet2.setColumnView(3,30)
        sheet2.setColumnView(4,30)
        sheet2.setColumnView(5,30)
        sheet2.setColumnView(6,30)

        def labelArea
        def numberArea
        def filaArea = 4

        labelArea = new Label(0, 1, "ÁREAS DE PRODUCCIÓN", times16format); sheet2.addCell(labelArea);
        labelArea = new Label(0, 2, "", times16format); sheet2.addCell(labelArea);
        labelArea = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet2.addCell(labelArea);
        labelArea = new Label(1, 3, "TIPO DE LOTE", times16format); sheet2.addCell(labelArea);
        labelArea = new Label(2, 3, "REFERENCIA", times16format); sheet2.addCell(labelArea);
        labelArea = new Label(3, 3, "ÁREA (%)", times16format); sheet2.addCell(labelArea);
        labelArea = new Label(4, 3, "USO AGRÍCOLA (%)", times16format); sheet2.addCell(labelArea);
        labelArea = new Label(5, 3, "USO PECUARIO (%)", times16format); sheet2.addCell(labelArea);
        labelArea = new Label(6, 3, "PENDIENTE (%)", times16format); sheet2.addCell(labelArea);

        fincas.each { f2->
            def areas = AreaProduccion.findAllByFinca(f2)

            areas.each {a->
                labelArea = new Label(0, filaArea, (a?.finca?.nombre ? a?.finca?.nombre : ''), times16Normal); sheet2.addCell(labelArea);
                labelArea = new Label(1, filaArea, (a?.tipoLote?.descripcion ? a?.tipoLote?.descripcion : ''), times16Normal); sheet2.addCell(labelArea);
                labelArea = new Label(2, filaArea, (a?.referencia ? a?.referencia : ''), times16Normal); sheet2.addCell(labelArea);
                numberArea = new jxl.write.Number(3, filaArea, a?.area ? a?.area : 0); sheet2.addCell(numberArea);
                numberArea = new jxl.write.Number(4, filaArea, a?.usoAgricola ? a?.usoAgricola : 0); sheet2.addCell(numberArea);
                numberArea = new jxl.write.Number(5, filaArea, a?.usoPecuario ? a?.usoPecuario : 0); sheet2.addCell(numberArea);
                numberArea = new jxl.write.Number(6, filaArea, a?.pendiente ? a?.pendiente : 0); sheet2.addCell(numberArea);
                filaArea++
            }
        }

        //trabajo familiar

        sheet3.setColumnView(0,30)
        sheet3.setColumnView(1,30)
        sheet3.setColumnView(2,30)
        sheet3.setColumnView(3,30)
        sheet3.setColumnView(4,30)
        sheet3.setColumnView(5,30)
        sheet3.setColumnView(6,30)

        def label3
        def number3
        def fila3 = 4

        label3 = new Label(0, 1, "TRABAJO FAMILIAR", times16format); sheet3.addCell(label3);
        label3 = new Label(0, 2, "", times16format); sheet3.addCell(label3);
        label3 = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet3.addCell(label3);
        label3 = new Label(1, 3, "FAMILIAR", times16format); sheet3.addCell(label3);
        label3 = new Label(2, 3, "NÚMERO", times16format); sheet3.addCell(label3);
        label3 = new Label(3, 3, "ACTIVIDAD", times16format); sheet3.addCell(label3);
        label3 = new Label(4, 3, "TIPO", times16format); sheet3.addCell(label3);

        fincas.each { f3->
            def trabajos = TrabajoFamiliar.findAllByFinca(f3)

            trabajos.each {t->
                label3 = new Label(0, fila3, (t?.finca?.nombre ? t?.finca?.nombre : ''), times16Normal); sheet3.addCell(label3);
                label3 = new Label(1, fila3, (t?.familia?.descripcion ? t?.familia?.descripcion : ''), times16Normal); sheet3.addCell(label3);
                number3 = new jxl.write.Number(2, fila3, t?.numero ? t?.numero : 0); sheet3.addCell(number3);
                label3 = new Label(3, fila3, (t?.actividad ? t?.actividad : ''), times16Normal); sheet3.addCell(label3);
                label3 = new Label(4, fila3, (t?.tipo ? t?.tipo : ''), times16Normal); sheet3.addCell(label3);
                fila3++
            }
        }

        //manejo de cultivos

        sheet4.setColumnView(0,30)
        sheet4.setColumnView(1,30)
        sheet4.setColumnView(2,30)


        def label4
        def number4
        def fila4 = 4

        label4 = new Label(0, 1, "MANEJO DE CULTIVOS", times16format); sheet4.addCell(label4);
        label4 = new Label(0, 2, "", times16format); sheet4.addCell(label4);
        label4 = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet4.addCell(label4);
        label4 = new Label(1, 3, "CULTIVO", times16format); sheet4.addCell(label4);
        label4 = new Label(2, 3, "ÁREA (M2)", times16format); sheet4.addCell(label4);

        fincas.each { f3->
            def cultivos = Cultivos.findAllByFinca(f3)

            cultivos.each {c->
                label4 = new Label(0, fila4, (c?.finca?.nombre ? c?.finca?.nombre : ''), times16Normal); sheet4.addCell(label4);
                label4 = new Label(1, fila4, (c?.planta?.descripcion ? c?.planta?.descripcion  : ''), times16Normal); sheet4.addCell(label4);
                number4 = new jxl.write.Number(2, fila4, c?.area ? c?.area : 0); sheet4.addCell(number4);
                fila4++
            }
        }

        //MANEJO DE ENFERMEDADES

        sheet5.setColumnView(0,30)
        sheet5.setColumnView(1,30)

        def label5
        def fila5 = 4

        label5 = new Label(0, 1, "MANEJO DE CULTIVOS", times16format); sheet5.addCell(label5);
        label5 = new Label(0, 2, "", times16format); sheet5.addCell(label5);
        label5 = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet5.addCell(label5);
        label5 = new Label(1, 3, "ENFERMEDAD", times16format); sheet5.addCell(label5);

        fincas.each { f5->
            def enfermedades = ManejoEnfermedades.findAllByFinca(f5)

            enfermedades.each {e->
                label5 = new Label(0, fila5, (e?.finca?.nombre ? e?.finca?.nombre : ''), times16Normal); sheet5.addCell(label5);
                label5 = new Label(1, fila5, (e?.enfermedad?.descripcion ? e?.enfermedad?.descripcion  : ''), times16Normal); sheet5.addCell(label5);
                fila5++
            }
        }

        //CONTROL DE PLAGAS

        sheet6.setColumnView(0,30)
        sheet6.setColumnView(1,30)

        def label6
        def fila6 = 4

        label6 = new Label(0, 1, "MANEJO DE PLAGAS", times16format); sheet6.addCell(label6);
        label6 = new Label(0, 2, "", times16format); sheet6.addCell(label6);
        label6 = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet6.addCell(label6);
        label6 = new Label(1, 3, "PLAGA", times16format); sheet6.addCell(label6);

        fincas.each { f6->
            def plagas = ManejoPlagas.findAllByFinca(f6)

            plagas.each {e->
                label6 = new Label(0, fila6, (e?.finca?.nombre ? e?.finca?.nombre : ''), times16Normal); sheet6.addCell(label6);
                label6 = new Label(1, fila6, (e?.plaga?.descripcion ? e?.plaga?.descripcion  : ''), times16Normal); sheet6.addCell(label6);
                fila6++
            }
        }

        //MANEJO FORESTAL

        sheet7.setColumnView(0,30)
        sheet7.setColumnView(1,30)

        def label7
        def fila7 = 4

        label7 = new Label(0, 1, "MANEJO FORESTAL", times16format); sheet7.addCell(label7);
        label7 = new Label(0, 2, "", times16format); sheet7.addCell(label7);
        label7 = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet7.addCell(label7);
        label7 = new Label(1, 3, "SIEMBRA", times16format); sheet7.addCell(label7);

        fincas.each { f7->
            def siembras = Forestal.findAllByFinca(f7)

            siembras.each {s->
                label7 = new Label(0, fila7, (s?.finca?.nombre ? s?.finca?.nombre : ''), times16Normal); sheet7.addCell(label7);
                label7 = new Label(1, fila7, (s?.siembra?.descripcion ? s?.siembra?.descripcion : ''), times16Normal); sheet7.addCell(label7);
                fila7++
            }
        }

        //MANEJO DE ANIMALES

        sheet8.setColumnView(0,30)
        sheet8.setColumnView(1,30)
        sheet8.setColumnView(2,30)

        def label8
        def number8
        def fila8 = 4

        label8 = new Label(0, 1, "MANEJO DE ANIMALES", times16format); sheet8.addCell(label8);
        label8 = new Label(0, 2, "", times16format); sheet8.addCell(label8);
        label8 = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet8.addCell(label8);
        label8 = new Label(1, 3, "ANIMAL", times16format); sheet8.addCell(label8);
        label8 = new Label(2, 3, "CANTIDAD", times16format); sheet8.addCell(label8);

        fincas.each { f8->
            def animales = ManejoAnimal.findAllByFinca(f8)

            animales.each {c->
                label8 = new Label(0, fila8, (c?.finca?.nombre ? c?.finca?.nombre : ''), times16Normal); sheet8.addCell(label8);
                label8 = new Label(1, fila8, (c?.animal?.descripcion ? c?.animal?.descripcion  : ''), times16Normal); sheet8.addCell(label8);
                number8 = new jxl.write.Number(2, fila8, c?.numero ? c?.numero : 0); sheet8.addCell(number8);
                fila8++
            }
        }

        //CARGOS

        sheet9.setColumnView(0,30)
        sheet9.setColumnView(1,30)

        def label9
        def fila9 = 4

        label9 = new Label(0, 1, "CARGOS", times16format); sheet9.addCell(label9);
        label9 = new Label(0, 2, "", times16format); sheet9.addCell(label9);
        label9 = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet9.addCell(label9);
        label9 = new Label(1, 3, "CARGO", times16format); sheet9.addCell(label9);

        fincas.each { f7->
            def cargos = FincaCargo.findAllByFinca(f7)

            cargos.each {s->
                label9 = new Label(0, fila9, (s?.finca?.nombre ? s?.finca?.nombre : ''), times16Normal); sheet9.addCell(label9);
                label9 = new Label(1, fila9, (s?.cargo?.descripcion ? s?.cargo?.descripcion : ''), times16Normal); sheet9.addCell(label9);
                fila9++
            }
        }

        //OBRAS DE LA FINCA

        sheet10.setColumnView(0,30)
        sheet10.setColumnView(1,30)
        sheet10.setColumnView(2,30)

        def label10
        def fila10 = 4

        label10 = new Label(0, 1, "OBRAS DE LA FINCA", times16format); sheet10.addCell(label10);
        label10 = new Label(0, 2, "", times16format); sheet10.addCell(label10);
        label10 = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet10.addCell(label10);
        label10 = new Label(1, 3, "OBRA", times16format); sheet10.addCell(label10);
        label10 = new Label(2, 3, "ESTADO", times16format); sheet10.addCell(label10);

        fincas.each { f7->
            def obras = ObrasFinca.findAllByFinca(f7)

            obras.each {s->
                label10 = new Label(0, fila10, (s?.finca?.nombre ? s?.finca?.nombre : ''), times16Normal); sheet10.addCell(label10);
                label10 = new Label(1, fila10, (s?.tipoObra?.descripcion ? s?.tipoObra?.descripcion : ''), times16Normal); sheet10.addCell(label10);
                label10 = new Label(2, fila10, (s?.estado ? (s?.estado == 'I' ? 'Iniciado' : (s?.estado == 'A' ? 'Avanzado' : 'Terminado')) : ''), times16Normal); sheet10.addCell(label10);
                fila10++
            }
        }

        //INFRAESTRUCTURA

        sheet11.setColumnView(0,30)
        sheet11.setColumnView(1,30)

        def label11
        def fila11 = 4

        label11 = new Label(0, 1, "INFRAESTRUCTURA", times16format); sheet11.addCell(label11);
        label11 = new Label(0, 2, "", times16format); sheet11.addCell(label11);
        label11 = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet11.addCell(label11);
        label11 = new Label(1, 3, "INFRAESTRUCTURA", times16format); sheet11.addCell(label11);

        fincas.each { f7->
            def equipos = ManejoEquipo.findAllByFinca(f7)

            equipos.each {s->
                label11 = new Label(0, fila11, (s?.finca?.nombre ? s?.finca?.nombre : ''), times16Normal); sheet11.addCell(label11);
                label11 = new Label(1, fila11, (s?.equipo?.descripcion ? s?.equipo?.descripcion : ''), times16Normal); sheet11.addCell(label11);
                fila11++
            }
        }

        //CAPACITACION

        sheet12.setColumnView(0,30)
        sheet12.setColumnView(1,30)

        def label12
        def fila12 = 4

        label12 = new Label(0, 1, "CAPACITACIÓN", times16format); sheet12.addCell(label12);
        label12 = new Label(0, 2, "", times16format); sheet12.addCell(label12);
        label12 = new Label(0, 3, "NOMBRE DE LA FINCA", times16format); sheet12.addCell(label12);
        label12 = new Label(1, 3, "CURSOS DE CAPACITACIÓN", times16format); sheet12.addCell(label12);

        fincas.each { f7->
            def capacitaciones = FincaCapacitacion.findAllByFinca(f7)

            capacitaciones.each {s->
                label12 = new Label(0, fila12, (s?.finca?.nombre ? s?.finca?.nombre : ''), times16Normal); sheet12.addCell(label12);
                label12 = new Label(1, fila12, (s?.capacitacion?.descripcion ? s?.capacitacion?.descripcion : ''), times16Normal); sheet12.addCell(label12);
                fila12++
            }
        }

        workbook.write();
        workbook.close();
        def output = response.getOutputStream()
        def header = "attachment; filename=" + "reporteFincaExcel_" + new Date().format("dd-MM-yyyy") + ".xls";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        output.write(file.getBytes());
    }

    def reportePuntajesExcel(){

        def finca = Finca.get(params.id)

        def cn = dbConnectionService.getConnection()
        def sql = "select * from puntaje(${finca.id})"
        def res = cn.rows(sql.toString())

        //excel
        WorkbookSettings workbookSettings = new WorkbookSettings()
        workbookSettings.locale = Locale.default

        def file = File.createTempFile('myExcelDocument', '.xls')
        file.deleteOnExit()

        WritableWorkbook workbook = jxl.Workbook.createWorkbook(file, workbookSettings)
        WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
        WritableCellFormat formatXls = new WritableCellFormat(font)

        def row = 0
        WritableSheet sheet = workbook.createSheet('puntajes', 0)

        //DATOS FINCA

        // fija el ancho de la columna
        sheet.setColumnView(0,30)
        sheet.setColumnView(1,30)
        sheet.setColumnView(2,30)

        WritableFont times16font = new WritableFont(WritableFont.TIMES, 11, WritableFont.BOLD, false);
        WritableFont times16fontNormal = new WritableFont(WritableFont.TIMES, 11, WritableFont.NO_BOLD, false);
        WritableCellFormat times16format = new WritableCellFormat(times16font);
        WritableCellFormat times16Normal = new WritableCellFormat(times16fontNormal);

//        autoSizeColumns(sheet, 10)

        def label
        def number
        def fila = 5;
        def total = 0

        label = new Label(0, 0, "SISTEMA DE LA MATA A LA OLLA", times16format); sheet.addCell(label);
        label = new Label(0, 1, "PUNTAJES", times16format); sheet.addCell(label);
        label = new Label(0, 2, "FINCA: ${finca?.nombre}", times16format); sheet.addCell(label);
        label = new Label(0, 3, " ", times16format); sheet.addCell(label);
        label = new Label(0, 4, "CONCEPTO", times16format); sheet.addCell(label);
        label = new Label(1, 4, "VALOR", times16format); sheet.addCell(label);
        label = new Label(2, 4, "PUNTAJE", times16format); sheet.addCell(label);

        res.each { p ->
            label = new Label(0, fila, (p?.pntodscr ?: ''), times16Normal); sheet.addCell(label);
            label = new Label(1, fila, (p?.pntovlor ?: ''), times16Normal); sheet.addCell(label);
            number = new jxl.write.Number(2, fila, p?.pntopnto ?: 0      ); sheet.addCell(number);
            total += (p?.pntopnto ?: 0)
            fila++
        }

        label = new Label(1, fila, "TOTAL", times16format); sheet.addCell(label);
        number = new jxl.write.Number(2, fila,total); sheet.addCell(number);

        workbook.write();
        workbook.close();
        def output = response.getOutputStream()
        def header = "attachment; filename=" + "reportePuntajesExcel_" + new Date().format("dd-MM-yyyy") + ".xls";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        output.write(file.getBytes());
    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }

    private static int[] arregloEnteros(array) {
        int[] ia = new int[array.size()]
        array.eachWithIndex { it, i ->
            ia[i] = it.toInteger()
        }
        return ia
    }

    private static void addCellTabla(PdfPTable table, paragraph, params) {
        PdfPCell cell = new PdfPCell(paragraph);
        if (params.height) {
            cell.setFixedHeight(params.height.toFloat());
        }
        if (params.border) {
            cell.setBorderColor(params.border);
        }
        if (params.bg) {
            cell.setBackgroundColor(params.bg);
        }
        if (params.colspan) {
            cell.setColspan(params.colspan);
        }
        if (params.align) {
            cell.setHorizontalAlignment(params.align);
        }
        if (params.valign) {
            cell.setVerticalAlignment(params.valign);
        }
        if (params.w) {
            cell.setBorderWidth(params.w);
            cell.setUseBorderPadding(true);
        }
        if (params.bwl) {
            cell.setBorderWidthLeft(params.bwl.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwb) {
            cell.setBorderWidthBottom(params.bwb.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwr) {
            cell.setBorderWidthRight(params.bwr.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bwt) {
            cell.setBorderWidthTop(params.bwt.toFloat());
            cell.setUseBorderPadding(true);
        }
        if (params.bcl) {
            cell.setBorderColorLeft(params.bcl);
        }
        if (params.bcb) {
            cell.setBorderColorBottom(params.bcb);
        }
        if (params.bcr) {
            cell.setBorderColorRight(params.bcr);
        }
        if (params.bct) {
            cell.setBorderColorTop(params.bct);
        }
        if (params.padding) {
            cell.setPadding(params.padding.toFloat());
        }
        if (params.pl) {
            cell.setPaddingLeft(params.pl.toFloat());
        }
        if (params.pr) {
            cell.setPaddingRight(params.pr.toFloat());
        }
        if (params.pt) {
            cell.setPaddingTop(params.pt.toFloat());
        }
        if (params.pb) {
            cell.setPaddingBottom(params.pb.toFloat());
        }
        table.addCell(cell);
    }

    def calculaEdad(fcha, fcna) {
        def cn = dbConnectionService.getConnection()
        def sql = "select replace( replace( replace(replace( age('${fcha}'::date, '${fcna}'::date)::text, 'year', 'año'), 'mons','meses'), " +
                "'day', 'dia'), 'mon', 'mes') edad "
        println "sql: $sql"
        def edad = cn.rows( sql.toString() )[0]?.edad

        return edad
    }

    def receta() {
        def cn = dbConnectionService.getConnection()
        def cita = Historial.get(params.cita)
        def edadCalculada = calculaEdad( new Date().format('yyyy-MM-dd'), cita?.paciente?.fechaNacimiento?.format('yyyy-MM-dd'))
        def listaDiagnosticos = DiagnosticoxHistorial.findAllByHistorial(cita)
        def tratamientos = Tratamiento.findAllByHistorial(cita, [sort: 'orden'])
        def diagnosticos = ''
        def usuario = Persona.get(session.usuario?.id)
        def empr = usuario.empresa.id
        def edad = ''
        def citaProxima
        def citaHora
        def cantidadCaracteres = 0
        def altura = 0
        def adicional = 0

//        println "prox. cita: ${cita?.paciente} --> ${cita?.fecha}"
//        def citasMayores = Historial.findAllByPacienteAndFechaGreaterThan(cita?.paciente, cita.fecha,
//                [sort: 'fecha', order: 'desc'])
        def hora = "${cita?.fecha?.format('yyyy-MM-dd')} ${cita?.hora}"
        def sql = "select hsclfcha, hsclhora from hscl where pcnt__id = ${cita.paciente.id} and " +
                "hsclfcha > '${hora}'::timestamp + interval '1 hour' " +
                "order by 1 limit 1"
//        println "sql: $sql"

        cn.eachRow(sql.toString()) { d ->
            citaProxima = d.hsclfcha
            citaHora = d.hsclhora
        }

        if(listaDiagnosticos?.size()?:0 > 0){
            listaDiagnosticos.each {
                diagnosticos += (it.diagnostico.codigo + " - " + it.diagnostico.descripcion)
                diagnosticos += ", "
            }
        }else{
            diagnosticos = ''
        }
        cantidadCaracteres += diagnosticos.length()

        println "--> $cantidadCaracteres  long: ${diagnosticos.length()}"

        if(cantidadCaracteres > 0){
            altura = cantidadCaracteres / 50
            altura = Math.ceil(altura)
            altura = altura <= 1 ? 1 : altura.toInteger()
            adicional = altura*5
            altura = (altura * 80 ) > 240 ? (240 + adicional) : 240

        }else{
            altura = 240
        }

        if(cita?.paciente?.edad <= 5){
            edad = " (" + cita?.paciente?.getNinoNina() + ")"
        }else{
            edad = ''
        }

        def path = "/var/medico/empresa/emp_${empr}/logo.jpeg"
        Image logo = Image.getInstance(path);
        def longitud = logo.getHeight()
        logo.scalePercent( (100/longitud * 100).toInteger() )
        logo.setAlignment(Image.MIDDLE | Image.TEXTWRAP)

        def fondoTotal = new java.awt.Color(250, 250, 240);
        def baos = new ByteArrayOutputStream()
        def name = "receta_${cita?.paciente?.apellido}_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        def titulo = new java.awt.Color(40, 140, 180)
        com.lowagie.text.Font fontTitulo = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.BOLD, titulo);
        com.lowagie.text.Font fontThTiny = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontThTiny3 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontThTiny4 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font fontThTiny2 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font fontThTiny5 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.ITALIC);
        com.lowagie.text.Font times8normal = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);

        Document document
        document = new Document(PageSize.A4.rotate());
//        document = new Document(PageSize.A4);
//        document = new Document(PageSize.A4);
        document.setMargins(28, 30, altura, 28)  //se 28 equivale a 1 cm: izq, derecha, arriba y abajo
        def pdfw = PdfWriter.getInstance(document, baos);
//        document.resetHeader()
//        document.resetFooter()
//        com.lowagie.text.HeaderFooter footer1 = new com.lowagie.text.HeaderFooter(new Phrase("", times8normal), false);
//        footer1.setBorder(Rectangle.NO_BORDER);
//        footer1.setAlignment(Element.ALIGN_LEFT);
//        document.setFooter(footer1);

        document.open();
        PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Receta");
        document.addSubject("Generado por el sistema Médico");
        document.addKeywords("reporte, medico, receta");
        document.addAuthor("Médico");
        document.addCreator("Tedein SA");

//        Paragraph preface = new Paragraph();
//        addEmptyLine(preface, 1);
//        preface.setAlignment(Element.ALIGN_CENTER);
//        preface.add(new Paragraph("RECETA", fontTitulo));
//        addEmptyLine(preface, 1);
//        document.add(preface);

//        PdfPTable tablaImagen = new PdfPTable(3);
//        tablaImagen.setWidthPercentage(100);
//        tablaImagen.setWidths(arregloEnteros([45,10,45]))
//        addCellTabla(tablaImagen, logo, [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaImagen, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaImagen, logo, [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        tablaImagen.setSpacingAfter(20f);

        PdfPTable tablaDetalles = null

        def printTratamiento = {
            def band

            def tablaTratamientoDetalles1 = new PdfPTable(5);
            tablaTratamientoDetalles1.setWidthPercentage(100);
            tablaTratamientoDetalles1.setWidths(arregloEnteros([5, 41, 8, 5, 41]))

            def tablaTratamientoDetalles2 = new PdfPTable(5);
            tablaTratamientoDetalles2.setWidthPercentage(100);
            tablaTratamientoDetalles2.setWidths(arregloEnteros([5, 41, 8, 5, 41]))

            tratamientos.eachWithIndex {p, q->

//                println "convierte de números a letras"
                def numerosALetras
                if(p?.cantidad == 1){
                    numerosALetras = 'UNO'
                } else {
                    numerosALetras = NumberToLetterConverter.convertNumberToLetter(p?.cantidad ?: 0)
                }

                if(q <= 4){
                    band = '1'
                }else{
                    band = '2'
                }

                if(q <= 4){
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph(p?.medicina?.padre?.descripcion  ?: '' + " ( ${p?.medicina?.padre?.descripcion ?: ''} )", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph(p?.medicina?.padre?.descripcion  ?: '' + " ( ${p?.medicina?.padre?.descripcion ?: ''} )", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

                    addCellTabla(tablaTratamientoDetalles1, new Paragraph((q + 1)?.toString() + ".-", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph((p?.medicina?.descripcion ?: '') + " " + (p?.medicina?.concentracion ?:''), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph((q + 1)?.toString() + ".-", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph((p?.medicina?.descripcion ?: '') + " " + (p?.medicina?.concentracion ?:''), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph((p?.medicina?.forma ?: '') + " # " + p?.cantidad?.toString() + " (" + numerosALetras + ")", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph(p?.descripcion  ?: '', fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles1, new Paragraph("", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

                    tablaTratamientoDetalles1.setSpacingAfter(10f);
                }else{
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph(p?.medicina?.padre?.descripcion  ?: '' + " ( ${p?.medicina?.padre?.descripcion ?: ''} )", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph(p?.medicina?.padre?.descripcion  ?: '' + " ( ${p?.medicina?.padre?.descripcion ?: ''} )", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

                    addCellTabla(tablaTratamientoDetalles2, new Paragraph((q + 1)?.toString() + ".-", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph((p?.medicina?.descripcion ?: '') + " " + (p?.medicina?.concentracion ?:''), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph((q + 1)?.toString() + ".-", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph((p?.medicina?.descripcion ?: '') + " " + (p?.medicina?.concentracion ?:''), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph((p?.medicina?.forma ?: '') + " # " + p?.cantidad?.toString() + " (" + numerosALetras + ")", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph(p?.descripcion  ?: '', fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                    addCellTabla(tablaTratamientoDetalles2, new Paragraph("", fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

                    tablaTratamientoDetalles2.setSpacingAfter(10f);
                }

            }

            addCellTabla(tablaDetalles, tablaTratamientoDetalles1, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5, pl: 0])

            if(tratamientos.size() > 4){
                addCellTabla(tablaDetalles, tablaTratamientoDetalles2, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5, pl: 0])
            }
        }

        SimpleDateFormat fmtEsp = new SimpleDateFormat('EEEE, dd-MMMM-yyyy', new Locale("es", "ES"));

        def printTratamientoFin = {

            def tablaTratamientoDetallesFin = new PdfPTable(5);
            tablaTratamientoDetallesFin.setWidthPercentage(100);
            tablaTratamientoDetallesFin.setWidths(arregloEnteros([5, 41, 8, 5, 41]))

            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("${cita?.tratamiento ?: ''}", fontThTiny5), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("PRÓXIMA CITA: ${citaProxima ? citaProxima.format('EEEE, dd-MMMM-yyyy') : ''}" + " a las " + "${(citaHora? citaHora + ' horas': '')}", times8normal),
            addCellTabla(tablaTratamientoDetallesFin, new Paragraph("PRÓXIMA CITA: ${citaProxima ? fmtEsp.format(citaProxima) : ''}" + " a las " + "${(citaHora? citaHora + ' horas': '')}", times8normal),
                    [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])


            addCellTabla(tablaDetalles, tablaTratamientoDetallesFin, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5, pl: 0])

            tablaTratamientoDetallesFin.setSpacingAfter(10f);
        }


        tablaDetalles = new PdfPTable(4);
        tablaDetalles.setWidthPercentage(100);
        tablaDetalles.setWidths(arregloEnteros([6, 20, 62, 12]))
        tablaDetalles.setSpacingAfter(10f);

//        document.add(tablaImagen)
//        printHeaderDetalle();
        printTratamiento();
        printTratamientoFin();
        document.add(tablaDetalles)
        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
//        response.setContentType("application/pdf")
//        response.setHeader("Content-disposition", "attachment; filename=" + name)
//        response.setContentLength(b.length)
//        response.getOutputStream().write(b)

        encabezadoYnumeracion(b, name, "", "${name}.pdf", cita?.persona?.empresa?.direccion, empr, cita, diagnosticos, edadCalculada, edad)

    }

    def listaPacientes_ajax(){
        def usuario = Persona.get(session.usuario?.id)
        def empresa = usuario.empresa.id
        def consultorio = Empresa.get(empresa)
        def pacientes = Paciente.findAllByEmpresa(consultorio)
        return [pacientes: pacientes]
    }

    def reporteCitasXPaciente(){

        def paciente = Paciente.get(params.paciente)
        def citas = Historial.findAllByPaciente(paciente)
        def usuario = Persona.get(session.usuario?.id)
        def empr = usuario.empresa.id
        def dire = usuario.empresa.direccion

        def path = "/var/medico/empresa/emp_${empr}/logo.jpeg"
        Image logo = Image.getInstance(path);
        def longitud = logo.getHeight()
        logo.scalePercent( (100/longitud * 100).toInteger() )
        logo.setAlignment(Image.MIDDLE | Image.TEXTWRAP)

        def fondoTotal = new java.awt.Color(250, 250, 240);
        def baos = new ByteArrayOutputStream()
        def name = "cita_${paciente?.apellido}_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        def titulo = new java.awt.Color(40, 140, 180)
        com.lowagie.text.Font fontTitulo = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.BOLD, titulo);
        com.lowagie.text.Font fontThTiny = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontThTiny3 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontThTiny2 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font times8normal = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 8, com.lowagie.text.Font.NORMAL);

        Document document
//        document = new Document(PageSize.A4.rotate());
        document = new Document(PageSize.A4);
        document.setMargins(50, 30, 30, 28)  //se 28 equivale a 1 cm: izq, derecha, arriba y abajo
        def pdfw = PdfWriter.getInstance(document, baos);
//        document.resetHeader()
//        document.resetFooter()
        com.lowagie.text.HeaderFooter footer1 = new com.lowagie.text.HeaderFooter(new Phrase("", times8normal), true);
        footer1.setBorder(Rectangle.NO_BORDER);
        footer1.setAlignment(Element.ALIGN_CENTER);
        document.setFooter(footer1);

        document.open();
        PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Citas");
        document.addSubject("Generado por el sistema Médico");
        document.addKeywords("reporte, medico, receta");
        document.addAuthor("Médico");
        document.addCreator("Tedein SA");

//        Paragraph preface = new Paragraph();
//        addEmptyLine(preface, 1);
//        preface.setAlignment(Element.ALIGN_CENTER);
//        preface.add(new Paragraph("RECETA", fontTitulo));
//        addEmptyLine(preface, 1);
//        document.add(preface);

        PdfPTable tablaImagen = new PdfPTable(1);
        tablaImagen.setWidthPercentage(100);
        tablaImagen.setWidths(arregloEnteros([100]))
        addCellTabla(tablaImagen, logo, [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        tablaImagen.setSpacingAfter(20f);

        PdfPTable tablaDetalles = null

        def printHeaderDetalle = {
            def tablaHeaderDetalles = new PdfPTable(4);
            tablaHeaderDetalles.setWidthPercentage(100);
            tablaHeaderDetalles.setWidths(arregloEnteros([30, 30, 20, 20]))

            addCellTabla(tablaHeaderDetalles, new Paragraph("Motivo", fontThTiny), [border: java.awt.Color.BLACK, bg: java.awt.Color.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph("Fecha", fontThTiny), [border: java.awt.Color.BLACK, bg: java.awt.Color.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph("Hora", fontThTiny), [border: java.awt.Color.BLACK, bg: java.awt.Color.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph("Próxima Cita", fontThTiny), [border: java.awt.Color.BLACK, bg: java.awt.Color.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])

            addCellTabla(tablaDetalles, tablaHeaderDetalles, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 4, pl: 0])

            tablaHeaderDetalles.setSpacingAfter(30f);
        }

        def printCitas = {
            def tablaCitas = new PdfPTable(4);
            tablaCitas.setWidthPercentage(100);
            tablaCitas.setWidths(arregloEnteros([30, 30, 20, 20]))

            citas.eachWithIndex {p, q->
                addCellTabla(tablaCitas, new Paragraph(p?.motivo, fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
                addCellTabla(tablaCitas, new Paragraph(p?.fecha?.format("dd-MM-yyyy"), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                addCellTabla(tablaCitas, new Paragraph(p?.hora?.toString(), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
                addCellTabla(tablaCitas, new Paragraph(p?.proximaCita?.format("dd-MM-yyyy HH:mm"), fontThTiny2), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])

                tablaCitas.setSpacingAfter(10f);
            }

            addCellTabla(tablaDetalles, tablaCitas, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 4, pl: 0])

            tablaCitas.setSpacingAfter(10f);
        }

        tablaDetalles = new PdfPTable(4);
        tablaDetalles.setWidthPercentage(100);
        tablaDetalles.setWidths(arregloEnteros([6, 20, 62, 12]))
        tablaDetalles.setSpacingAfter(1f);
//
//        def tablaPieDetalles = new PdfPTable(3);
//        tablaPieDetalles.setTotalWidth(800)
//        tablaPieDetalles.setWidths(arregloEnteros([46,8,46]))
//
//        addCellTabla(tablaPieDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaPieDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaPieDetalles, new Paragraph("PRÓXIMA CITA : ${citaProxima ? citaProxima?.fecha?.format("dd-MM-yyyy") : ''}", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
//        addCellTabla(tablaPieDetalles, new Paragraph(cita?.persona?.empresa?.direccion, fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaPieDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaPieDetalles, new Paragraph(cita?.persona?.empresa?.direccion, fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//
////        tablaPieDetalles.writeSelectedRows(0, -1, 36, tablaPieDetalles.getTotalHeight(), pdfw.getDirectContent());
//        tablaPieDetalles.writeSelectedRows(0, -1, 36, 50, pdfw.getDirectContent());

        document.add(tablaImagen)
        printHeaderDetalle();
        printCitas();
        document.add(tablaDetalles)
        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }


    def encabezadoYnumeracion (f, tituloReporte, subtitulo, nombreReporte, textoFooter, empresa, cita, diagnosticos, edadCalculada, edad) {

        def titulo = new java.awt.Color(30, 140, 160)
        com.lowagie.text.Font fontTitulo = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.BOLD, titulo);
        com.lowagie.text.Font fontTitulo16 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 16, com.lowagie.text.Font.BOLD, titulo);
        com.lowagie.text.Font fontTitulo8 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 8, com.lowagie.text.Font.NORMAL, titulo);
        com.lowagie.text.Font fontTitulo8d = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 8, com.lowagie.text.Font.NORMAL, titulo);

        def path = "/var/medico/empresa/emp_${empresa}/logo.jpeg"
        Image logo = Image.getInstance(path);
        def longitud = logo.getHeight()
        logo.scalePercent( (100/longitud * 100).toInteger() )
        logo.setAlignment(Image.MIDDLE | Image.TEXTWRAP)

        def baos = new ByteArrayOutputStream()

        com.lowagie.text.Document document = new com.lowagie.text.Document(com.lowagie.text.PageSize.A4.rotate());

        def pdfw = com.lowagie.text.pdf.PdfWriter.getInstance(document, baos);

        com.lowagie.text.HeaderFooter footer1 = new com.lowagie.text.HeaderFooter( new com.lowagie.text.Phrase(textoFooter + "         " + textoFooter, new com.lowagie.text.Font(fontTitulo8)), false);

//        def parr2 = new com.lowagie.text.Phrase(textoFooter, new com.lowagie.text.Font(fontTitulo8d))
//        com.lowagie.text.HeaderFooter footer1 = new com.lowagie.text.HeaderFooter( new com.lowagie.text.Phrase(textoFooter + "  Pg.", new com.lowagie.text.Font(fontTitulo8)),
//                new com.lowagie.text.Phrase("     " + textoFooter, new com.lowagie.text.Font(fontTitulo8d)) );
//        com.lowagie.text.HeaderFooter footer1 = new com.lowagie.text.HeaderFooter( new com.lowagie.text.Phrase('', new com.lowagie.text.Font(fontTitulo8)), false);
        footer1.setBorder(com.lowagie.text.Rectangle.NO_BORDER);
        footer1.setBorder(com.lowagie.text.Rectangle.TOP);
        footer1.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        document.setFooter(footer1);

        document.open();

        com.lowagie.text.pdf.PdfContentByte cb = pdfw.getDirectContent();

        PdfReader reader = new PdfReader(f);
        for (int i = 1; i <= reader.getNumberOfPages(); i++) {

            int rotation = reader.getPageRotation(i);
            float pageWidth = reader.getPageSizeWithRotation(i).getWidth();
            float pageHeight = reader.getPageSizeWithRotation(i).getHeight();

            document.newPage();
            PdfImportedPage page = pdfw.getImportedPage(reader, i);

            if (rotation == 0) {
                cb.addTemplate(page, 0,0);
            } else if (rotation == 90) {
                cb.addTemplate(page, 0, -1f, 1f, 0, 0, pageHeight);
            } else if (rotation == 180) {
                cb.addTemplate(page, 1f, 0, 0, -1f, pageWidth, pageHeight);
            } else if (rotation == 270) {
                cb.addTemplate(page, 0, -1f, 1f, 0, 0, pageHeight);
            }

            def ed = encabezado(logo, cita, diagnosticos, edadCalculada, edad)
            numeracion(i,reader.getNumberOfPages(), textoFooter).writeSelectedRows(0, -1, -1, 25, cb)
            document.add(ed)
        }

        document.close();
        byte[] b = baos.toByteArray();

        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + nombreReporte)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def encabezado (logo, cita, diagnosticos, edadCalculada, edad) {
//    def encabezado (titulo, subtitulo, fontTitulo, fontSub) {
//        Paragraph preface = new Paragraph();
//        preface.setAlignment(Element.ALIGN_CENTER);
//        preface.add(new Paragraph(titulo, fontTitulo));
//        preface.add(new Paragraph(subtitulo, fontSub));

        PdfPTable tablaDetalles = new PdfPTable(4);
        tablaDetalles.setWidthPercentage(100);
        tablaDetalles.setWidths(arregloEnteros([6, 20, 62, 12]))
        tablaDetalles.setSpacingAfter(10f);
        tablaDetalles.setSpacingBefore(10f);

        com.lowagie.text.Font fontThTiny = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontThTiny4 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.NORMAL);

        PdfPTable tablaImagen = new PdfPTable(3);
        tablaImagen.setWidthPercentage(100);
        tablaImagen.setWidths(arregloEnteros([45,10,45]))
        addCellTabla(tablaImagen, logo, [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaImagen, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaImagen, logo, [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaDetalles, tablaImagen, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 4, pl: 0])

        PdfPTable tablaHeaderDetalles = new PdfPTable(5);
        tablaHeaderDetalles.setWidthPercentage(100);
        tablaHeaderDetalles.setWidths(arregloEnteros([10, 36, 8, 10, 36]))

        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("Quito, ${cita?.fecha?.format('dd-MM-yyyy')}        Receta # " + cita?.numero?.toString(), fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("Quito, ${cita?.fecha?.format('dd-MM-yyyy')}        Receta # " + cita?.numero?.toString(), fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaHeaderDetalles, new Paragraph("CI:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.paciente?.cedula, fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("CI:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.paciente?.cedula, fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaHeaderDetalles, new Paragraph("Nombre:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.paciente?.apellido + " " + cita?.paciente?.nombre + edad, fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("Nombre:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.paciente?.apellido + " " + cita?.paciente?.nombre + edad , fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaHeaderDetalles, new Paragraph("Diagnóstico:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(diagnosticos, fontThTiny4), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("Diagnóstico:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(diagnosticos, fontThTiny4), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaHeaderDetalles, new Paragraph("Alergias:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.paciente?.alergias, fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        if(cita?.paciente?.edad < 5){
            addCellTabla(tablaHeaderDetalles, new Paragraph("Edad:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph(edadCalculada?.toString(), fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph("Edad:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph(edadCalculada?.toString(), fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        }

        addCellTabla(tablaHeaderDetalles, new Paragraph("Rp:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("INDICACIONES:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan:2])

        addCellTabla(tablaDetalles, tablaHeaderDetalles, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5, pl: 0])

//        tablaHeaderDetalles.setSpacingAfter(200f);
        tablaHeaderDetalles.setSpacingAfter(200f);

        //se debe definir una tabla para imprimir los datos del encabezado y usan colspan para el logo.
//        addCellTabla(tablaImagen, new Paragraph("Receta # " + '5555', fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaImagen, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaImagen, new Paragraph("Receta # " + '5555', fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])
//
//        addCellTabla(tablaImagen, new Paragraph("Quito," + 'fehca', fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaImagen, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaImagen, new Paragraph("Quito," + 'fecha', fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

//        tablaImagen.setSpacingAfter(60f);

//        return tablaImagen
        return tablaDetalles
    }


    def encabezadoDatos (cita, diagnosticos, edadCalculada, edad) {

        com.lowagie.text.Font fontThTiny = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontThTiny4 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.NORMAL);

        PdfPTable tablaHeaderDetalles = new PdfPTable(5);
        tablaHeaderDetalles.setWidthPercentage(100);
        tablaHeaderDetalles.setWidths(arregloEnteros([10, 36, 8, 10, 36]))

        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("Quito, ${cita?.fecha?.format('dd-MM-yyyy')}        Receta # " + cita?.numero?.toString(), fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("Quito, ${cita?.fecha?.format('dd-MM-yyyy')}        Receta # " + cita?.numero?.toString(), fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE])

//        addCellTabla(tablaHeaderDetalles, new Paragraph("Quito,", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.fecha?.format("dd-MM-yyyy"), fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaHeaderDetalles, new Paragraph("Quito,", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
//        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.fecha?.format("dd-MM-yyyy"), fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaHeaderDetalles, new Paragraph("CI:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.paciente?.cedula, fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("CI:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.paciente?.cedula, fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaHeaderDetalles, new Paragraph("Nombre:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.paciente?.apellido + " " + cita?.paciente?.nombre + edad, fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("Nombre:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.paciente?.apellido + " " + cita?.paciente?.nombre + edad , fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaHeaderDetalles, new Paragraph("Diagnóstico:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(diagnosticos, fontThTiny4), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("Diagnóstico:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(diagnosticos, fontThTiny4), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        addCellTabla(tablaHeaderDetalles, new Paragraph("Alergias:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph(cita?.paciente?.alergias, fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])

        if(cita?.paciente?.edad < 5){
            addCellTabla(tablaHeaderDetalles, new Paragraph("Edad:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph(edadCalculada?.toString(), fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph("Edad:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph(edadCalculada?.toString(), fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        }

        addCellTabla(tablaHeaderDetalles, new Paragraph("Rp:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
        addCellTabla(tablaHeaderDetalles, new Paragraph("INDICACIONES:", fontThTiny), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan:2])

//        addCellTabla(tablaDetalles, tablaHeaderDetalles, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 5, pl: 0])

        tablaHeaderDetalles.setSpacingAfter(20f);

        return tablaHeaderDetalles
    }



    def numeracion(x, y, direccion) {
        com.lowagie.text.Font fontTd08 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 8, com.lowagie.text.Font.NORMAL);
        PdfPTable table = new PdfPTable(2);
        table.setWidths(arregloEnteros([40,60]))
        table.setTotalWidth(640);
        table.setLockedWidth(true);
        table.getDefaultCell().setFixedHeight(20);
        table.getDefaultCell().setBorder(Rectangle.NO_BORDER);
        table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.getDefaultCell().setVerticalAlignment(Element.ALIGN_TOP);

//        println "x: $x. y: $y. dir: $direccion"
//        table.addCell(new Paragraph(direccion, fontTd10) );
//        table.addCell(new Paragraph(String.format(direccion , x, y), fontTd10) );
        table.addCell(new Paragraph(String.format("Página %d de %d", x, y), fontTd08) );
        table.addCell(new Paragraph(String.format("Página %d de %d", x, y), fontTd08) );


//        PdfPTable table = new PdfPTable(3)
//        table.setWidthPercentage(100);
//        table.setWidths(arregloEnteros([5,45,45]))
//        table.setTotalWidth(770F);
//        table.getDefaultCell().setFixedHeight(40);
//        addCellTabla(table, new Paragraph('', fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])
//        addCellTabla(table, new Paragraph(direccion + " " *12 + String.format("(Página %d/%d)", x, y), fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])
//        addCellTabla(table, new Paragraph(direccion + " " *12 + String.format("(Página %d/%d)", x, y), fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])
//        addCellTabla(table, new Paragraph("x", fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])
//        addCellTabla(table, new Paragraph("x", fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])
//        addCellTabla(table, new Paragraph("x", fontTd08), [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])
//        table.addCell(new Paragraph(String.format("Página %d de %d", x, y), fontTd08) );
//        table.addCell(new Paragraph(String.format("Página %d de %d", x, y), fontTd08) );
//
        return table;
    }


    def pedidoExamen(){

        def cita = Historial.get(params.cita)
        def paciente = cita.paciente
        def examenes

        def grupoExamen = GrupoExamen.get(6)
        def tipoExamen = TipoExamen.findAllByGrupoExamen(grupoExamen)

        if(params.tipo == 'I'){
            examenes = ExamenComplementario.findAllByHistorialAndTipoExamenInList(cita, tipoExamen, [sort: "id"])
        }else{
            examenes = ExamenComplementario.findAllByHistorialAndTipoExamenNotInList(cita,tipoExamen ,[sort: "id"])
        }

        def edad = calculaEdad( new Date().format('yyyy-MM-dd'), paciente?.fechaNacimiento?.format('yyyy-MM-dd'))
        def usuario = Persona.get(session.usuario?.id)
        def empr = usuario.empresa.id

        def path = "/var/medico/empresa/emp_${empr}/logo.jpeg"
        Image logo = Image.getInstance(path);
        def longitud = logo.getHeight()
        logo.scalePercent( (100/longitud * 100).toInteger() )
        logo.setAlignment(Image.MIDDLE | Image.TEXTWRAP)

        def fondoTotal = new java.awt.Color(250, 250, 240);
        def baos = new ByteArrayOutputStream()
        def name = "pedidoExamenes_${paciente?.apellido}_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        def titulo = new java.awt.Color(40, 140, 180)
        com.lowagie.text.Font fontTitulo = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.BOLD, titulo);
        com.lowagie.text.Font fontThTiny = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontThTiny3 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontThTiny2 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font times8normal = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 8, com.lowagie.text.Font.NORMAL);
        def prmsHeaderHoja = [border: java.awt.Color.WHITE]

        Document document
        document = new Document(PageSize.A4);
        document.setMargins(50, 30, 30, 28)  //se 28 equivale a 1 cm: izq, derecha, arriba y abajo
        def pdfw = PdfWriter.getInstance(document, baos);
        com.lowagie.text.HeaderFooter footer1 = new com.lowagie.text.HeaderFooter(new Phrase("", times8normal), true);
        footer1.setBorder(Rectangle.NO_BORDER);
        footer1.setAlignment(Element.ALIGN_CENTER);
        document.setFooter(footer1);

        document.open();
        PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Pedido de Exámenes");
        document.addSubject("Generado por el sistema Médico");
        document.addKeywords("reporte, medico, receta");
        document.addAuthor("Médico");
        document.addCreator("Tedein SA");

        Paragraph preface = new Paragraph();
//        addEmptyLine(preface, 1);
        preface.setAlignment(Element.ALIGN_CENTER);
        preface.add(new Paragraph("PEDIDO DE EXÁMENES", fontTitulo));
        addEmptyLine(preface, 1);

        PdfPTable tablaImagen = new PdfPTable(1);
        tablaImagen.setWidthPercentage(100);
        tablaImagen.setWidths(arregloEnteros([100]))
        addCellTabla(tablaImagen, logo, [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        tablaImagen.setSpacingAfter(20f);

        PdfPTable tablaCabecera = new PdfPTable(4);
        tablaCabecera.setWidthPercentage(100);
        tablaCabecera.setWidths(arregloEnteros([20, 30, 20, 30]))

        addCellTabla(tablaCabecera, new Paragraph("NOMBRES: ", fontTitulo), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph(paciente?.nombre, fontThTiny), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph("APELLIDOS: ", fontTitulo), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph(paciente?.apellido, fontThTiny), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph("EDAD: ", fontTitulo), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph(edad?.toString(), fontThTiny), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph("SEXO: ", fontTitulo), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph(paciente?.sexo == 'F' ? 'Femenino' : 'Masculino', fontThTiny), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph("FECHA: ", fontTitulo), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph(cita?.fecha ? cita?.fecha?.format("dd-MM-yyyy") : new Date()?.format("dd-MM-yyy"), fontThTiny), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph("", fontThTiny), prmsHeaderHoja)
        addCellTabla(tablaCabecera, new Paragraph("", fontThTiny), prmsHeaderHoja)

        tablaCabecera.setSpacingAfter(10f);

        PdfPTable tablaDetalles = null
        def printHeaderDetalle = {
            def tablaHeaderDetalles = new PdfPTable(3);
            tablaHeaderDetalles.setWidthPercentage(100);
            tablaHeaderDetalles.setWidths(arregloEnteros([20, 20, 60]))

            addCellTabla(tablaHeaderDetalles, new Paragraph("Grupo", fontThTiny), [border: java.awt.Color.BLACK, bg: java.awt.Color.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph("Tipo", fontThTiny), [border: java.awt.Color.BLACK, bg: java.awt.Color.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])
            addCellTabla(tablaHeaderDetalles, new Paragraph("Examen", fontThTiny), [border: java.awt.Color.BLACK, bg: java.awt.Color.LIGHT_GRAY, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE])

            addCellTabla(tablaDetalles, tablaHeaderDetalles, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 3, pl: 0])
        }

        def printCitas = {
            def tablaCitas = new PdfPTable(3);
            tablaCitas.setWidthPercentage(100);
            tablaCitas.setWidths(arregloEnteros([20, 20, 60]))

            examenes.eachWithIndex {p, q->

                def tablaExamen = new PdfPTable(1);
                tablaExamen.setWidthPercentage(100);
                tablaExamen.setWidths(arregloEnteros([100]))

                addCellTabla(tablaCitas, new Paragraph(p?.tipoExamen?.grupoExamen?.descripcion, fontThTiny2), [border: java.awt.Color.BLACK, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])
                addCellTabla(tablaCitas, new Paragraph(p?.tipoExamen?.descripcion, fontThTiny2), [border: java.awt.Color.BLACK, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])

                DetalleExamen.findAllByExamenComplementario(p).each { e->
                    addCellTabla(tablaExamen, new Paragraph(e?.examen?.descripcion?.toString() + (p?.observaciones ? (" : " + p?.observaciones) : ''), fontThTiny2), [border: java.awt.Color.BLACK, bwb: 0.1, bcb: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP])
                }
                addCellTabla(tablaCitas, tablaExamen, [border: java.awt.Color.BLACK, align: Element.ALIGN_LEFT, valign: Element.ALIGN_TOP, colspan: 1, pl: 0])
                tablaCitas.setSpacingAfter(10f);
            }

            addCellTabla(tablaDetalles, tablaCitas, [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE, colspan: 3, pl: 0])

            tablaCitas.setSpacingAfter(10f);
        }

        PdfPTable tablaFirmas = new PdfPTable(3);
        tablaFirmas.setWidthPercentage(100);
        addCellTabla(tablaFirmas, new Paragraph(" ", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph(" ", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph(" ", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph(" ", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph(" ", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph(" ", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph("_____________________________", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph("", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph("", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph("AUTORIZACIÓN", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph("", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph("", fontThTiny2), prmsHeaderHoja)

        tablaDetalles = new PdfPTable(3);
        tablaDetalles.setWidthPercentage(100);
        tablaDetalles.setWidths(arregloEnteros([6, 20, 62]))
        tablaDetalles.setSpacingAfter(1f);

        document.add(tablaImagen)
        document.add(preface);
        document.add(tablaCabecera)
        printHeaderDetalle();
        printCitas();
        document.add(tablaDetalles)
        document.add(tablaFirmas);
        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def buscarPaciente_ajax(){

    }

    def tablaPacientes_ajax(){
        def cn = dbConnectionService.getConnection()
        def usuario = Persona.get(session.usuario?.id)
        def empresa = usuario.empresa

        def listaItems = ['pcntcdla', 'pcntapll', 'pcntnmbr']
        def bsca
        def sqlTx = ""
        def bscaEmp = empresa ? " and empr__id = ${empresa?.id}" : " "

        if (params.buscarPor) {
            bsca = listaItems[params.buscarPor?.toInteger() - 1]
        } else {
            bsca = listaItems[0]
        }

        def select = "select pcnt__id, pcntcdla, pcntapll, pcntpath, pcntnmbr, " +
                "replace( replace( replace(replace(age(now()::date, pcntfcna)::text, 'year', 'año'), 'mons','meses'), " +
                "'day', 'dia'), 'mon', 'mes') edad, " +
                "grsndscr, pcntmail, pcntantc from pcnt, grsn "

        def criterio = params.criterio
        def txwh = ""
        try {
            criterio = params.criterio.toInteger()
            txwh = " where grsn.grsn__id = pcnt.grsn__id and " +
                    "pcntcdla ilike '%${params.criterio}%'"
        } catch (e) {
            txwh = " where grsn.grsn__id = pcnt.grsn__id and " +
                    "(pcntnmbr ilike '%${criterio}%' or pcntapll ilike '%${criterio}%')"
        }
        sqlTx = "${select} ${txwh} ${bscaEmp} order by pcntapll limit 25".toString()
        def datos = cn.rows(sqlTx)

        [datos: datos]
    }

    def pedidoExamenImagen(){

        def cita = Historial.get(params.cita)
        def paciente = cita.paciente
        def grupoExamen = GrupoExamen.get(6)
        def tipoExamen = TipoExamen.findAllByGrupoExamen(grupoExamen)
        def examenes = ExamenComplementario.findAllByHistorialAndTipoExamenInList(cita, tipoExamen, [sort: "id"])

        def edad = calculaEdad( new Date().format('yyyy-MM-dd'), paciente?.fechaNacimiento?.format('yyyy-MM-dd'))
        def usuario = Persona.get(session.usuario?.id)
        def empr = usuario.empresa.id

        def path = "/var/medico/empresa/emp_${empr}/logo.jpeg"
        Image logo = Image.getInstance(path);
        def longitud = logo.getHeight()
        logo.scalePercent( (100/longitud * 100).toInteger() )
        logo.setAlignment(Image.MIDDLE | Image.TEXTWRAP)

        def fondoTotal = new java.awt.Color(250, 250, 240);
        def baos = new ByteArrayOutputStream()
        def name = "pedidoExamenesImagenes_${paciente?.apellido}_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        def titulo = new java.awt.Color(40, 140, 180)
        com.lowagie.text.Font fontTitulo = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 12, com.lowagie.text.Font.BOLD, titulo);
        com.lowagie.text.Font fontTitulo2 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.BOLD, titulo);
        com.lowagie.text.Font fontThTiny = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontThTiny3 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 9, com.lowagie.text.Font.BOLD);
        com.lowagie.text.Font fontThTiny2 = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 11, com.lowagie.text.Font.NORMAL);
        com.lowagie.text.Font times8normal = new com.lowagie.text.Font(com.lowagie.text.Font.TIMES_ROMAN, 8, com.lowagie.text.Font.NORMAL);
        def prmsHeaderHoja = [border: java.awt.Color.WHITE]
        def prmsCenter = [border: java.awt.Color.WHITE, align: Element.ALIGN_CENTER]
        def prmsLeft = [border: java.awt.Color.WHITE, align: Element.ALIGN_LEFT]

        Document document
        document = new Document(PageSize.A4);
        document.setMargins(50, 30, 30, 28)  //se 28 equivale a 1 cm: izq, derecha, arriba y abajo
        def pdfw = PdfWriter.getInstance(document, baos);
        com.lowagie.text.HeaderFooter footer1 = new com.lowagie.text.HeaderFooter(new Phrase("", times8normal), true);
        footer1.setBorder(Rectangle.NO_BORDER);
        footer1.setAlignment(Element.ALIGN_CENTER);
        document.setFooter(footer1);

        document.open();
        PdfContentByte cb = pdfw.getDirectContent();
        document.addTitle("Pedido de Exámenes Imágenes");
        document.addSubject("Generado por el sistema Médico");
        document.addKeywords("reporte, medico, receta");
        document.addAuthor("Médico");
        document.addCreator("Tedein SA");

        Paragraph preface = new Paragraph();
//        addEmptyLine(preface, 1);
        preface.setAlignment(Element.ALIGN_CENTER);
        preface.add(new Paragraph("PEDIDO DE EXÁMENES", fontTitulo));
        addEmptyLine(preface, 1);

        PdfPTable tablaImagen = new PdfPTable(1);
        tablaImagen.setWidthPercentage(100);
        tablaImagen.setWidths(arregloEnteros([100]))
        addCellTabla(tablaImagen, logo, [border: java.awt.Color.WHITE, bwb: 0.1, bcb: java.awt.Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE])
        tablaImagen.setSpacingAfter(20f);

        PdfPTable tablaDetalles = null
        PdfPTable tablaDatos = new PdfPTable(2);
        tablaDatos.setWidthPercentage(100);
        tablaDatos.setWidths(arregloEnteros([15, 85]))
        addCellTabla(tablaDatos, new Paragraph("FECHA:", fontTitulo), prmsLeft)
        addCellTabla(tablaDatos, new Paragraph(cita?.fecha ? cita?.fecha?.format("dd-MM-yyyy") : new Date()?.format("dd-MM-yyy"), fontThTiny), prmsLeft)

        addCellTabla(tablaDatos, new Paragraph("PACIENTE:", fontTitulo), prmsLeft)
        addCellTabla(tablaDatos, new Paragraph(paciente?.apellido + " " + paciente?.nombre , fontThTiny), prmsLeft)

        PdfPTable tablaDatos2 = new PdfPTable(4);
        tablaDatos2.setWidthPercentage(100);
        tablaDatos2.setWidths(arregloEnteros([15, 35, 15, 35]))

        addCellTabla(tablaDatos2, new Paragraph("EDAD:", fontTitulo), prmsLeft)
        addCellTabla(tablaDatos2, new Paragraph(edad?.toString(), fontThTiny), prmsLeft)
        addCellTabla(tablaDatos2, new Paragraph("C.I.:", fontTitulo), prmsLeft)
        addCellTabla(tablaDatos2, new Paragraph(paciente?.cedula, fontThTiny), prmsLeft)

        PdfPTable tablaCabeceraExamen = new PdfPTable(2);
        tablaCabeceraExamen.setWidthPercentage(100);
        tablaCabeceraExamen.setWidths(arregloEnteros([15, 85]))

        addCellTabla(tablaCabeceraExamen, new Paragraph("", fontTitulo), prmsLeft)
        addCellTabla(tablaCabeceraExamen, new Paragraph("", fontThTiny), prmsLeft)
        addCellTabla(tablaCabeceraExamen, new Paragraph("", fontTitulo), prmsLeft)
        addCellTabla(tablaCabeceraExamen, new Paragraph("", fontThTiny), prmsLeft)

        PdfPTable tablaExamen = new PdfPTable(3);
        tablaExamen.setWidthPercentage(100);
        tablaExamen.setWidths(arregloEnteros([17, 20, 63 ]))

        examenes.eachWithIndex {p, q->
            DetalleExamen.findAllByExamenComplementario(p).each { e->
                if(q == 0){
                    addCellTabla(tablaExamen, new Paragraph("EXAMEN:", fontTitulo), prmsLeft)
                }else{
                    addCellTabla(tablaExamen, new Paragraph("", fontThTiny2), prmsLeft)
                }
                addCellTabla(tablaExamen, new Paragraph(e?.examen?.descripcion?.toString(), fontThTiny2), prmsLeft)
                addCellTabla(tablaExamen, new Paragraph("", fontThTiny2), prmsLeft)
            }
        }

        PdfPTable tablaDatosClinicos = new PdfPTable(2);
        tablaDatosClinicos.setWidthPercentage(100);
        tablaDatosClinicos.setWidths(arregloEnteros([17, 83]))

        addCellTabla(tablaDatosClinicos, new Paragraph("", fontTitulo), prmsLeft)
        addCellTabla(tablaDatosClinicos, new Paragraph("", fontThTiny), prmsLeft)

        examenes.eachWithIndex {p, q->
            DetalleExamen.findAllByExamenComplementario(p).each { e->
                if(q == 0){
                    addCellTabla(tablaDatosClinicos, new Paragraph("DATOS CLÍNICOS:", fontTitulo), prmsLeft)
//                    addCellTabla(tablaDatosClinicos, new Paragraph("TIPO DE EXAMEN:", fontTitulo), prmsLeft)
                }else{
                    addCellTabla(tablaDatosClinicos, new Paragraph("", fontThTiny2), prmsLeft)
                }
                addCellTabla(tablaDatosClinicos, new Paragraph(  p?.datosClinicos ?  (e?.examen?.descripcion + " : " + p?.datosClinicos) : '', fontThTiny2), prmsLeft)
            }
        }

        tablaDatosClinicos.setSpacingBefore(25f);


        PdfPTable tablaDatosTipoExamen = new PdfPTable(2);
        tablaDatosTipoExamen.setWidthPercentage(100);
        tablaDatosTipoExamen.setWidths(arregloEnteros([17, 83]))

        addCellTabla(tablaDatosTipoExamen, new Paragraph("", fontTitulo), prmsLeft)
        addCellTabla(tablaDatosTipoExamen, new Paragraph("", fontThTiny), prmsLeft)

        examenes.eachWithIndex {p, q->
            DetalleExamen.findAllByExamenComplementario(p).each { e->
                if(q == 0){
                    addCellTabla(tablaDatosTipoExamen, new Paragraph("TIPO DE EXAMEN:", fontTitulo), prmsLeft)
                }else{
                    addCellTabla(tablaDatosTipoExamen, new Paragraph("", fontThTiny2), prmsLeft)
                }
                addCellTabla(tablaDatosTipoExamen, new Paragraph(  p?.datosTipoExamen ?  (e?.examen?.descripcion + " : " + p?.datosTipoExamen) : '', fontThTiny2), prmsLeft)
            }
        }

        tablaDatosTipoExamen.setSpacingBefore(25f);

        PdfPTable tablaObservaciones = new PdfPTable(2);
        tablaObservaciones.setWidthPercentage(100);
        tablaObservaciones.setWidths(arregloEnteros([17, 83]))

        addCellTabla(tablaObservaciones, new Paragraph("", fontTitulo), prmsLeft)
        addCellTabla(tablaObservaciones, new Paragraph("", fontThTiny), prmsLeft)

        examenes.eachWithIndex {p, q->
            DetalleExamen.findAllByExamenComplementario(p).each { e->
                if(q == 0){
                    addCellTabla(tablaObservaciones, new Paragraph("OBSERVACIONES:", fontTitulo2), prmsLeft)
//                    addCellTabla(tablaObservaciones, new Paragraph("DATOS CLÍNICOS:", fontTitulo2), prmsLeft)
                }else{
                    addCellTabla(tablaObservaciones, new Paragraph("", fontThTiny2), prmsLeft)
                }
                addCellTabla(tablaObservaciones, new Paragraph(  p?.observaciones ?  (e?.examen?.descripcion + " : " + p?.observaciones) : '', fontThTiny2), prmsLeft)
            }
        }

        tablaObservaciones.setSpacingAfter(80f);

        PdfPTable tablaFirmas = new PdfPTable(3);
        tablaFirmas.setWidthPercentage(100);

        addCellTabla(tablaFirmas, new Paragraph("______________________________", fontThTiny), prmsCenter)
        addCellTabla(tablaFirmas, new Paragraph("", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph("______________________________", fontThTiny), prmsCenter)

        addCellTabla(tablaFirmas, new Paragraph("Médico Solicitante", fontTitulo), prmsCenter)
        addCellTabla(tablaFirmas, new Paragraph("", fontThTiny2), prmsHeaderHoja)
        addCellTabla(tablaFirmas, new Paragraph("Teléfono/Celular", fontTitulo), prmsCenter)

        tablaDetalles = new PdfPTable(3);
        tablaDetalles.setWidthPercentage(100);
        tablaDetalles.setWidths(arregloEnteros([6, 20, 62]))
        tablaDetalles.setSpacingAfter(1f);

        document.add(tablaImagen)
        document.add(preface);
//        document.add(tablaCabecera)
//        printHeaderDetalle();
//        printCitas();
        document.add(tablaDetalles)
        document.add(tablaDatos);
        document.add(tablaDatos2);
        document.add(tablaCabeceraExamen);
        document.add(tablaExamen);
        document.add(tablaDatosTipoExamen);
        document.add(tablaDatosClinicos);
        document.add(tablaObservaciones);
        document.add(tablaFirmas);
        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def planCuentas_ajax(){

    }

    def gestorContable_ajax(){

    }

}
