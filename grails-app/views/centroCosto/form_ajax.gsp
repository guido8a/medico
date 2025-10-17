
<g:form class="form-horizontal" name="frmCentroCosto" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${centroCostoInstance?.id}"/>
    <g:hiddenField name="empresa" value="${session.empresa.id}"/>

    <div class="form-group ${hasErrors(bean: centroCostoInstance, field: 'empresa', 'error')} required">
        <span class="grupo">
            <label for="empresa" class="col-md-2 control-label text-info">
                Empresa
            </label>
            <span class="col-md-6">
                <g:textField name="empresaName" class="form-control" value="${session.empresa}" readonly="true"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: centroCostoInstance, field: 'nombre', 'error')} required">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>

            <span class="col-md-6">
                <g:textField name="nombre" maxlength="127" required="" class="form-control required"
                             value="${centroCostoInstance?.nombre}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: centroCostoInstance, field: 'codigo', 'error')} required">
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Código
            </label>

            <span class="col-md-6">
                <g:textField name="codigo" maxlength="3" required="" class="form-control required allCaps"
                             value="${centroCostoInstance?.codigo}"/>
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">
    var validator = $("#frmCentroCosto").validate({
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
            submitForm();
            return false;
        }
        return true;
    });
</script>

