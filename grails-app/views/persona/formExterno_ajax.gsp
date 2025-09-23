<%@ page import="seguridad.Prfl; seguridad.Persona" %>

<div class="modal-contenido">
    <g:form class="form-horizontal" name="frmPersona" role="form" controller="persona" action="savePersona_ajax" method="POST">
        <g:hiddenField name="id" value="${personaInstance?.id}"/>
        <g:hiddenField name="empresa" value="${seguridad.Empresa.get(1)?.id}"/>
        <g:hiddenField name="activo" value="${1}"/>
        <g:hiddenField name="discapacidad" value="${0}"/>
        <g:hiddenField name="login" value="${"externo" + adicional}"/>
        <g:hiddenField name="password" value="${"9999999999"}"/>
        <g:hiddenField name="autorizacion" value="${"9999999999"}"/>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'empresa', 'error')}">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="tipoPersona" class="col-md-4 control-label">
                        Tipo de usuario
                    </label>
                    <span class="col-md-8">
                        <g:select name="tipoPersona" from="${seguridad.TipoMedico.list().sort{it.descripcion}[1]}" optionKey="id" optionValue="descripcion"
                                  class="form-control input-sm" value="${personaInstance?.tipoPersona?.id}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} ${hasErrors(bean: personaInstance, field: 'apellido', 'error')} required">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="nombre" class="col-md-4 control-label">
                        Nombre
                    </label>
                    <span class="col-md-8">
                        <g:textField name="nombre" maxlength="40" minlength="3" required="" class="form-control input-sm required" value="${personaInstance?.nombre}"/>
                    </span>
                </span>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="apellido" class="col-md-4 control-label">
                        Apellido
                    </label>
                    <span class="col-md-8">
                        <g:textField name="apellido" maxlength="40" minlength="3" required="" class="form-control input-sm required" value="${personaInstance?.apellido}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'cedula', 'error')}">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="cedula" class="col-md-4 control-label">
                        Cédula
                    </label>

                    <span class="col-md-8">
                        <g:textField name="cedula" maxlength="10" minlength="10" class="form-control input-sm required digits" value="${personaInstance?.cedula}"/>
                    </span>
                </span>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="sexo" class="col-md-4 control-label">
                        Sexo
                    </label>

                    <span class="col-md-8">
                        <g:select name="sexo" from="${['F': 'Femenino', 'M': 'Masculino']}" required="" optionKey="key" optionValue="value"
                                  class="form-control input-sm required" value="${personaInstance?.sexo}"/>
                    </span>
                </span>
            </div>
        </div>

        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'mail', 'error')} ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} ">
            <div class="col-md-6">
                <span class="grupo">
                    <label for="mail" class="col-md-4 control-label">
                        E-mail
                    </label>

                    <span class="col-md-8">
                        <span class="input-group input-group-sm"><span class="input-group-addon"><i class="fa fa-envelope"></i>
                        </span><g:field type="email" name="mail" maxlength="63" class="form-control input-sm unique noEspacios" value="${personaInstance?.mail}"/>
                        </span>
                    </span>
                </span>
            </div>

            <div class="col-md-6">
                <span class="grupo">
                    <label for="telefono" class="col-md-4 control-label">
                        Teléfono
                    </label>

                    <div class="col-md-8">
                        <g:textField name="telefono" maxlength="31" class="form-control input-sm digits" value="${personaInstance?.telefono}"/>
                    </div>
                </span>
            </div>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'direccion', 'error')} ">
            <div class="col-md-12 ">
                <span class="grupo">
                    <label for="direccion" class="col-md-2 control-label">
                        Dirección
                    </label>

                    <div class="col-md-10">
                        <g:textArea name="direccion" cols="80" rows="1" maxlength="255" class="form-control input-sm" value="${personaInstance?.direccion}" style="resize: none"/>
                    </div>
                </span>
            </div>
        </div>
        <div class="form-group keeptogether ${hasErrors(bean: personaInstance, field: 'referencia', 'error')} ">
            <div class="col-md-12 ">
                <span class="grupo">
                    <label for="referencia" class="col-md-2 control-label">
                        Referencia
                    </label>
                    <div class="col-md-10">
                        <g:textArea name="referencia" cols="80" rows="1" maxlength="255" class="form-control input-sm" value="${personaInstance?.referencia}" style="resize: none"/>
                    </div>
                </span>
            </div>
        </div>
    </g:form>
</div>

<script type="text/javascript">
    var validator = $("#frmPersona").validate({
        errorClass    : "help-block",
        errorPlacement: function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success       : function (label) {
            label.parents(".grupo").removeClass('has-error');
            label.remove();
        }
    });

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            submitFormPersona();
            return false;
        }
        return true;
    });

</script>
