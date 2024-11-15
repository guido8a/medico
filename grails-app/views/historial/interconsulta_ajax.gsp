<%@ page import="seguridad.TipoPersona" %>
<g:form class="form-horizontal" name="frmInterconsulta" controller="historial" action="saveInterconsulta_ajax">
    <g:hiddenField name="id" value="${cita?.id}"/>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="medicoExterno" class="col-md-2 control-label text-info">
                Médico externo
            </label>
            <span class="col-md-6">
                <g:select name="medicoExterno" from="${seguridad.Persona.findAllByTipoPersona(seguridad.TipoPersona.findByCodigo('E'), [sort: 'apellido'])}" required="" optionKey="id" optionValue="${{it.apellido + " " + it.nombre}}" class="form-control required" value="${cita?.medicoExterno?.id}" />
            </span>
        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="motivoExterno" class="col-md-2 control-label text-info">
                Motivo Externo
            </label>
            <span class="col-md-8">
                <g:textArea name="motivoExterno" maxlength="255" class="form-control required-indicator" required="" style="resize: none; height: 100px"  value="${cita?.motivoExterno}"/>
            </span>

        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="informeExterno" class="col-md-2 control-label text-info">
                Informe Externo
            </label>
            <span class="col-md-8">
                <g:textArea name="informeExterno" maxlength="255"  class="form-control" style="resize: none; height: 100px" value="${cita?.informeExterno}"/>
            </span>
        </div>
    </div>
</g:form>

<script type="text/javascript">

    $("#frmInterconsulta").validate({
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
            submitFormInterconsulta();
            return false;
        }
        return true;
    });

</script>