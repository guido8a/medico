<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmEgresoPago" role="form" action="guardarPagoEgreso_ajax" method="POST">
        <g:hiddenField name="id" value="${pago?.id}" />
        <g:hiddenField name="egreso" value="${egreso?.id}"/>

        <span class="grupo">
            <span class="col-md-12 control-label breadcrumb" style="text-align: center">
                <strong style="font-size: 14px !important;">Tipo de gasto: ${egreso?.tipoGasto?.descripcion}</strong> </br>
                <strong style="font-size: 14px !important;">Concepto:  ${egreso?.descripcion}</strong>
            </span>
        </span>

        <span class="grupo">
            <span class="col-md-12 control-label ${saldo == 0 ? 'alert-success':'alert-info'}" style="text-align: center">
                <strong style="font-size: 16px !important;">Saldo a pagar: <g:formatNumber number="${saldo}" format="##,##0" locale="en_US" maxFractionDigits="2" minFractionDigits="2"/> </strong>
            </span>
        </span>

        <div class="form-group keeptogether ${hasErrors(bean: pago, field: 'valor', 'error')} required" style="margin-top: 10px !important;">
            <span class="grupo">
                <label for="abono" class="col-md-3 control-label">
                    Valor del pago
                </label>
                <span class="col-md-3">
                    <g:textField name="abono" value="${pago?.valor}" class="number form-control required"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: pago, field: 'fechaPago', 'error')} required">
            <span class="grupo">
                <label for="fechaPago" class="col-md-3 control-label">
                    Fecha Pago
                </label>
                <span class="col-md-4">
%{--                    <elm:datepicker name="fechaPago" maxDate="${new Date()}" class="datepicker form-control required" value="${pago?.fechaPago}"  />--}%
                    <input name="fechaPago" id='fechaPago' type='text' class="form-control required" required="" value="${pago?.fechaPago?.format("dd-MM-yyyy") ?: new java.util.Date().format("dd-MM-yyyy")}"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: pago, field: 'documento', 'error')} ">
            <span class="grupo">
                <label for="documento" class="col-md-3 control-label">
                    Documento/Comp.
                </label>
                <span class="col-md-5">
                    <g:textField name="documento" class="allCaps form-control" value="${pago?.documento}"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: pago, field: 'documento', 'error')} ">
            <span class="grupo">
                <label for="cheque" class="col-md-3 control-label">
                    Cheque
                </label>
                <span class="col-md-5">
                    <g:textField name="cheque" class="allCaps form-control" value="${pago?.cheque}"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: pago, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label for="observaciones" class="col-md-3 control-label">
                    Observaciones
                </label>
                <span class="col-md-9">
                    <g:textField name="observaciones" class="form-control" value="${pago?.observaciones}"/>
                </span>
            </span>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: pago, field: 'cajaChica', 'error')} ">
            <span class="grupo">
                <label class="col-md-3 control-label">
                    Pagado con caja chica
                </label>
                <span class="col-md-2">
                    <g:select name="pagar_CC" from="${['N': 'No', 'S': 'Si']}" class="form-control" optionKey="key" optionValue="value" value="${pago?.cajaChica}"/>
                </span>
            </span>
        </div>

    </g:form>
</div>

<script type="text/javascript">


    $('#fechaPago').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        showClose: true,
        icons: {
            close: 'closeText'
        }
    });

    var validator = $("#frmEgresoPago").validate({
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
</script>

