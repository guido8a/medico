<g:form class="form-horizontal" name="frmFormaDePago" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${formaDePagoInstance?.id}"/>

    <div class="form-group ${hasErrors(bean: formaDePagoInstance, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="col-md-6">
                <g:textField name="descripcion" maxlength="63" class="form-control required" value="${formaDePagoInstance?.descripcion}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">
    var validator = $("#frmFormaDePago").validate({
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