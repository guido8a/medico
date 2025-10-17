<%@ page import="sri.TipoDocumentoPago" %>

<g:form class="form-horizontal" name="frmAuxiliar" role="form" controller="proceso" action="guardarAuxiliar_ajax" method="POST">
    <g:hiddenField name="asiento" value="${asiento?.id}"/>
    <g:hiddenField name="auxiliar" value="${auxiliar?.id}"/>
    <g:hiddenField name="comprobante" value="${comprobante?.id}"/>

    <div class="row">
        <div class="col-md-2">
            <label>Cuenta:</label>
        </div>
        <div class="col-md-3">
            <g:textField type="text" name="codigoAsiento" id="codigoAsiento" class="form-control" value="${asiento?.cuenta?.numero}" readonly=""
                         style="width: 100px"/>
        </div>
        <div class="col-md-5" style="margin-left: -45px">
            <g:textField type="text" name="nombreAsiento" id="nombreAsiento" class="form-control" value="${asiento?.cuenta?.descripcion}"
                         readonly=""  style="width: 360px" title="${asiento?.cuenta?.descripcion}"/>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
            <label>Descripción:</label>
        </div>
        <div class="col-md-10">
            <g:textField name="descripcion" id="descripcion" class="form-control required" required="" value="${auxiliar?.descripcion ?: ''}" readonly="${auxiliar ? true : false}"/>
        </div>
    </div>
    <div class="row">
        <div class="col-md-2">
            <label>Cliente:</label>
        </div>
        <div class="col-md-10">
            %{--        <g:select name="proveedor_name" id="proveedor" from="${proveedores}" class="form-control" optionValue="nombre" optionKey="id" style="width: 400px" value="${auxiliar?.paciente?.id}" disabled="${band ? false : true}"/>--}%
            <g:hiddenField name="paciente" value="${comprobante?.proceso?.paciente?.id}"/>
            <g:textField name="pacienteName" class="form-control" value="${comprobante?.proceso?.paciente?.apellido + " " + comprobante?.proceso?.paciente?.nombre}" readonly=""/>
        </div>
    </div>

%{--muestra la factura--}%
%{--<g:if test="${band3}">--}%
%{--    <div class="row">--}%
%{--        <div class="col-md-2">--}%
%{--            <label>Factura: </label>--}%
%{--        </div>--}%
%{--        <div class="col-md-10">--}%
%{--            <g:select name="factura_name" id="facturaAuxiliar" from="${res}" optionKey="${{it.axlr__id}}"--}%
%{--                      optionValue="${{it?.dcmt + ' - ' +  it?.dscr + ' - $ ' + it?.sldo}}" class="form-control porPagar"--}%
%{--                      value="${auxiliar?.afecta?.id}"/>--}%
%{--        </div>--}%
%{--    </div>--}%
%{--</g:if>--}%


    <div class="row">
        <div class="col-md-2">
            <label>Forma de Pago:</label>
        </div>
        <div class="col-md-6">
            <g:select name="tipoPago" from="${sri.TipoDocumentoPago.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion"
                      id="tipoPago" class="form-control required" required="" value="${auxiliar?.tipoDocumentoPago?.id}" />
        </div>
    </div>

    <div class="row">
        <div class="col-md-2">
            <label>Fecha de Pago:</label>
        </div>
        <div class="col-md-4">
            <input aria-label="" name="fechaPago" id='fechaPago' type='text' class="form-control" value="${auxiliar?.fechaPago?.format("dd-MM-yyyy") ?: new Date()?.format("dd-MM-yyyy")}" />
        </div>
    </div>

    <g:if test="${comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['C'] || band}">
        <div class="row">
            <div class="col-md-5">
                <label>Documento por pagar:</label>
            </div>
            <div class="col-md-6">
                <g:textField name="factura" id="factura" class="form-control" value="${auxiliar?.factura ?: ''}"/>
            </div>
        </div>
    </g:if>

    <g:if test="${comprobante?.proceso?.tipoProceso?.codigo?.trim() in ['P', 'I']}">
        <div class="row">
            <div class="col-md-5">
                <label>Documento con que se paga:</label>
            </div>
            <div class="col-md-6">
                <g:textField name="referencia" id="referencia" class="form-control" value="${auxiliar?.documento ?: ''}"/>
            </div>
        </div>
    </g:if>

    <div class="row">
        <div class="col-md-2">
            <label>Valor:</label>
        </div>
        <div class="col-md-10">
            <div class="col-md-2">Debe (CxC)</div>
            <div class="col-md-4">
                <g:textField type="number" name="debe" id="debe"
                             class="validacionNumero form-control valorP required" placeholder="${auxiliar ? auxiliar?.debe : maximoDebe}"
                             style="width: 120px;" value="${auxiliar ? auxiliar?.debe : maximoDebe}" />
            </div>
            <div class="col-md-2">Haber (CxP)</div>
            <div class="col-md-4">
                <g:textField type="number" name="haber" id="haber"
                             placeholder="${auxiliar ? auxiliar?.haber : maximoHaber}" class="validacionNumero form-control valorC required" style="width: 120px;"
                             value="${auxiliar ? auxiliar?.haber : (maximoHaber <= -1 ? 0 : maximoHaber)}" />
            </div>
        </div>
    </div>
</g:form>

<script type="text/javascript">

    $('#fechaPago').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    });

    function validarNum(ev) {
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39 ||
            ev.keyCode === 110 || ev.keyCode === 190);
    }

    $(".validacionNumero").keydown(function (ev) {
        return validarNum(ev);
    }).keyup(function () {

    });

</script>