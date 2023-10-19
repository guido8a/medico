
<g:form class="form-horizontal" name="frmMedicina" role="form" controller="medicina" action="saveMedicina_ajax" method="POST">
    <g:hiddenField name="id" value="${medicina?.id}" />

    <div class="form-group ${hasErrors(bean: medicina, field: 'tipo', 'error')} ">
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Tipo
            </label>
            <span class="col-md-2">
                <g:textField name="tipo" maxlength="4" class="form-control allCaps"  value="${medicina?.tipo}"/>
            </span>
        </span>
        <span class="col-md-1"></span>
        <span class="grupo">
            <label for="estado" class="col-md-2 control-label text-info">
                Estado
            </label>
            <span class="col-md-3">
                <g:select name="estado" class="form-control" from="${[1: 'Activo', 0: 'Inactivo']}" optionValue="value" optionKey="key" value="${medicina?.estado}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'codigo', 'error')} required">
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Código
            </label>
            <span class="col-md-4">
                <g:textField name="codigo" maxlength="15" required="" class="form-control required allCaps"  value="${medicina?.codigo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'descripcion', 'error')} required">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="col-md-8">
                <g:textField name="descripcion" maxlength="255" minlenght="10" required="" class="form-control required" value="${medicina?.descripcion}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'concentracion', 'error')} ">
        <span class="grupo">
            <label for="concentracion" class="col-md-2 control-label text-info">
                Concentración
            </label>
            <span class="col-md-6">
                <g:textField name="concentracion" maxlength="15" class="form-control" value="${medicina?.concentracion}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'firma', 'error')} ">
        <span class="grupo">
            <label for="firma" class="col-md-2 control-label text-info">
                Empresa
            </label>
            <span class="col-md-6">
                <g:textField name="firma" maxlength="255"  class="form-control" value="${medicina?.firma}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: medicina, field: 'observaciones', 'error')} ">
        <span class="grupo">
            <label for="observaciones" class="col-md-2 control-label text-info">
                Observaciones
            </label>
            <span class="col-md-8">
                <g:textArea name="observaciones" maxlength="255" style="resize: none"  class="form-control" value="${medicina?.observaciones}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">

    $("#frmMedicina").validate({
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
            submitFormMedicina();
            return false;
        }
        return true;
    });
</script>
