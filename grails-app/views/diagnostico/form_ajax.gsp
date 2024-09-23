
<g:form class="form-horizontal" name="frmDiagnostico" role="form" controller="diagnostico" action="saveDiagnostico_ajax" method="POST">
    <g:hiddenField name="id" value="${diagnostico?.id}" />

    <div class="form-group ${hasErrors(bean: diagnostico, field: 'codigo', 'error')} required">
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Código
            </label>
            <span class="col-md-4">
                <g:textField name="codigo" maxlength="7" required="" class="form-control required allCaps" readonly="true"
                             value="${diagnostico?.codigo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: diagnostico, field: 'descripcion', 'error')} required">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="col-md-10">
                <g:textArea name="descripcion" style="resize: none" maxlength="255" minlenght="10" required="" class="form-control required" value="${diagnostico?.descripcion}"/>
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">

    $("#frmDiagnostico").validate({
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
            submitFormDiagnostico();
            return false;
        }
        return true;
    });
</script>
