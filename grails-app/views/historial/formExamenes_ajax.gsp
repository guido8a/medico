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
                    <input aria-label="" name="fechaExamen" id='fechaExamen' type='text' class="form-control" value="${examen?.fecha?.format("dd-MM-yyyy")}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'examen', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Descripción del examen
                </label>
                <span class="col-md-10">
                    <g:select id="examen" name="examen" from="${medico.Examen.list()}" optionKey="id" class="form-control" value="${examen?.examen?.id}"
                              optionValue="descripcion"/>
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: examen, field: 'observaciones', 'error')} ">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Observaciones
                </label>
                <span class="col-md-10">
                    <g:textArea name="observaciones" maxlength="255" class="form-control" value="${examen?.observaciones}"  style="resize: none; height: 150px;" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>

%{--        <div class="form-group ${hasErrors(bean: examen, field: 'path', 'error')} ">--}%
%{--            <span class="grupo">--}%
%{--                <label class="col-md-2 control-label text-info">--}%
%{--                    Archivo--}%
%{--                </label>--}%
%{--                <span class="col-md-8">--}%
%{--                    <g:if test="${examen?.path}">--}%
%{--                        <span class="text-success">--}%
%{--                            ${examen?.path ? examen?.path : 'No se encuentra cargado ningún archivo' }--}%
%{--                        </span>--}%
%{--                    </g:if>--}%
%{--                    <g:else>--}%
%{--                        <input type="file" id="file" name="file" multiple accept=".jpeg, .jpg, .png, pdf"/>--}%
%{--                    </g:else>--}%
%{--                    <p class="help-block ui-helper-hidden"></p>--}%
%{--                </span>--}%
%{--            </span>--}%
%{--        </div>--}%

    </g:uploadForm>
</div>

<script type="text/javascript">

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
