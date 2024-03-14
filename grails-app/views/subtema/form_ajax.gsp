<g:form class="form-horizontal" name="frmSubtema" role="form" controller="subtema" action="saveSubTema_ajax" method="POST">
    <g:hiddenField name="id" value="${subTema?.id}" />

    <div class="form-group ${hasErrors(bean: tema, field: 'nombre', 'error')} required">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Tema
            </label>
            <span class="col-md-8">
                <g:select name="tema" from="${medico.Tema.list([sort: 'nombre'])}" optionValue="nombre" optionKey="id" class="form-control" value="${subTema?.tema?.id}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: subTema, field: 'nombre', 'error')} required" style="margin-top: 10px">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="col-md-8">
                <g:textField name="nombre" maxlength="63" minlength="3" required="" class="form-control required "  value="${subTema?.nombre}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $("#frmSubtema").validate({
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
            submitFormSubTema();
            return false;
        }
        return true;
    });
</script>
