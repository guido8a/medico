<%@ page import="seguridad.TipoPersona" %>
<g:form class="form-horizontal" name="frmInterconsulta" controller="historial" action="saveInterconsulta_ajax">
    <g:hiddenField name="id" value="${cita?.id}"/>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label class="col-md-2 control-label text-info">
                Médico externo
            </label>
            <span class="col-md-6" id="divComboExterno">
                %{--                <g:select name="medicoExterno" from="${seguridad.Persona.findAllByTipoPersona(seguridad.TipoPersona.findByCodigo('E'), [sort: 'apellido'])}" required="" optionKey="id" optionValue="${{it.apellido + " " + it.nombre}}" class="form-control required" value="${cita?.medicoExterno?.id}" />--}%
            </span>
            <span class="col-md-2">
                <a href="#" class="btn btn-success" id="btnCrearMedico" title="Nueva médico externo">
                    <i class="fas fa-plus"></i> Nuevo Médico
                </a>
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

    cargarMedicoExterno();

    function cargarMedicoExterno(){
        $.ajax({
            type    : "POST",
            url     : '${createLink(controller: 'historial', action: 'comboExterno_ajax')}',
            data    : {
                id: '${cita?.id}'
            },
            success : function (msg) {
                $("#divComboExterno").html(msg)
            }
        })
    }

    $("#btnCrearMedico").click(function () {
        createEditMedico();
    });

    function createEditMedico() {
        $.ajax({
            type    : "POST",
            url     : '${createLink(controller: 'persona', action: 'formExterno_ajax')}',
            data    : {},
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    class   : "modal-lg",
                    title   : "Nuevo Médico ",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                return submitFormMedico();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    function submitFormMedico() {
        var $form = $("#frmPersona");
        if ($form.valid()) {
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'persona', action:'savePersona_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("_");
                    if (parts[0] === "ok") {
                        log(parts[1],"success");
                        cargarMedicoExterno();
                    } else {
                        log(parts[1], "error")
                    }
                }
            });
        } else {
            return false;
        } //else
    }

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