<%@ page import="geografia.Provincia" %>

<g:form class="form-horizontal" name="frmEmpresa" role="form" controller="empresa" action="saveEmpresa_ajax" method="POST">
    <g:hiddenField name="id" value="${empresa?.id}" />

    <div class="form-group ${hasErrors(bean: empresa, field: 'tipoEmpresa', 'error')} ">
        <span class="grupo">
            <label for="tipoEmpresa" class="col-md-2 control-label text-info">
                Tipo de Empresa
            </label>
            <span class="col-md-4">
                <g:select name="tipoEmpresa" from="${seguridad.TipoEmpresa.list()}" optionKey="id" optionValue="descripcion" class="form-control  " value="${empresa?.tipoEmpresa?.id}"/>
            </span>
        </span>
        <span class="grupo">
            <label for="tipoIdentificacion" class="col-md-2 control-label text-info">
                Tipo de Identificación
            </label>
            <span class="col-md-4">
                <g:select name="tipoIdentificacion" from="${seguridad.TipoIdentificacion.list()}" optionKey="id" optionValue="descripcion" class="form-control" value="${empresa?.tipoIdentificacion?.id}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'ruc', 'error')} required">
        <span class="grupo">
            <label for="ruc" class="col-md-2 control-label text-info">
                RUC
            </label>
            <span class="col-md-4">
                <g:textField name="ruc" maxlength="13" minlength="10" required="" class="form-control required allCaps"  value="${empresa?.ruc}"/>
            </span>
        </span>
        <span class="grupo">
            <label for="sigla" class="col-md-2 control-label text-info">
                Sigla
            </label>
            <span class="col-md-4">
                <g:textField name="sigla" maxlength="63" required="" class="form-control required allCaps" value="${empresa?.sigla}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'nombre', 'error')} required">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <span class="col-md-6">
                <g:textField name="nombre" maxlength="63" required="" class="form-control required" value="${empresa?.nombre}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'objeto', 'error')}">
        <span class="grupo">
            <label for="objeto" class="col-md-2 control-label text-info">
                Objeto
            </label>
            <span class="col-md-8">
                <g:textArea name="objeto" style="resize: none" maxlength="255" class="form-control" value="${empresa?.objeto}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'provincia', 'error')} ">
        <span class="grupo">
            <label for="provincia" class="col-md-2 control-label text-info">
                Provincia
            </label>
            <span class="col-md-4">
                <g:select name="provincia" from="${geografia.Provincia.list().sort{it.nombre}}" optionKey="id" optionValue="nombre" class="form-control" value="${empresa?.canton?.provincia?.id}"/>
            </span>
        </span>
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Cantón
            </label>
            <span class="col-md-4" id="divCanton">
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'direccion', 'error')}">
        <span class="grupo">
            <label for="direccion" class="col-md-2 control-label text-info">
                Dirección
            </label>
            <span class="col-md-8">
                <g:textField name="direccion" style="resize: none" maxlength="255" class="form-control" value="${empresa?.direccion}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'email', 'error')}">
        <span class="grupo">
            <label for="email" class="col-md-2 control-label text-info">
                Email
            </label>
            <span class="col-md-4">
                <g:textField name="email" maxlength="63" class="email mail form-control" value="${empresa?.mail}"/>
            </span>
        </span>
        <span class="grupo">
            <label for="telefono" class="col-md-2 control-label text-info">
                Teléfono
            </label>
            <span class="col-md-4">
                <g:textField name="telefono" maxlength="63" class="number form-control" value="${empresa?.telefono}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: empresa, field: 'observaciones', 'error')}">
        <span class="grupo">
            <label for="observaciones" class="col-md-2 control-label text-info">
                Observaciones
            </label>
            <span class="col-md-8">
                <g:textArea name="observaciones" style="resize: none" maxlength="255" class="form-control" value="${empresa?.observaciones}"/>
            </span>
        </span>
    </div>


</g:form>

<script type="text/javascript">

    $("#provincia").change(function () {
        var provincia = $(this).val();
        cargarCanton(provincia);
    });

    cargarCanton($("#provincia option:selected").val());

    function cargarCanton(provincia) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'empresa', action: 'canton_ajax')}',
            data:{
                id: '${empresa?.id}',
                provincia: provincia
            },
            success: function (msg) {
             $("#divCanton").html(msg)
            }
        });
    }


    $("#frmEmpresa").validate({
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
            submitFormEmpresa();
            return false;
        }
        return true;
    });
</script>
