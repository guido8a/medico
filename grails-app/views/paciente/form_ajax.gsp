<%@ page import="geografia.Provincia" %>

<g:form class="form-horizontal" name="frmPaciente" role="form" controller="paciente" action="savePaciente_ajax" method="POST">
    <g:hiddenField name="id" value="${paciente?.id}" />

    <div class="form-group ${hasErrors(bean: paciente, field: 'empresa', 'error')} ">
        <span class="grupo">
            <label for="empresa" class="col-md-2 control-label text-info">
                Empresa
            </label>
            <span class="col-md-4">
                <g:select name="empresa" from="${seguridad.Empresa.list().sort{it.nombre}}" optionKey="id" optionValue="nombre" class="form-control " value="${paciente?.empresa?.id}" noSelection="[null : 'Ninguna']"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'cedula', 'error')} required">
        <span class="grupo">
            <label for="cedula" class="col-md-2 control-label text-info">
                Cédula
            </label>
            <span class="col-md-4">
                <g:textField name="cedula" maxlength="10" minlength="10" required="" class="form-control required allCaps"  value="${paciente?.cedula}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'nombre', 'error')} required">
        <span class="grupo">
            <label for="apellido" class="col-md-2 control-label text-info">
                Apellido
            </label>
            <span class="col-md-4">
                <g:textField name="apellido" minlength="3" maxlength="31" required="" class="form-control required" value="${paciente?.apellido}"/>
            </span>
        </span>
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <span class="col-md-4">
                <g:textField name="nombre" minlength="3" maxlength="31" required="" class="form-control required" value="${paciente?.nombre}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'provincia', 'error')} ">
        <span class="col-md-2"></span>
        <span class="grupo">
            <span class="col-md-3">
                <label for="provincia" class="control-label text-info">
                    Provincia
                </label>
                <g:select name="provincia" from="${geografia.Provincia.list().sort{it.nombre}}" optionKey="id" optionValue="nombre" class="form-control" value="${paciente?.parroquia?.canton?.provincia?.id}"/>
            </span>
        </span>
        <span class="grupo">

            <span class="col-md-3" id="divCanton">
            </span>
        </span>
        <span class="grupo">

            <span class="col-md-3" id="divParroquia">
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'direccion', 'error')}">
        <span class="grupo">
            <label for="direccion" class="col-md-2 control-label text-info">
                Dirección
            </label>
            <span class="col-md-8">
                <g:textField name="direccion" style="resize: none" maxlength="255" class="form-control" value="${paciente?.direccion}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'referencia', 'error')}">
        <span class="grupo">
            <label for="referencia" class="col-md-2 control-label text-info">
                Referencia
            </label>
            <span class="col-md-8">
                <g:textField name="referencia" style="resize: none" maxlength="255" class="form-control" value="${paciente?.referencia}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'email', 'error')}">
        <span class="grupo">
            <label for="email" class="col-md-2 control-label text-info">
                Email
            </label>
            <span class="col-md-4">
                <g:textField name="mail" maxlength="63" class="email mail form-control" value="${paciente?.mail}"/>
            </span>
        </span>
        <span class="grupo">
            <label for="telefono" class="col-md-2 control-label text-info">
                Teléfono
            </label>
            <span class="col-md-4">
                <g:textField name="telefono" maxlength="31" class="number form-control" value="${paciente?.telefono}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'sexo', 'error')}">
        <span class="grupo">
            <label for="sexo" class="col-md-2 control-label text-info">
                Sexo
            </label>
            <span class="col-md-4">
                <g:select name="sexo" from="${['F' :  'FEMENINO', 'M' : 'MASCULINO']}" optionKey="key" optionValue="value" class="form-control" value="${paciente?.sexo}"/>
            </span>
        </span>
        <span class="grupo">
            <label  class="col-md-2 control-label text-info">
                Fecha de Nacimiento
            </label>
            <span class="col-md-4">
                <input aria-label="" name="fechaNacimiento" id='fechaNacimiento' type='text' class="form-control" value="${paciente?.fechaNacimiento?.format("dd-MM-yyyy")}" />
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'grupoSanguineo', 'error')} required">
         <span class="grupo">
            <label for="grupoSanguineo" class="col-md-2 control-label text-info">
                Grupo Sanguineo
            </label>
            <span class="col-md-4">
                <g:select name="grupoSanguineo" from="${medico.GrupoSanguineo.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" class="form-control " value="${paciente?.grupoSanguineo?.id}"/>
            </span>
        </span>
        <span class="grupo">
            <label for="activo" class="col-md-2 control-label text-info">
                Usuario Activo
            </label>
            <span class="col-md-4">
                <g:select name="activo" from="${[1 : 'ACTIVO', 0 : 'INACTIVO']}" optionKey="key" optionValue="value" class="form-control " value="${paciente?.activo}"/>
            </span>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: paciente, field: 'antecedentes', 'error')}">
        <span class="grupo">
            <label for="antecedentes" class="col-md-2 control-label text-info">
                Antecedentes
            </label>
            <span class="col-md-8">
                <g:textArea name="antecedentes" style="resize: none; height: 100px" maxlength="255" class="form-control" value="${paciente?.antecedentes}"/>
            </span>
        </span>
    </div>

</g:form>

<script type="text/javascript">

    $('#fechaNacimiento').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    });

    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            // ev.keyCode === 190 || ev.keyCode === 110 ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }


    $("#cedula, #telefono").keydown(function (ev) {
        return validarNum(ev);
    });

    $("#provincia").change(function () {
        var provincia = $(this).val();
        cargarCanton(provincia);
    });

    cargarCanton($("#provincia option:selected").val());

    function cargarCanton(provincia) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'canton_ajax')}',
            data:{
                id: '${paciente?.id}',
                provincia: provincia
            },
            success: function (msg) {
                $("#divCanton").html(msg)
            }
        });
    }

    $("#frmPaciente").validate({
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
            submitFormPaciente();
            return false;
        }
        return true;
    });
</script>
