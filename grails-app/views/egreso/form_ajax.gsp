<%@ page import="sri.TipoGasto" %>

<asset:javascript src="/Toggle-Button-Checkbox/js/bootstrap-checkbox.js"/>

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmEgreso" role="form" action="save_ajax" method="POST">
        <g:hiddenField name="id" value="${egresoInstance?.id}" />

        <div class="form-group keeptogether ${hasErrors(bean: egresoInstance, field: 'tipoGasto', 'error')} required">
            <span class="grupo">
                <label for="tipoGasto" class="col-md-2 control-label">
                    Tipo Gasto
                </label>
                <span class="col-md-6">
                    <g:select id="tipoGasto" name="tipoGasto.id" from="${sri.TipoGasto.list()}" optionKey="id"
                              required="" value="${egresoInstance?.tipoGasto?.id}" class="many-to-one form-control"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: egresoInstance, field: 'proveedor', 'error')} required">
            <span class="grupo">
                <label for="proveedor" class="col-md-2 control-label">
                    Proveedor
                </label>
                <span class="col-md-10">
                    <g:select id="proveedor" name="proveedor.id" from="${proveedores}" optionKey="id" required="" value="${egresoInstance?.proveedor?.id}" class="many-to-one form-control required"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: egresoInstance, field: 'descripcion', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label">
                    Concepto
                </label>
                <span class="col-md-10">
                    <g:textField name="descripcion" class="form-control required" required="" value="${egresoInstance?.descripcion}"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: egresoInstance, field: 'valor', 'error')} required">
            <span class="grupo">
                <label for="valor" class="col-md-2 control-label">
                    Valor
                </label>
                <span class="col-md-3">
                    <g:textField name="valor" value="${egresoInstance?.valor}" class="number form-control required"/>
                </span>
            </span>
            <span class="grupo">
                <label for="valor" class="col-md-2 control-label">
                    Factura
                </label>
                <span class="col-md-5">
                    <g:textField name="factura" value="${egresoInstance?.factura}" class="form-control required"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: egresoInstance, field: 'fecha', 'error')} required">
            <span class="grupo">
                <label for="fecha" class="col-md-2 control-label">
                    Fecha
                </label>
                <span class="col-md-4">
%{--                    <elm:datepicker name="fecha"  class="datepicker form-control required" value="${egresoInstance?.fecha}"  />--}%
                    <input name="fecha" id='fecha' type='text' class="form-control required" required="" value="${egresoInstance?.fecha?.format("dd-MM-yyyy") ?: new java.util.Date().format("dd-MM-yyyy")}"/>
                </span>
            </span>
        </div>
        <g:if test="${!pago}">
            <hr style="border: 1px solid #888; margin-top: 15px; margin-bottom: 15px">
            <div class="form-group keeptogether ${hasErrors(bean: egresoInstance, field: 'fechaPago', 'error')} required">
                <span class="grupo">
                    <label class="col-md-3 control-label text-info">
                        Generar pago a esta Fecha
                    </label>
                    <div class="col-md-3">
                        <input type="checkbox" name="pagar" id="pagarId" data-on-Label="Si" >
                    </div>
                </span>
                <span class="grupo">
                    <label class="col-md-3 control-label">
                        Pagado con caja chica
                    </label>
                    <div class="col-md-3">
                        %{--                        <input type="checkbox" name="pagar_CC" id="pagar_CC" data-on-Label="Si" checked="${empresaInstance?.obligadaContabilidad == '1' ?: false}">--}%
                        <input type="checkbox" name="pagar_CC_name" id="pagar_CC" data-on-Label="Si" >
                        %{--                        <g:select name="pagar_CC" from="${['N': 'No', 'S': 'Si']}" class="form-control" optionKey="key" optionValue="value"/>--}%
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: egresoInstance, field: 'fechaPago', 'error')} required">
                <span class="grupo">
                    <label class="col-md-2 control-label">
                        Cheque:
                    </label>
                    <div class="col-md-4">
                        <input type="text" name="pg_chqe" id="pg_chqe" class="form-control">
                    </div>
                </span>
                <span class="grupo">
                    <label class="col-md-2 control-label">
                        Comprobante
                    </label>
                    <div class="col-md-4">
                        <input type="text" name="pg_cmpr" id="pg_cmpr" class="form-control">
                    </div>
                </span>
            </div>
        </g:if>
    </g:form>
</div>

<script type="text/javascript">

    $(function () {
        $('#fecha').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            showClose: true,
            icons: {
                close: 'closeText'
            }
        });
    });

    $(function() {
        $("#pagarId, #pagar_CC").checkboxpicker({});
    });

    var validator = $("#frmEgreso").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }

    });
    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            submitFormNuevoEgreso();
            return false;
        }
        return true;
    });

</script>

