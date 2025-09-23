<g:form class="form-horizontal" name="frmMarca" role="form" action="saveMarca_ajax" method="POST">
    <g:hiddenField name="id" value="${marca?.id}"/>
    <g:hiddenField name="empresa" value="${empresa?.id}"/>

    <div class="form-group ${hasErrors(bean: marca, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Descripción
            </label>

            <span class="col-md-6">
                <g:textField name="descripcion" minlength="3" maxlength="31" required="" class="form-control required" value="${marca?.descripcion}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    var validator = $("#frmMarca").validate({
        errorClass: "help-block",
        errorPlacement: function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success: function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });
    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            submitFormMarca();
            return false;
        }
        return true;
    });

</script>