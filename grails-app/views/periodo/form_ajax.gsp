
<g:form class="form-horizontal" name="frmPeriodo" action="save_ajax">
    <g:hiddenField name="id" value="${periodo?.id}"/>
    <div class="form-group ${hasErrors(bean: periodo, field: 'numero', 'error')} ">
        <span class="grupo">
            <label for="numeroName" class="col-md-2 control-label text-info">
                Número
            </label>
            <span class="col-md-4">
                <g:textField name="numeroName" value="${periodo?.numero ?: ultimoNumero}" class="form-control" readonly="" />
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: periodo, field: 'fechaDesde', 'error')} ">
        <span class="grupo">
            <label for="fechaInicio" class="col-md-2 control-label text-info">
                Fecha Desde
            </label>
            <span class="col-md-4">
                <input name="fechaInicio" id='fechaInicio' type='text' class="form-control required" value="${periodo?.fechaInicio?.format("dd-MM-yyyy") ?: new java.util.Date().format("dd-MM-yyyy")}"/>
                <p class="help-block ui-helper-hidden"></p>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: periodo, field: 'fechaHasta', 'error')} ">
        <span class="grupo">
            <label for="fechaFin" class="col-md-2 control-label text-info">
                Fecha Hasta
            </label>
            <span class="col-md-4">
                <input name="fechaFin" id='fechaFin' type='text' class="form-control required" value="${periodo?.fechaFin?.format("dd-MM-yyyy") ?: new java.util.Date().format("dd-MM-yyyy")}"/>
                <p class="help-block ui-helper-hidden"></p>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $('#fechaInicio').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        showClose: true,
        icons: {
        }
    });

    $('#fechaFin').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        showClose: true,
        icons: {
        }
    });

    var validator = $("#frmPeriodo").validate({
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
