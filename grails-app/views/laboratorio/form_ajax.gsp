
<g:form class="form-horizontal" name="frmLabo" role="form" controller="laboratorio" action="saveLabo_ajax" method="POST">
    <g:hiddenField name="id" value="${laboratorio?.id}" />

    <div class="form-group ${hasErrors(bean: laboratorio, field: 'nombre', 'error')} required">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <span class="col-md-8">
                <g:textField name="nombre" maxlength="63" minlength="3" required="" class="form-control required "  value="${laboratorio?.nombre}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $("#frmLabo").validate({
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
            submitFormLabo();
            return false;
        }
        return true;
    });
</script>
