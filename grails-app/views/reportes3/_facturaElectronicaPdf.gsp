<html>
<head>
    <title></title>

    <style type="text/css">

    @page {
        size   : 21cm 29.7cm;/*  width height*/
        margin : 1.8cm;
    }

    .hoja {
        width      : 17cm;
    }

    .left {
        float      : left;
        min-height : 30px;
    }

    .right {
        float      : right;
        min-height : 30px;
    }

    table {
        font-size       : 11px;
        border-collapse : collapse;
    }

    .tr {
        text-align : right;
    }

    .tc {
        text-align : center;
    }

    .tl {
        text-align : left;
    }

    .borde{
        border-radius: 8px !important;
        border:1px solid black !important;
        border-collapse: separate !important;
        border: 0.3px solid grey !important;
        padding: 1px;
    }

    .borde2{
        border: 1px solid;
    }

    .pos{
        position: relative;
        top: 125px;
    }

    .letra{
        font-size: 10px;
    }

    .letra2{
        font-size: 10px;
    }

    .letra3{
        font-size: 10px;
    }

    .tam{
        padding: 3px;
    }

    .tam2{
        width: 90%;
    }

    .tam3{
        width: 40%;
    }

    .mar{
        margin-top: 10px;
    }

    .mar1{
        margin-top: 9px;
        font-size: 12pt;
    }
    .mar2{
        margin-top: 7px;
    }

    </style>
</head>

<body style="font-family: Helvetica Neue, Helvetica, Arial, sans-serif;">

