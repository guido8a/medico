
<g:form class="form-horizontal" name="frmTema" role="form" controller="tema" action="saveTema_ajax" method="POST">
    <g:hiddenField name="id" value="${tema?.id}" />

    <div class="form-group ${hasErrors(bean: tema, field: 'nombre', 'error')} required">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="col-md-8">
                <g:textField name="nombre" maxlength="63" minlength="3" required="" class="form-control required "  value="${tema?.nombre}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $("#frmTema").validate({
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
            submitFormTema();
            return false;
        }
        return true;
    });
</script>
