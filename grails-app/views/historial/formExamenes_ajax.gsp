<%@ page import="medico.Examen" %>

<div class="span" role="main">
    <g:uploadForm class="form-horizontal" method="post" name="frmExamen" action="saveExamen_ajax">
        <g:hiddenField name="id" value="${examen?.id}"/>
        <g:hiddenField name="historial" value="${historial.id}"/>

        <div class="form-group ${hasErrors(bean: examen, field: 'fecha', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Fecha
                </label>
                <span class="col-md-4">
                    <input aria-label="" name="fechaExamen" id='fechaExamen' type='text' class="form-control" value="${examen?.fecha?.format("dd-MM-yyyy") ?: new Date()?.format("dd-MM-yyyy")}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'grupoExamen', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Grupo de examen
                </label>
                <span class="col-md-4">
                    <g:select name="grupoExamen" from="${medico.GrupoExamen.list().sort{it.descripcion}}" optionKey="id" class="form-control" value="${examen?.tipoExamen?.grupoExamen?.id}"
                              optionValue="descripcion"/>
                    <p class="help-block ui-helper-hidden"></p>
                </span>

                <div id="divTipoExamen">

                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Observaciones
                </label>
                <span class="col-md-9">
                    <g:textArea name="observaciones" maxlength="255" class="form-control" value="${examen?.observaciones}"  style="resize: none; height: 60px;" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>
    </g:uploadForm>
</div>

<script type="text/javascript">

    cargarTipoExamen($("#grupoExamen option:selected").val())

    $("#grupoExamen").change(function () {
        var grupo = $(this).val();
        cargarTipoExamen(grupo);
    });

    function cargarTipoExamen(grupo){
        var examen = '${examen?.id}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'examen', action: 'tipoExamen_ajax')}',
            data:{
                grupo: grupo,
                examen: examen
            },
            success: function (msg){
                $("#divTipoExamen").html(msg)
            }
        })
    }

    $('#fechaExamen').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        icons: {
        }
    });


    $("#frmExamen").validate({
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
            submitFormExamen();
            return false;
        }
        return true;
    });
</script>