<div class="hoja">

    <div style="height: 100px; width: 330px;" class="left">
        <div>
            <img alt="logo" src="${createLink(controller: 'reportes3', action: 'getLogo', params: [empresa:empresa?.id] )}" class="" width="290" height="100"/>
        </div>
    </div>

    <div style="height: 260px; width: 300px;" class="right borde" >
        <div style="font-size: 12px; margin-left: 5px">
            <div class="mar2"><strong>R.U.C.:</strong> ${empresa?.ruc ?: ''}</div>
            <div class="mar1"><strong>FACTURA</strong></div>
            <div class="mar1"><strong>N°.</strong> ${proceso?.documento ?: ''}</div>
            <div class="mar2 letra2"><strong>NÚMERO DE AUTORIZACIÓN:</strong></div>
            <div class="mar2 letra3"><strong>${proceso?.claveAcceso ?: ''}</strong></div>
            %{--            <div class="mar2 letra2">FECHA Y HORA DE AUTORIZACIÓN: ${proceso?.fechaAutorizacion?.format('dd/MM/yyyy HH:mm')} </div>--}%
            <div class="mar2 letra2"><strong>AMBIENTE :</strong> ${empresa?.ambiente == '0' ? 'PRUEBAS' : 'PRODUCCIÓN'}</div>
            <div class="mar2 letra2"><strong>EMISIÓN :</strong> NORMAL</div>
            <div class="mar2 letra2">CLAVE DE ACCESO</div>
            <g:if test="${proceso?.claveAcceso}">
            %{--                <div><g:img dir="reportes3" file="showBarcode?barcode=${proceso?.claveAcceso}" width="290" height="50"/></div>--}%
                <img alt="barras" src="${createLink(controller: 'reportes3', action: 'getImageCodigoBarras', params: [id: proceso?.id ,empresa:empresa?.id] )}" class="" width="290" height="50"/>
            %{--                <div><g:img dir="reportes3" file="showBarcode?barcode=${proceso?.claveAcceso}" width="290" height="50"/></div>--}%
            %{--                <div><asset:image src="reportes3/showBarcode?barcode=${proceso?.claveAcceso}"/></div>--}%
            %{--                <img alt="nada" src="${createLink(controller: 'reportes3', action: 'showBarcode', params: [bacode:proceso?.claveAcceso] )}" class="" style="width: 290px; height: 50px"/>--}%
            </g:if>
            <g:else>
                <div>No tiene clave de acceso</div>
            </g:else>
        </div>
    </div>

    <div style="height: 135px; width: 320px;" class="borde pos">
        <div class="left" style="margin-left: 5px; margin-top: 5px; font-size: 11px">
            <div class="mar1"><strong>${empresa?.nombre ?: ''}</strong></div>
            <div class="mar" style="margin-top: 5px;"><strong>Dirección Matriz:</strong> ${empresa?.direccion?.substring(0,40) ?: ''}</div>
            <div class="mar"><strong>Dirección Sucursal:</strong> ${empresa?.direccion?.substring(0,40) ?: ''}</div>
            <div class="mar"><strong>Contribuyente Régimen RIMPE</strong></div>
            <div class="mar"><strong>OBLIGADO A LLEVAR CONTABILIDAD:</strong> ${empresa?.obligadaContabilidad == '0' ? 'NO' : 'SI'}</div>
        </div>
    </div>

    <div style="height: 80px; width: 640px; margin-top: 140px" class="borde2">
        <div class="left">
            <table style="margin-left: 10px; margin-top: 10px">
                <tr class="" style="height: 20px;">
                    <td class="tl letra3" style="width: 350px"><strong>Razón Social / Nombres y Apellidos:</strong> ${proceso?.paciente?.nombre ?: ''}</td>
                    <td class="tl" style="width: 50px"></td>
                    <td class="tl letra3" style="width: 200px"><b>Identificación:</b> ${proceso?.paciente?.cedula ?: ''}</td>
                </tr>
                <tr class="" style="height: 20px; width: 600px">
                    <td class="tl letra3" style="width: 350px"><strong>Fecha de Emisión:</strong> <g:formatDate date="${proceso?.fechaEmision}" format="dd/MM/yyyy"/></td>
                    <td class="tl" style="width: 50px"></td>
                    <td class="tl letra3" style="width: 200px"><strong>Guía de Remisión:</strong></td>
                </tr>
                <tr class="" style="height: 20px; width: 600px">
                    <td class="tl letra3" style="width: 350px"><strong>Dirección: </strong>${proceso?.paciente?.direccion ?: ''}</td>
                    <td class="tl" style="width: 50px"></td>
                    <td class="tl" style="width: 200px"><strong>Teléfono: </strong> ${proceso?.paciente?.telefono ?: ''}</td>
                </tr>
            </table>
        </div>
    </div>

    <div style="margin-top: 15px; width: 100%">
        <table style="width: 100%">
            <thead>
            <tr>
                <th class="tc letra borde">Código</th>
                %{--<th class="tc letra borde">Cód. Auxiliar</th>--}%
                <th class="tc letra borde">Cant.</th>
                <th class="tc letra borde">Descripción</th>
                <th class="tc letra borde">Precio Unitario</th>
                <th class="tc letra borde">Descuento</th>
                <th class="tc letra borde">Precio Total</th>
            </tr>
            </thead>
            <tbody>
            <g:set value="${0}" var="total"/>
            <g:each in="${detalles}" var="detalle">
                <tr class="tc letra" style="width: 100%">
                    <td class="borde tc tl" style="width: 10%">${detalle?.producto?.numero ?: ''}</td>
                    %{--<td class="borde tl" style="width: 6%"></td>--}%
                    <td class="borde tc" style="width: 4%">${detalle?.cantidad?.toInteger() ?: 0}</td>
                    <td class="borde tl" style="width: 56%">${detalle?.producto?.texto ?: ''}</td>
                    <td class="borde tr" style="width: 10%"><g:formatNumber number="${detalle?.precioUnitario ?: 0}" maxFractionDigits="2" minFractionDigits="2"/></td>
                    <td class="borde tr" style="width: 10%"><g:formatNumber number="${detalle?.descuento ?: 0}" maxFractionDigits="2" minFractionDigits="2"/></td>
                    <td class="borde tr" style="width: 10%"><g:formatNumber number="${(detalle?.cantidad?.toInteger() ?: 0) * (detalle?.precioUnitario?.toDouble() ?: 0)}" maxFractionDigits="2" minFractionDigits="2"/></td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div style="height: 120px; width: 400px; margin-top: 10px" class="left borde" >
        <div style="margin-top: 10px; margin-left: 10px">Información Adicional</div>
        <div style="margin-top: 10px">
            <table style="margin-left: 5px">
                <tbody>
                <tr class="" style="height: 10px">
                    <td class="tl tam letra2"><strong>Email:</strong></td>
                    <td class="">${proceso?.paciente?.mail ?: 'Sin email registrado'}</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

    <table style="width: 230px; margin-top: 20px;" class="right">
        <thead>
        <tr>
            <td class="tr tam borde" style="width: 73%">SUBTOTAL IVA 15%</td>
            <td class="tr tam borde" style="width: 28%"><g:formatNumber number="${proceso?.baseImponibleIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="tr tam borde">SUBTOTAL IVA 0%</td>
            <td class="tr tam borde"><g:formatNumber number="${proceso?.baseImponibleIva0 ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="tr tam borde">SUBTOTAL NO OBJETO IVA</td>
            <td class="tr tam borde"><g:formatNumber number="${proceso?.baseImponibleNoIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="tr tam borde">SUBTOTAL EXENTO IVA</td>
            <td class="tr tam borde"><g:formatNumber number="${proceso?.excentoIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="tr tam borde">SUBTOTAL SIN IMPUESTOS</td>
            <td class="tr tam borde"><g:formatNumber number="${proceso?.baseImponibleIva ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="tr tam borde">DESCUENTOS</td>
            <td class="tr tam borde"><g:formatNumber number="${0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="tr tam borde">ICE</td>
            <td class="tr tam borde"><g:formatNumber number="${proceso?.iceGenerado ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="tr tam borde">IVA 15%</td>
            <td class="tr tam borde"><g:formatNumber number="${proceso?.ivaGenerado ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="tr tam borde">IRBPNR</td>
            <td class="tr tam borde"><g:formatNumber number="${0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="tr tam borde">PROPINA</td>
            <td class="tr tam borde"><g:formatNumber number="${0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
        </tr>
        <tr>
            <td class="tr tam borde"><strong>VALOR TOTAL</strong></td>
            <td class="tr tam borde"><strong><g:formatNumber number="${proceso?.valor ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></strong></td>
        </tr>

        </thead>
    </table>

    <table style="height: 60px; width: 400px; margin-top: 10px;" class="left">
        <thead>
        <tr>
            <th class="tc tam borde" style="width: 75%">Forma de Pago</th>
            <th class="tc borde" style="width: 25%">Valor</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${pagos}" var="pago">
            <tr>
                <td class="tl tam letra2 borde">${pago?.tipoPago?.descripcion?.toUpperCase() ?: ''}</td>
                <td class="tc borde"><g:formatNumber number="${pago?.valor ?: 0}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/></td>
            </tr>
        </g:each>
        </tbody>
    </table>

</div>
</body>
</html>