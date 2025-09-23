
<g:form class="form-horizontal" name="frmTipo" role="form" controller="tipoMedico" action="saveTipo_ajax" method="POST">
    <g:hiddenField name="id" value="${tipo?.id}" />

    <div class="form-group ${hasErrors(bean: tipo, field: 'codigo', 'error')} required">
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Código
            </label>
            <span class="col-md-3">
                <g:textField name="codigo" maxlength="4" minlength="1" required="" class="form-control required text-uppercase"  value="${tipo?.codigo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: tipo, field: 'descripcion', 'error')} required">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="col-md-8">
                <g:textField name="descripcion" maxlength="63" minlength="3" required="" class="form-control required "  value="${tipo?.descripcion}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $("#frmTipo").validate({
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
            submitFormTipo();
            return false;
        }
        return true;
    });
</script>
