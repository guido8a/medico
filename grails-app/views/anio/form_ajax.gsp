<g:form class="form-horizontal" name="frmAnio" role="form" action="save" method="POST">
    <g:hiddenField name="id" value="${anioInstance?.id}" />

    <div class="form-group ${hasErrors(bean: anioInstance, field: 'anio', 'error')} ">
        <span class="grupo">
            <label for="datetimepicker1" class="col-md-3 control-label text-info">
                Año
            </label>
            <span class="col-md-4">
                <input name="anio" id='datetimepicker1' type='text' class="digits form-control required" value="${anioInstance?.anio}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: anioInstance, field: 'sueldoBasico', 'error')} ">
        <span class="grupo">
            <label for="sueldoBasico" class="col-md-3 control-label text-info">
                Sueldo Básico
            </label>
            <span class="col-md-4">
                <g:textField name="sueldoBasico" required="" class="number form-control required" value="${anioInstance?.sueldoBasico}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $('#datetimepicker1').datetimepicker({
        locale: 'es',
        format: 'YYYY',
        showClose: true,
        icons: {
            close: 'closeText'
        }
    });

    var validator = $("#frmAnio").validate({
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
