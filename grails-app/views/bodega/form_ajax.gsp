<g:form class="form-horizontal" name="frmBodega" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${bodega?.id}"/>
    <g:hiddenField name="empresa" value="${empresa?.id}"/>

    <div class="form-group">
        <span class="grupo">
            <label for="empresaName" class="col-md-2 control-label text-info">
                Empresa
            </label>
            <span class="col-md-8">
                <g:textField name="empresaName" class="form-control" readonly=""  value="${bodega?.empresa?.nombre ?: empresa?.nombre}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: bodega, field: 'tipo', 'error')} required">
        <span class="grupo">
            <label for="tipo" class="col-md-2 control-label text-info">
                Tipo
            </label>
            <span class="col-md-8">
                <g:textField name="tipo" class="form-control required" value="${bodega?.tipo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: bodega, field: 'nombre', 'error')} required">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <span class="col-md-8">
                <g:textField name="nombre" class="form-control required"  value="${bodega?.nombre}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: bodega, field: 'descripcion', 'error')}">
        <span class="grupo">
            <label for="descripcion" class="col-md-2 control-label text-info">
                Descripción
            </label>
            <span class="col-md-8">
                <g:textField name="descripcion" class="form-control"  value="${bodega?.descripcion}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: bodega, field: 'direccion', 'error')}">
        <span class="grupo">
            <label for="direccion" class="col-md-2 control-label text-info">
                Dirección
            </label>
            <span class="col-md-8">
                <g:textArea name="direccion" class="form-control"  value="${bodega?.direccion}" style="resize: none"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: bodega, field: 'telefono', 'error')}">
        <span class="grupo">
            <label for="telefono" class="col-md-2 control-label text-info">
                Teléfono
            </label>
            <span class="col-md-8">
                <g:textField name="telefono" class="form-control"  value="${bodega?.telefono}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">
    var validator = $("#frmBodega").validate({
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
