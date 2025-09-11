<g:form class="form-horizontal" name="frmParametrosAuxiliares" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${parametrosAuxiliaresInstance?.id}" />

    <div class="form-group keeptogether ${hasErrors(bean: parametrosAuxiliaresInstance, field: 'iva', 'error')} required">
        <span class="grupo">
            <label for="iva" class="col-md-3 control-label text-info">
                IVA
            </label>
            <span class="col-md-3">
                <g:textField name="iva" class="number form-control required" value="${fieldValue(bean: parametrosAuxiliaresInstance, field: 'iva')}" required="" maxlength="2"/>
            </span>
        </span>
    </div>
    <div class="form-group keeptogether  ${hasErrors(bean: parametrosAuxiliaresInstance, field: 'fechaInicio', 'error')} required">
        <span class="grupo">
            <label for="datetimepicker1" class="col-md-3 control-label text-info">
                Fecha Desde
            </label>

            <span class="col-md-4">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control required" value="${parametrosAuxiliaresInstance?.fechaInicio?.format("dd-MM-yyyy")}"/>
            </span>

        </span>
    </div>
    <div class="form-group keeptogether  ${hasErrors(bean: parametrosAuxiliaresInstance, field: 'fechaFin', 'error')} ">
        <span class="grupo">
            <label for="datetimepicker2" class="col-md-3 control-label text-info">
                Fecha Hasta
            </label>

            <span class="col-md-4">
                <input name="fechaFin" id='datetimepicker2' type='text' class="form-control" value="${parametrosAuxiliaresInstance?.fechaFin?.format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $('#datetimepicker1, #datetimepicker2').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        showClose: true,
        icons: {
            close: 'closeText'
        }
    });

    var validator = $("#frmParametrosAuxiliares").validate({
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
            submitForm();
            return false;
        }
        return true;
    });
</script>

